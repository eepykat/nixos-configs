{ pkgs, inputs, config, lib, ... }:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (lib.splitString " " cmd);
in
{
  programs.niri.enable = true;
  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];
    
    layout = {
      gaps = 16;
    };

    binds = with config.niri.lib.actions; {
      "Mod+Space".action.spawn = noctalia "launcher toggle";
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
}