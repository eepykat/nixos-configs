{ pkgs, inputs, ... }:
{

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];

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