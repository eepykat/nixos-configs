{ pkgs, inputs, lib, config, ... }: {
  # Required Home Manager settings
  home.username = "kat5";
  home.homeDirectory = lib.mkForce "/home/kat5";

  home.stateVersion = "24.11";

  imports = [
    inputs.catppuccin.homeModules.catppuccin 
  ];
  niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];
      layout = {
        gaps = 16;
      };
      binds = with config.niri.lib.actions; {
        "Mod+Space".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
        "Mod+T".action.spawn = [ "kitty" ];
        "Mod+L".action.spawn = [ "noctalia-shell" "lock" ];

        "Mod+Q".action.close-window = { };
        "Print".action.screenshot-window = { };
        "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = { };
        "Mod+Shift+Q".action.quit = { }; 
        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };      
        "Mod+Down".action.focus-workspace-down = { };
        "Mod+Up".action.focus-workspace-up = { };
      };

      input = {
        keyboard.xkb = {
          layout = "us";
          options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
        };
        touchpad = {
          tap = true;
          scroll-method = "two-finger";
          disabled-on-external-mouse = true;
        };
        warp-mouse-to-focus.enable = true;
      };
    };
  };

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
          { criteria = "eDP-1"; status = "enable"; }
          { criteria = "DP-3"; status = "enable"; mode = "1920x1080@144"; }
        ];
      }
    ];
  };

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