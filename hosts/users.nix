
{ config, pkgs, ... }:
{
  users.users.kat5 = {
    isNormalUser = true;
    description = "Katarina";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
