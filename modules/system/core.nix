{
  pkgs,
  systemSettings,
  ...
}: {
  nix.settings = {
    warn-dirty = false;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.sessionVariables = {
    FORCE_NIX_STABLE = "false";
  };

  time.timeZone = systemSettings.timezone;
  security.sudo.wheelNeedsPassword = false;

  environment = {
    shells = with pkgs; [
      bash
      fish
    ];

    systemPackages = with pkgs; [
      toybox
      unzip
      bc
      fd
      ripgrep
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
