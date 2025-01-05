{ inputs, outputs, lib, config, pkgs, self, ... }: {
  imports = [ inputs.walker.homeManagerModules.default ];
  # xdg.configFile."walker/style.css".source = ./walker_style.css;
  programs.walker = {
    enable = true;
    package = inputs.walker.packages.${pkgs.system}.default;
    runAsService = true;
    config = {
      # activation_mode.disabled = true;
      ignore_mouse = true;
    };
    theme = {
      layout = {
        ui.window.box = {
          v_align = "center";
          orientation = "vertical";
        };
      };
      style = builtins.readFile ./walker_style.css;
    };
  };
}
