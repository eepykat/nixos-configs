{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  networking.firewall.enable = true;

  programs.ssh.extraConfig = ''
    Host github.com
      IdentityFile /home/kat5/.ssh/github-eepykat
  '';
}
