{
  pkgs,
  inputs,
  ...
}: let
  a = with pkgs; [
    haruna
  ];
  b = with pkgs.kdePackages; [
    plasma-browser-integration
    qtstyleplugin-kvantum
    sddm-kcm
    dolphin
    konsole
    kcolorchooser
    kolourpaint
  ];
in {
  services.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.config.common.default = "*";
  #xdg.portal.extraPortals = with pkgs; [
  #xdg-desktop-portal-hyprland
  #  xdg-desktop-portal-gtk
  #];
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = a ++ b;

  imports = [
    ../../packages/desktop.nix
    ../../packages/cli.nix
    ../../packages/dev.nix
  ];
}
