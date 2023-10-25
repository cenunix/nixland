{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  xdg.configFile."btop/catppuccin_mocha.theme".source = ./catppuccin_mocha.theme;
  home.packages = with pkgs; [
    btop
  ];
}
