{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  home = {
    file.".config/ags".source = ./confignew;
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
