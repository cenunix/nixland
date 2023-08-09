{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  home = {
    file.".confignew/ags".source = ./config;
    packages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.default
      sassc
      slurp
      swww
      hyprpicker
      watershot
      imagemagick
      wl-gammactl
    ];
  };
}
