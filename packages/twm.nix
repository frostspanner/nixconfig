{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    fontconfig
    libnotify
    mako
    swaybg
    swayimg
    swayosd
    walker
    wl-clipboard-rs
    wl-clip-persist
    wl-screenrec
    xcursor-pro
    xdg-desktop-portal-gtk
    xdg-user-dirs
  ];
}
