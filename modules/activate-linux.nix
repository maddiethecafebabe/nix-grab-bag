{ pkgs, lib, config, ... }: 
with lib;
let
    cfg = config.services.activate-linux;
in {
    options.services.activate-linux = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = "Displays a watermark to activate linux";
        };

        package = mkOption {
            type = types.package;
            default = pkgs.grab-bag.activate-linux;
        };
    };

    config = mkIf cfg.enable {
        systemd.user.services.activate-linux = mkIf cfg.enable {
            description = "The \"Activate Windows\" watermark, now for linux";
            wantedBy = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];

            serviceConfig = {
                Type = "simple";
                ExecStart = "${cfg.package}/bin/activate-linux";
                Restart = "always";
            };
        };
    };
}
