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
  home.packages = with pkgs; [
    slurp
  ];
  programs.sss = {
    enable = true;

    # General Config
    general = {
      author = " cenunix";
      # copy = true;
      colors = {
        background = "#${colors.base00}";
        author = "#${colors.base05}";
        shadow = "#${colors.base02}";
      };
      fonts = "Maple Mono SC NF=14.0";
      radius = 10;
      save-format = "png";
      shadow = true;
      shadow-image = true;
    };
    code.enable = true;
  };
}
