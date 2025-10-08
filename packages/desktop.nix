{pkgs, ...}: {
imports = [
../modules/gaming
];
  environment.systemPackages = with pkgs; [
    obsidian
    ghostty
    kitty
    jq
  ];
}
