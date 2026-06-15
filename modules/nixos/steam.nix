{ config, pkgs, ... }:
{
    hardware.graphics.enable = true;
    programs.steam = {
        enable = true;
        package = {
            pkgs.millennium-steam;
            package = pkgs.steam.override {
                extraArgs = "-system-composer";
            };
        } 
    };
}