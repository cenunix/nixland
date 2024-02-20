{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;
in {
  imports = [
    inputs.sss.nixosModules.home-manager
  ];

  programs.sss = {
    enable = true;

    # General Config
    general = {
      author = " cenunix";
      # copy = true;
      colors = {
        background = colors.base00;
        author = c.base05;
        shadow = c.base01;
      };
      fonts = "Maple Mono SC NF=11.0";
      radius = 8;
      save-format = "webp";
      shadow = true;
      shadow-image = true;
    };
    code.enable = true;
  };
}
