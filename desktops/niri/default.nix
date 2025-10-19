{pkgs, ...}:
{
programs.niri.enable = true;
programs.waybar.enable = true;
services.flatpak.enable = true;
imports = [
../../packages/desktop.nix
../../packages/cli.nix
../../packages/twm.nix
../../packages/dev.nix
];
environment.systemPackages = with pkgs; [
alacritty
fuzzel
swaylock
swayidle
xwayland-satellite
nautilus #needed for file picker
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
