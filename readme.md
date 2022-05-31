# maddie's nix grab bag
just a personal collection of packages/modules that are unlikely to be
merged ever. 

<details><summary>Installation for flakes</summary>

```nix
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    grab-bag = {
      url = "github:maddiethecafebabe/nix-grab-bag";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, grab-bag }:
  let
    inherit (nixpkgs.lib) nixosSystem;

    system = "x86_64-linux";

    overlays = {
      nixpkgs.overlays = [
        (final: prev: {
          grab-bag = grab-bag.overlays.default final prev;
        })
      ];
    };
  in {
    nixosConfigurations = {
      mySystem = nixosSystem {
        inherit system;
        modules = [ overlays (grab-bag.nixosModules.default) ];

        # ...
      };
    };
  };
}
```

</details>

You can then install packages in either `home.packages` or globally
```nix
{ home, pkgs, ... }: 

{
    home.packages = with pkgs; [
        grab-bag.MagicaVoxel
        (grab-bar.sai2.override { executable = "/home/mads/sai2/sai2.exe"; })
    ];
}
```
or
```nix
{ pgks, ... }:

{
    environment.systemPackages = with pkgs; [ grab-bag.MagicaVoxel ];

    services.activate-linux.enable = true;
}
```
