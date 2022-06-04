{
  description = "My nix grab bag";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs }:
  let
    lib = nixpkgs.lib // {
      grab-bag = import ./lib { lib = inputs.nixpkgs.lib; };
    };

    inherit (nixpkgs.lib) genAttrs;
    
    supportedSystems = [ "x86_64-linux" ];

    mkSystem = system: import ./packages {
      inherit inputs;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    overlays.default = final: prev:
      import ./pkgs {
        inherit inputs;
        pkgs = prev;
    };

    packages = genAttrs supportedSystems mkSystem;

    nixosModules.default = import ./modules;
  };
}
