{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    cpufrequtils
    bat
    btop
    curl
    fd
    fzf
    less
    imagemagick
    man
    nushell
    p7zip
    pciutils
    pipe-viewer
    lm_sensors
    pzip
    ripgrep
    starship
    sysstat
    unzip
    usbutils
    xdg-utils
    yazi
    zip
    ];
}
