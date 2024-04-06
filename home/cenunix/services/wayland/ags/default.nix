{ inputs, pkgs, config, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.astal.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    (swww.overrideAttrs (o: rec {
      pname = "swww";
      version = "master";
      src = pkgs.fetchFromGitHub {
        owner = "LFGae";
        repo = pname;
        rev = "432b7135af0bb34e4b0e55edf76ff516937bc7b0";
        hash = "sha256-pX6fJrlNXe1W5ZO9nC9ikN1zoAcHDqErLS7EnglD33o=";
      };
      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = src + "/Cargo.lock";
        allowBuiltinFetchGit = true;
      };
    }))
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
    extraPackages = with pkgs; [ libadwaita ];
  };
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink
    "/home/cenunix/NixLand/home/cenunix/services/wayland/ags/config";

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
