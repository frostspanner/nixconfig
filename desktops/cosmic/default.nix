{inputs, pkgs, ...}:
{
services.displayManager.cosmic-greeter.enable = true;
services.desktopManager.cosmic.enable = true;
imports = [
../../packages/desktop.nix
../../packages/dev.nix
];
environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    yt-dlp
];
}
