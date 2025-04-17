{ pkgs, systemSettings, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment = {
    shells = with pkgs; [
      bash
      fish
    ];

    systemPackages = with pkgs; [
      bat
      bc
      eza
      fd
      fzf
      gnumake
      helix
      htop
      lazygit
      nil
      nixfmt-rfc-style
      ripgrep
      starship
      toybox
      unzip
      yazi
      zellij
      zoxide

      fishPlugins.fzf-fish
    ];
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

}
