{ pkgs, lib, config, grab-bag, ... }: 
with lib;
let
    cfg = config.hardware.homebrew.udpih;
in {
    options.hardware.homebrew.udpih = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        kernelPackage = mkOption {
            type = types.package;
            default = config.boot.kernelPackages.kernel;
        };
    };

    config = mkIf cfg.enable {
        boot.extraModulePackages = [ (grab-bag.udpih.override {
            kernel = cfg.kernelPackage;
            inherit (cfg.kernelPackage) stdenv;
        }) ];
        boot.kernelModules = [ "udpih" ];
    };
}
