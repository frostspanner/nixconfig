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
