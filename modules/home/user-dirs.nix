{config, ...}: {
  xdg.userDirs = let
    dir = config.home.homeDirectory;
  in {
    createDirectories = true;
    desktop = null;
    documents = "${dir}/docs";
    download = "${dir}/downloads";
    music = null;
    pictures = "${dir}/pictures";
    publicShare = null;
    templates = null;
    videos = "${dir}/videos";
  };
}
