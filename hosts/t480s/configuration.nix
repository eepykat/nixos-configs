{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";


  
  boot.kernelModules = [ "iosm" ];
  boot.kernelParams = [ "iosm.bcl_mode=1" "intel_iommu=on" "iommu=pt" ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x7360", RUN+="${pkgs.bash}/bin/bash -c 'echo 0x8086 0x7360 > /sys/bus/pci/drivers/iosm/new_id'"
  '';

  networking.hostName = "kat-t480s";
  networking.networkmanager.enable = true;

  # Cellular
  networking.modemmanager.enable = true;

  netkit = {
    xmm7360 = {
      enable = true;
      autoStart = true;
      config = ''
        [mycard]
        apn = internet.tele2.lt
        nodefaultroute = false
        noresolv = true
      '';
      package = pkgs.netkit.xmm7360-pci_latest;
    };
  };

# Firewall
  networking.firewall = {
    enable = true;

    # wwan rules
    interfaces."wwan*".allowedTCPPorts = [];
    interfaces."wwan*".allowedUDPPorts = [];

  };

  #VPN
  networking.wg-quick.interfaces = {
    home = {
      configFile = "/home/kat5/.wireguard/home.conf";
      autostart = false;
    };
    lithuania = {
      configFile = "/home/kat5/.wireguard/lithuania.conf";
      autostart = false;
    };
    iceland = {
      configFile = "/home/kat5/.wireguard/iceland.conf";
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