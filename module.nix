{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.mazanoke;
  pkg = pkgs.callPackage ./mazanoke.nix { inherit pkgs; };
in
{
  options.services.mazanoke = {
    enable = lib.mkEnableOption "MAZANOKE image optimizer service";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkg;
      description = "The MAZANOKE package";
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.services.mazanoke = {
      description = "MAZANOKE image optimizer";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceCfg = {
        ExecStart = "${pkgs.miniserve}/bin/miniserve --index index.html ${cfg.package}";
        Restart = "always";
        User = "mazanoke";
        Group = "mazanoke";
      };
    };
  };
}
