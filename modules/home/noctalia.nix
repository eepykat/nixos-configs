{ pkgs, inputs, ... }:
{
  home-manager.users.kat5 = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ./noctalia-settings.json);
    };
  };
}