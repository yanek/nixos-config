{ userSettings, ... }:

let
  xrandrArgs = "--output DP-4 --mode 3440x1440 --rate 144.00 --pos 0x1440 --output DP-2 --mode 2560x1440 --rate 143.97 --pos 440x0";
in
{
  imports = [
    ../modules/themes/${userSettings.theme}/theme.nix

    (import ../modules/wm/sway/sway.nix ({
      inherit userSettings;
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
    ../modules/programs/kitty.nix
    ../modules/programs/helix/helix.nix
    ../modules/programs/librewolf.nix
    ../modules/programs/prusa-slicer.nix
    ../modules/programs/comms/discord.nix

    ../modules/programs/multimedia/spotify.nix
    ../modules/programs/multimedia/vlc.nix
    ../modules/programs/multimedia/gimp.nix
  ];

  home.username = "${userSettings.username}";
  home.homeDirectory = "${userSettings.homeDir}";

  home.sessionPath = [
    "${userSettings.homeDir}/.local/bin"
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
