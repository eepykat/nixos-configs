{ config, pkgs, ... }:
{
    time.timeZone = "America/Los_Angeles";

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" ];

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    security.pam.services.swaylock = {};

    # Portals
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
}