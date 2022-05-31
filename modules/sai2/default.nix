# so this is a weird one, sai2 requires a device unique license file
# *next to the executable*, afaik there is no workaround.
# this obviously doesnt play nice with nix' immutable store
# so this has to require you to set up sai2 by yourself and then
# just point it at the executable, apart from piracy there's no real workaround :(

{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.programs.sai2;
in {
    options.programs.sai2 = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        executable = mkOption {
            type = types.str;
        };

        winePackage = mkOption {
            type = types.package;
            default = pkgs.wineWowPackages.stable;
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [
            (pkgs.makeDesktopItem {
                name = "sai2";
                desktopName = "Paint Tool Sai 2";
                exec = "${cfg.winePackage}/bin/wine ${cfg.executable}";
                categories = [ "Art" "Graphics" ];
                icon = ./sai2.png;
            })
        ];
    };
}
