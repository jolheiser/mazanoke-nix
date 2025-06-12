final: prev: {
  nixosModules = prev.nixosModules or { } // {
    mazanoke = import ./module.nix;
  };

  mazanoke = final.callPackage ./mazanoke.nix { };
}
