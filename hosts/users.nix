
{ config, pkgs, ... }:
{
  users.users.kat5 = {
    isNormalUser = true;
    description = "Katarina";
    group = "kat5";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
