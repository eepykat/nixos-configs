{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "niri.service"; 
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          { criteria = "eDP-1"; status = "enable"; }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          { criteria = "eDP-1"; status = "enable"; }
          { criteria = "DP-3"; status = "enable"; mode = "1920x1080@144"; }
        ];
      }
    ];
  };
}
