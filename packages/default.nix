{ pkgs, ... }:
let
    inherit (pkgs) callPackage;
in {
    MagicaVoxel = callPackage ./MagicaVoxel.nix {};
    sai2 = callPackage ./sai2 {};
    activate-linux = callPackage ./activate-linux {};
}
