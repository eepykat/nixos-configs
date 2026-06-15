{ lib, pkgs, inputs, ... }:
let
  userImports = [ inputs.noctalia.homeModules.default ];
  userSettings = {
    programs.noctalia = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ./noctalia-settings.json);
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home-manager.users.kat5 = lib.mkMerge [
    { imports = userImports; }
    userSettings
  ];
}