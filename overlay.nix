final: prev: {
  nixosModules = prev.nixosModules or { } // {
    mazanoke = import ./module.nix;
  };
}
