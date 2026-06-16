{ pkgs, inputs, lib, config, ... }: {
  # Required Home Manager settings
  home.username = "kat5";
  home.homeDirectory = lib.mkForce "/home/kat5";

  home.stateVersion = "24.11";

  imports = [
    inputs.catppuccin.homeModules.catppuccin 
    ../modules/nixos/niri.nix
  ];

  services.kanshi = {
    enable = true;
    systemdTarget = "niri.service"; 
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          { criteria = "eDP-1"; status = "enable"; }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          { criteria = "eDP-1"; status = "disable"; }
          { criteria = "DP-3"; status = "enable"; mode = "1920x1080@144"; }
        ];
      }
    ];
  };

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

  catppuccin.autoEnable = true;
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
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };
}