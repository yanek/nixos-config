{ ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 50;
    vSync = true;
    shadow = false;
    backend = "glx";

    opacityRules = [
      "80:class_g = 'Rofi'"
      "80:class_g = 'org.wezfurlong.wezterm'"
      "90:class_g = 'Thunar'"
      "90:class_g = 'discord'"
    ];

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
    };
  };
}
