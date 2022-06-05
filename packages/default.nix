{ pkgs, ... }:
let
    inherit (pkgs) callPackage;
in {
    MagicaVoxel = callPackage ./MagicaVoxel.nix {};
    sai2 = callPackage ./sai2 {};
    fusee-nano = callPackage ./fusee-nano {};
    activate-linux = callPackage ./activate-linux {};
}
