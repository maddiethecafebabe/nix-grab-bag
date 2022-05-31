{
  description = "My nix grab bag";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs }:
  let
    system = "x86_64-linux";

    lib = nixpkgs.lib // {
      grab-bag = import ./lib { lib = inputs.nixpkgs.lib; };
    };
    
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ ];
    };
  in {
    overlays.default = final: prev: import ./packages { inherit pkgs lib; };
  };
}