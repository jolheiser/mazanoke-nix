{
  pkgs ? import <nixpkgs> { },
}:
let
  mazanoke = pkgs.callPackage ./mazanoke.nix { inherit pkgs; };
in
{
  inherit mazanoke;
  default = mazanoke;
}
