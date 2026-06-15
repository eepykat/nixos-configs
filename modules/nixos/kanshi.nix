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
            { criteria = "DP-3"; status = "enable"; mode = "1920x1080@144"; }
        ];
        };
    };
    };
}