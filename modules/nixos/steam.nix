{ config, pkgs, ... }:
{
    hardware.graphics.enable = true;
    programs.steam = {
        enable = true;
        package = {
            pkgs.millennium-steam {
                extraArgs = "-system-composer";
            }
        } 
    };
}