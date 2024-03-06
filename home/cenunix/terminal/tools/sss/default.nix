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
    wayshot
  ];
  programs.sss = {
    enable = true;

    # General Config
    general = {
      author = " Cenunix on NixLand";
      padding-x = 5;
      padding-y = 10;
      colors = {
        background = "#${colors.base00}";
        author = "#${colors.base05}";
        shadow = "#${colors.base02}";
      };
      fonts = "Maple Mono SC NF=20.0";
      radius = 8;
      save-format = "png";
      shadow = false;
      shadow-image = false;
    };
    code.enable = true;
  };
}
