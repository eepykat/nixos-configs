  { config, pkgs, ... }:
{
    networking.networkmanager.enable = true;
    networking.hostName = "kat-t480s"; # Define your hostname.
    networking.firewall.allowedTCPPorts = [ 53317 ];
    networking.firewall.allowedUDPPorts = [ 53317 ];

}