{ inputs, osConfig, ... }:
let
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;
  font_family = "Lexend";
in {
  imports = [ inputs.hyprlock.homeManagerModules.default ];
  programs.hyprlock = {
    enable = true;
    backgrounds = [{
      monitor = "";
      path =
        "/home/cenunix/NixLand/home/cenunix/graphical/wms/hyprland/mountain.png";
    }];

    input-fields = [{
      monitor = "DP-1";

      size = {
        width = 300;
        height = 50;
      };

      outline_thickness = 2;

      outer_color = "rgb(108, 112, 134)";
      inner_color = "rgb(108, 112, 134)";
      font_color = "rgb(205, 214, 244)";

      fade_on_empty = false;
      # placeholder_text =
      #   "<span font_family='Lexend' foreground=##cdd6f4>Password...</span>";
      dots_spacing = 0.3;
      dots_center = true;
    }];

    labels = [{
      monitor = "";
      inherit font_family;
      text = ''
        cmd[update:1000] echo "<span font_family='Lexend' foreground='##cdd6f4'>$(date +%r)</span>"'';
      font_size = 50;
      color = "rgb(205, 214, 244)";

      position = {
        x = 0;
        y = 80;
      };

      valign = "center";
      halign = "center";
    }];
  };
}
