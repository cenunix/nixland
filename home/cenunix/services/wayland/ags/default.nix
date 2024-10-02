{ inputs, pkgs, osConfig, config, lib, ... }:
with lib;
let programs = osConfig.modules.programs;
in {
  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.astal.homeManagerModules.default
  ];

  home.packages = with pkgs;
    [
      bun
      dart-sass
      fd
      brightnessctl
      swww
      # inputs.matugen.packages.${system}.default
      slurp
      fzf
      killall
      wl-clipboard
      grimblast
      satty
      hyprpicker
      pavucontrol
      networkmanager
      rofi-bluetooth
      gtk3
      bc
      gnome-control-center
    ] ++ optionals (programs.gpu-screen-recorder.enable)
    [ gpu-screen-recorder-mine ];
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink
    "/home/cenunix/NixLand/home/cenunix/services/wayland/ags/config";
  programs.ags = {
    enable = true;
    # configDir = ./config;
    extraPackages = with pkgs; [ accountsservice ];
  };
}
