{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.spec.home.gamedev;
in
{
  options.spec.home.gamedev =
    let
      inherit (lib) mkEnableOption;
    in
    {
      enable = mkEnableOption "gamedev";
    };

  config = lib.mkIf cfg.enable {
    home =
      let
        templatesPackage = pkgs.godot_4_4-export-templates-bin;
      in
      {
        packages = [
          pkgs.godot_4_4
          pkgs.famistudio
          templatesPackage
          pkgs.ldtk # Level designer toolkit
          pkgs.ardour
          pkgs.audacity
        ];

        # Setup Godot export templates
        file.".local" = {
          source = templatesPackage;
          recursive = true;
        };
      };
  };
}
