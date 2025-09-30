{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    obsidian
    zed-editor
    ghostty
    kitty
    jq
  ];
}
