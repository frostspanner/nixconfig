{pkgs, ...}: {
  imports = [
    ../modules/gaming
    ../packages/fonts.nix
  ];
  environment.systemPackages = with pkgs; [
    obsidian
    ghostty
    kitty
    zed-editor
  ];
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING= "1"; 
  };
}
