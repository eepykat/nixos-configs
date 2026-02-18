{ pkgs, inputs, config, lib, ... }:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (lib.splitString " " cmd);
in
{

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];

    binds = with config.lib.niri.actions; {
      # Spawn using the helper
      "Mod+Space".action.spawn = noctalia "launcher toggle";
      "Mod+T".action.spawn = [ "kitty" ];
      "Mod+L".action.spawn = noctalia "lockScreen lock";
      
      # Window & Workspace Actions
      "Mod+Q".action.close-window = { };
      "Print".action.screenshot-window = { };
      "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = { };
      "Mod+Shift+Q".action.quit = { }; 
      "Mod+Left".action.focus-column-left = { };
      "Mod+Right".action.focus-column-right = { };      
      "Mod+Down".action.focus-workspace-down = { };
      "Mod+Up".action.focus-workspace-up = { };
    };

    outputs = {
      "eDP-1" = {
        enable = true;
        mode = { width = 1920; height = 1080; refresh = 60.0; };
        position = { x = 0; y = 0; };
      };
      "DP-3" = {
        scale = 1.0;
        mode = { width = 5120; height = 1440; refresh = 59.977; };
        position = { x = 1920; y = 0; };
      };
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
}
