{
  config,
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;
in {
  imports = [
    inputs.sss.nixosModules.home-manager
    ./screenshot-full.nix
    ./screenshot-area.nix
  ];

  programs.sss = {
    enable = true;

    # General Config
    general = {
      author = " cenunix";
      copy = true;
      colors = {
        background = colors.base00;
        author = colors.base05;
        shadow = colors.base01;
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
