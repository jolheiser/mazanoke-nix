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
    port = lib.mkOption {
      type = lib.types.port;
      default = 6292;
      description = "Port to serve MAZANOKE on";
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.services.mazanoke = {
      description = "MAZANOKE image optimizer";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.darkhttpd} ${cfg.package}/share/mazanoke --port ${builtins.toString cfg.port}";
        Restart = "always";
        User = "mazanoke";
        Group = "mazanoke";
      };
    };
    users = {
      users.mazanoke = {
        isSystemUser = true;
        group = "mazanoke";
      };
      groups.mazanoke = { };
    };
  };
}
