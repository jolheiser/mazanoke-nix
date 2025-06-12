{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      overlays.default = import ./overlay.nix;
      nixosModules.mazanoke = import ./module.nix;
      nixosModules.default = self.nixosModules.mazanoke;
      packages = forAllSystems (
        system: import ./default.nix { pkgs = import nixpkgs { inherit system; }; }
      );
      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          default = {
            type = "app";
            program = "${pkgs.writeShellScript "serve-mazanoke" ''
              PORT=''${1:-8080}
              ${pkgs.lib.getExe pkgs.darkhttpd} ${pkgs.mazanoke}/share/mazanoke --port $PORT
            ''}";
          };
        }
      );
    };
}
