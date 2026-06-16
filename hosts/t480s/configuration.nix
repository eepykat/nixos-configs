{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  networking.hostName = "kat-t480s";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}