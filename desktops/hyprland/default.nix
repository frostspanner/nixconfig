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

  imports = [
  ../../packages/desktop.nix
  ../../packages/cli.nix
  ../../packages/twm.nix
  ];

  environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    hyprcursor
    hyprpicker
    hyprpolkitagent
    hyprshot
    libqalculate
    yt-dlp
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
