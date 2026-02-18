{ pkgs, inputs, lib, ... }: {
  # Required Home Manager settings
  home.username = "cat5";
  home.homeDirectory = lib.mkForce "/home/cat5";


  home.stateVersion = "24.11";

  # Your Starship Configuration
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = (lib.importTOML ../assets/starship-presets/catppuccin-powerline.toml) // {
      palette = "catppuccin_mocha";
      command_timeout = 1300;
      scan_timeout = 50;
    };
  };
  catppuccin.enable = true;
  catppuccin.starship.enable = true;
  catppuccin.starship.flavor = "mocha";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.swaylock = {
    enable = false;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };


  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font"; # Case sensitive
      size = 11;
    };
  };

  imports = [
    ../modules/nixos/niri.nix
    inputs.catppuccin.homeModules.catppuccin 
 ];
}
