{ config, pkgs, lib, ... }:
{
  imports =
    [
      ../../modules/nixos/common.nix
    ];

  networking.hostName = "generic-server";
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ ];
}
