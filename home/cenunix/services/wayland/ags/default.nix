{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    xdg.configFile = {
      "ags".source = config.lib.file.mkOutOfStoreSymlink "/home/cenunix/Personal/nicks/home/cenunix/services/wayland/ags/config";
    };
    home = {
      # file.".config/ags".source = ./config;

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
  };
}
