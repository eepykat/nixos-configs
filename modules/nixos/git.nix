{ pkgs, ... }: {
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "kat";
        email = "168898505+eepykat@users.noreply.github.com";
        
      };
      init.defaultBranch = "main";
    };
  };
}