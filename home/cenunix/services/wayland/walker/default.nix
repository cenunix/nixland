{ inputs, outputs, lib, config, pkgs, self, ... }: {
  imports = [ inputs.walker.homeManagerModules.default ];
  xdg.configFile."walker/style.css".source = ./walker_style.css;
  programs.walker = {
    enable = true;
    package = inputs.walker.packages.${pkgs.system}.default;
    runAsService = true;
    config = {
      # theme_base = [ "" ];
      activation_mode.disabled = true;
      ignore_mouse = true;
    };
  };
}
