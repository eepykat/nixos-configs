{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    btop
    usbutils
  ];
}
