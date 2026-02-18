  { config, pkgs, ... }:
{
    networking.networkmanager.enable = true;
    networking.hostName = "kat-t480s"; # Define your hostname.
}