{ userSettings, ... }:

{
  imports = [
    ../modules/themes/${userSettings.theme}/theme.nix

    (import ../modules/wm/i3/i3wm.nix ({
      inherit userSettings;
      xrandrArgs = null;
    }))

    ../modules/programs/git/git.nix
    ../modules/programs/fish.nix
    ../modules/programs/starship/starship.nix
    ../modules/programs/cli/eza.nix
    ../modules/programs/cli/bat.nix
    ../modules/programs/cli/fzf.nix
    ../modules/programs/cli/zoxide.nix
    ../modules/programs/cli/yazi.nix
    ../modules/programs/wezterm/wezterm.nix
    ../modules/programs/helix/helix.nix
    ../modules/programs/librewolf.nix
    ../modules/programs/comms/discord.nix

    ../modules/programs/multimedia/spotify.nix
    ../modules/programs/multimedia/vlc.nix
  ];

  home.username = "${userSettings.username}";
  home.homeDirectory = "${userSettings.homeDir}";

  home.sessionPath = [
    "${userSettings.homeDir}/.local/bin"
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
