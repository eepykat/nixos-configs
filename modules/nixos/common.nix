{ config, lib, pkgs, ... }:
{
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./boot.nix
      ./git.nix
      ./packages-common.nix
      ./sound.nix
      ./ssh.nix
      ./shell.nix
      ./networking.nix
      ./podman.nix
    ];
}
