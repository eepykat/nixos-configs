{ inputs, ... }: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.autoEnable = true;
  catppuccin.enable = true;
  catppuccin.starship.enable = true;
  catppuccin.starship.flavor = "mocha";
}
