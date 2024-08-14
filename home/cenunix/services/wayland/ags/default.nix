{ inputs, pkgs, config, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.astal.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    # (swww.overrideAttrs (o: rec {
    #   pname = "swww";
    #   version = "master";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "LFGae";
    #     repo = pname;
    #     rev = "432b7135af0bb34e4b0e55edf76ff516937bc7b0";
    #     hash = "sha256-pX6fJrlNXe1W5ZO9nC9ikN1zoAcHDqErLS7EnglD33o=";
    #   };
    #   cargoDeps = pkgs.rustPlatform.importCargoLock {
    #     lockFile = src + "/Cargo.lock";
    #     allowBuiltinFetchGit = true;
    #   };
    # }))
    # (mpvpaper.overrideAttrs (o: rec {
    #   pname = "mpvpaper";
    #   version = "master";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "GhostNaN";
    #     repo = pname;
    #     rev = "f65700a3ecc9ecd8ca501e18a807ee18845f9441";
    #     hash = "sha256-h+YJ4YGVGGgInVgm3NbXQIbrxkMOD/HtBnCzkTcRXH8=";
    #   };
    # }))
    swww

    # inputs.matugen.packages.${system}.default
    slurp
    fzf
    wf-recorder
    wl-clipboard
    grimblast
    satty
    hyprpicker
    pavucontrol
    networkmanager
    rofi-bluetooth
    gtk3
    bc
    gnome.gnome-control-center
  ];
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink
    "/home/cenunix/NixLand/home/cenunix/services/wayland/ags/config";
  programs.ags = {
    enable = true;
    # configDir = ./config;
    extraPackages = with pkgs; [ accountsservice ];
  };
}
