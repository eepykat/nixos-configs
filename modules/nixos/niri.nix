{ pkgs, inputs, config, lib, ... }:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (lib.splitString " " cmd);
  
  actions = config.lib.niri.actions;
in
{
  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];

    binds = {
      "Mod+Space".action = actions.spawn noctalia "launcher toggle";
      "Mod+T".action = actions.spawn [ "kitty" ];
      "Mod+L".action = actions.spawn noctalia "lockScreen lock";

      "Mod+Q".action = actions.close-window { };
      "Print".action = actions.screenshot-window { };
      "Mod+Escape".action = actions.toggle-keyboard-shortcuts-inhibit { };
      "Mod+Shift+Q".action = actions.quit { }; 
      "Mod+Left".action = actions.focus-column-left { };
      "Mod+Right".action = actions.focus-column-right { };      
      "Mod+Down".action = actions.focus-workspace-down { };
      "Mod+Up".action = actions.focus-workspace-up { };
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
      warp-mouse-to-focus = true;
    };
  };
}