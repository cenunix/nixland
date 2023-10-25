{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  xdg.configFile."btop/".source = ./config;
  home.packages = with pkgs; [
    btop
  ];
}
