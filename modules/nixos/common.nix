{ config, lib, pkgs, ... }:
{
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./boot.nix
      ./fonts.nix
      ./git.nix
      ./packages-common.nix
      ./sound.nix
      ./ssh.nix
      ./starship.nix
      ./misc.nix
      ./podman.nix
    ];
}
