system: { pkgs, ... }:
let
    inherit (pkgs) callPackage;
    inherit (pkgs.lib) recursiveUpdate optionalAttrs;

    all = {
        fusee-nano = callPackage ./fusee-nano {};
        activate-linux = callPackage ./activate-linux {};
        udpih = callPackage ./udpih {};
    };

    x86_64 = optionalAttrs (system == "x86_64-linux") {
        MagicaVoxel = callPackage ./MagicaVoxel.nix {};
        sai2 = callPackage ./sai2 {};
    };

    aarch64 = optionalAttrs (system == "aarch64-linux") {

    };
in recursiveUpdate all (
    recursiveUpdate x86_64 aarch64
)
