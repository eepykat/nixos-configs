{ lib, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = (lib.importTOML ../../assets/starship-presets/catppuccin-powerline.toml) // {
      palette = "catppuccin_mocha";
      command_timeout = 1300;
      scan_timeout = 50;
    };
  };
}
