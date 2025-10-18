{pkgs, ...}:{
  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    ibm-plex
    nerd-fonts.symbols-only
    cascadia-code
    cozette
    commit-mono
    maple-mono.variable
    geist-font
    departure-mono
    monaspace
    iosevka
  ];
  }

