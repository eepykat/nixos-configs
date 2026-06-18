{ lib, ... }: {
  # Required Home Manager settings
  home.username = "kat5";
  home.homeDirectory = lib.mkForce "/home/kat5";

  home.stateVersion = "24.11";

  imports = [
    ../modules/home/catppuccin.nix
    ../modules/home/niri.nix
    ../modules/home/kanshi.nix
    ../modules/home/shell.nix
    ../modules/home/swaylock.nix
    ../modules/home/kitty.nix
  ];
}