{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.astal.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    inputs.matugen.packages.${system}.default
    slurp
    fzf
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    rofi-bluetooth
    gtk3
  ];

  programs.astal = {
    enable = true;
    extraPackages = with pkgs; [
      libadwaita
    ];
  };
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink "/home/cenunix/NixLand/home/cenunix/services/wayland/ags/config";

  # home.file = {
  #   ".config/ags" = {
  #     source = ./config;
  #     recursive = true;
  #   };
  # };
  programs.ags = {
    enable = true;
    # configDir = ./config;
    # extraPackages = with pkgs; [
    #   accountsservice
    # ];
  };
}
