{pkgs, ...}: {
imports = [
../modules/gaming
../packages/fonts.nix
];
  environment.systemPackages = with pkgs; [
    obsidian
    ghostty
    kitty
    jq
  ];
}
