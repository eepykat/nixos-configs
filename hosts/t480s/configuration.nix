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

  # Cellular
  networking.modemmanager.enable = true;
  netkit = {
    xmm7360 = {
      enable = true;
      autoStart = true;
      package = config.boot.kernelPackages.xmm7360-pci;
      config.mycard = {
        apn = "internet.tele2.lt";
        nodefaultroute = true;
        noresolv = true;
      };
    };
  };
  systemd.services.xmm7360 = {
    serviceConfig = {
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_NETLINK" "AF_PACKET" ];
      ProtectSystem = "true";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = false;
      NoNewPrivileges = true;
      ProtectControlGroups = true;
      ProtectKernelModules = true;
      RestrictRealtime = true;
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
      autostart = true;
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