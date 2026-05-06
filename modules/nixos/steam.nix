{ config, pkgs, ... }:
{
    hardware.graphics.enable = true;
    programs.steam = {
        enable = true;
        package = pkgs.steam.override {
            extraArgs = "-system-composer";
        };
    };
}