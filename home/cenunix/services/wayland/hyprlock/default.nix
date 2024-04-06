{ inputs, osConfig, ... }:
let
  inherit (osConfig) modules;
  inherit (modules.style.colorscheme) colors;
  font_family = "Lexend";
in {
  imports = [ inputs.hyprlock.homeManagerModules.default ];
  programs.hyprlock = {
    enable = true;
    backgrounds = [{
      monitor = "";
      path =
        "/home/cenunix/Personal/nicks/home/cenunix/graphical/wms/hyprland/wall.png";
    }];

    input-fields = [{
      monitor = "DP-2";

      size = {
        width = 300;
        height = 50;
      };

      outline_thickness = 2;

      outer_color = "rgb(${colors.base03})";
      inner_color = "rgb(${colors.base04})";
      font_color = "rgb(${colors.base05})";

      fade_on_empty = false;
      placeholder_text = ''
        <span font_family="${font_family}" foreground="##${colors.base05}">Password...</span>'';

      dots_spacing = 0.3;
      dots_center = true;
    }];

    labels = [{
      monitor = "";
      text = "$TIME";
      inherit font_family;
      font_size = 50;
      color = "rgb(${c.primary})";

      position = {
        x = 0;
        y = 80;
      };

      valign = "center";
      halign = "center";
    }];
  };
}
