{ pkgs, inputs, config, lib, ... }:
{
    services.kanshi = {
    enable = true;
    profiles = {
        undocked = {
        outputs = [ { criteria = "eDP-1"; status = "enable"; } ];
        };
        docked = {
        outputs = [
            { criteria = "eDP-1"; status = "disable"; }
            { criteria = "DP-3"; status = "enable"; mode = "5120x1440@59.977"; }
            { criteria = "DP-4"; status = "enable"; mode = "5120x1440@59.977"; }
            { criteria = "DP-5"; status = "enable"; mode = "5120x1440@59.977"; }
            { criteria = "DP-6"; status = "enable"; mode = "5120x1440@59.977"; }
            { criteria = "DP-7"; status = "enable"; mode = "5120x1440@59.977"; }
        ];
        };
    };
    };
}