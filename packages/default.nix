final: prev: {
    MagicaVoxel = final.callPackage ./MagicaVoxel.nix {};
    sai2 = final.callPackage ./sai2 {};
    activate-linux = final.callPackage ./activate-linux {};
}
