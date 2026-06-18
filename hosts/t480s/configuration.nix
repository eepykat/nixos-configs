{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "kat-t480s";
  networking.networkmanager.enable = true;
#  networking.firewall.allowedTCPPorts = [ 53317 ];
#  networking.firewall.allowedUDPPorts = [ 53317 ];

  #VPN
  networking.wg-quick.interfaces = {
    home = {
      configFile = "/etc/nixos/wireguard/home.conf";
      autostart = false;
    };
    lithuania = {
      configFile = "/etc/nixos/wireguard/lithuania.conf";
      autostart = true;
    };
    iceland = {
      configFile = "/etc/nixos/wireguard/iceland.conf";
      autostart = false;
    };
  };
  networking.firewall.checkReversePath = false;

  # Aditional Hardware
  hardware.bluetooth.enable = false; # Bluetooth is bad for you >:C

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}