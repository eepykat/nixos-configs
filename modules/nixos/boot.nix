{ config, lib, ... }:
{
    boot.loader.systemd-boot.enable = lib.mkDefault false;
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault false;
}

