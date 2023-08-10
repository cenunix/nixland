{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  home = {
    file.".config/ags".source = ./config;
    packages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.default
      sassc
      slurp
      swww
      hyprpicker
      watershot
      imagemagick
      wl-gammactl
      socat
      upower
      gnome.gnome-bluetooth
      glib
      pavucontrol
    ];
  };
}
