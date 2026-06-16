{ config, pkgs, ... }:
{
  users.users.kat5 = {
    isSystemUser = false;
    isNormalUser = true;
    description = "Katarina";
    group = "kat5";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [];
  };
  users.groups.kat5 = {};
}