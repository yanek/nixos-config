{
  config,
  lib,
  pkgs,
  ...
}:
let
  isTheme = config.myHome.theme.variant == "rose-pine";
in
{
  config = lib.mkIf isTheme {
    stylix = {
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    };

    xsession.windowManager.i3.config.colors =
      with config.lib.stylix.colors.withHashtag;
      let
        inherit (lib) mkForce;
      in
      {
        focused = {
          indicator = mkForce base06;
          border = mkForce base05;
          childBorder = mkForce base05;
        };
        focusedInactive = {
          indicator = mkForce base00;
          border = mkForce base00;
          childBorder = mkForce base00;
        };
        unfocused = {
          indicator = mkForce base00;
          border = mkForce base00;
          childBorder = mkForce base00;
        };
      };

    programs.helix.settings.theme = lib.mkForce "rose_pine";
  };
}
