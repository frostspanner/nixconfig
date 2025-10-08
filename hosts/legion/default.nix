{
  config,
  inputs,
  cfg,
  lib,
  pkgs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nixpkgs.config.allowUnfree = true;
  nix.channel.enable = false;

  nix = {
    settings = {
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      experimental-features = ["nix-command" "flakes"];
      show-trace = true;
      auto-optimise-store = true;
      flake-registry = "";
      trusted-users = ["@wheel"];
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak";
  };

  services.udev.enable = true;
  services.power-profiles-daemon.enable = true;
  services.btrfs.autoScrub.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "8.8.8.8"
    "1.1.1.1"
    "2001:4860:4860::8888"
  ];

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.thermald.enable = lib.mkDefault true;

  # √(2560² + 1600²) px / 16 in ≃ 189 dpi
  services.xserver.dpi = 189;

  boot.extraModulePackages = [config.boot.kernelPackages.lenovo-legion-module];

  programs.git.enable = true;

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users.tpb = {
    isNormalUser = true;
    description = "Timothy Paul";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
      "video"
      "input"
      "audio"
    ];
    # packages = with pkgs; [];
    # initialHashedPassword = "$6$jCwICA7fB5jppjFO$nsXUx/5onI2nZUEZpRX41rlL9NXsAn1wnTKgJ1Np3tDpgimhQabAVE37ZUa9nmn8riuorojOPFW2c0YEfqSe1/";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = false;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  networking.hostName = "lachesis";
  networking.hostId = "0d899fb8";
  # environment.systemPackages = with pkgs; [];

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
    fixedsys-excelsior
  ];

  imports = [
    inputs.disko.nixosModules.default
    ./disko.nix
    ../../desktops/${cfg.desktop}
    ./hardware-configuration.nix
    ../../modules/nvidia
    ../../modules/neovim
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
