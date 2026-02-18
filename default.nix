{ config, pkgs, lib, ... }:
{

  system.stateVersion = "25.11";


  imports =
    [
      ./hosts/t480s/hardware-configuration.nix
      ./modules/nixos/boot.nix
      ./modules/nixos/fish.nix
      ./modules/nixos/fonts.nix
      ./modules/nixos/greetd.nix
      ./modules/nixos/networking.nix
      ./modules/nixos/noctalia.nix
      ./modules/nixos/packages.nix
      ./modules/nixos/sound.nix
      ./modules/nixos/ssh.nix
      ./modules/nixos/starship.nix
      ./modules/nixos/misc.nix
      ./hosts/users.nix

    ];
}
