{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/desktop.nix
    ];

  networking.hostName = "kat-t480s";
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  networking.networkmanager.enable = true;

  # Desktop-specific services (greetd, niri, etc.) are provided by desktop.nix.
}
