{pkgs, ...}: {
  fonts.packages = with pkgs; [
  azeret-mono
  _0xproto
    adwaita-fonts
    cozette
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    ibm-plex
    nerd-fonts.symbols-only
    cascadia-code
    commit-mono
    maple-mono.variable
    geist-font
    departure-mono
    monaspace
    iosevka
  ];
}
