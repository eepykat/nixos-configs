{ ... }: {
  programs.swaylock = {
    enable = false;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };
}
