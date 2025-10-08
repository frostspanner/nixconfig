{inputs, pkgs, ...}:
{
services.displayManager.cosmic-greeter.enable = true;
services.desktopManager.cosmic.enable = true;

  services.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.config.common.default = "*";
  #xdg.portal.extraPortals = with pkgs; [
    #xdg-desktop-portal-hyprland
  #  xdg-desktop-portal-gtk
  #];
imports = [
../../packages/desktop.nix
../../packages/dev.nix
];
environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    yt-dlp
];
}
