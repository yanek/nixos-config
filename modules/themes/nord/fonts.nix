{pkgs, ...}: {
  stylix.fonts = {
    serif = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Serif";
    };

    sansSerif = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
    };

    monospace = {
      package = pkgs.maple-mono.NF;
      name = "Maple Mono NF";
    };

    sizes.applications = 11;
    sizes.desktop = 11;
    sizes.popups = 11;
    sizes.terminal = 11;
  };
}
