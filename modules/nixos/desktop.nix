{ config, pkgs, lib, ... }:
{
  imports = [
    ./common.nix
    ./greetd.nix
    ./noctalia.nix
    ./steam.nix
    ./fonts.nix
    ./starship.nix
    ./packages-desktop.nix
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Desktop-specific helpers and portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gnome" ];
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  services.gvfs.enable = true;
  services.dbus.packages = [ pkgs.nautilus pkgs.gcr ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.pam.services.swaylock = {};
}
