{ config, pkgs, lib, ... }:
{

  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./hosts/users.nix
    ];
}
