{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  programs.hyprlock.enable = true;
  programs.waybar.enable = true;

  security.polkit.enable = true;

  services.hypridle = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  #services.hyprpolkitagent.enable = true;

  imports = [../../packages/desktop.nix];

  environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    bat
    brightnessctl
    btop
    cpufrequtils
    curl
    devenv
    ethtool
    fd
    fontconfig
    fzf
    hyprcursor
    hyprpicker
    hyprpolkitagent
    hyprshot
    imagemagick
    jujutsu
    lazyjj
    libqalculate
    less
    libnotify
    lm_sensors
    mako
    man
    nushell
    p7zip
    pciutils
    pipe-viewer
    pzip
    ripgrep
    starship
    swaybg
    swayimg
    swayosd
    sysstat
    unzip
    usbutils
    walker
    wl-clipboard-rs
    wl-clip-persist
    wl-screenrec
    xcursor-pro
    xdg-desktop-portal-gtk
    xdg-user-dirs
    xdg-utils
    yazi
    yt-dlp
    zathura
    zip
  ];

  services.udev.packages = [pkgs.swayosd];

  system.activationScripts = {
    # swayosd cannot set brightness issue on NixOS see
    # https://github.com/ErikReider/SwayOSD/issues/12#issuecomment-1950581102
    fix-brightness-file-permission.text = ''       
      chgrp video /sys/class/backlight/nvidia_0/brightness 
      chmod g+w /sys/class/backlight/nvidia_0/brightness 
      '';
  };

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput input listening backend.";
    documentation = ["https://github.com/ErikReider/SwayOSD"];
    wantedBy = [
      "graphical.target"
    ];
    partOf = ["graphical.target"];
    after = ["graphical.target"];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };
}
