{ config, pkgs, lib, inputs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs;
    [
      # inputs.my-shell.packages.${pkgs.system}.default
      # inputs.ags.packages.${pkgs.system}.notifd
      # inputs.ags.packages.${pkgs.system}.mpris
      # inputs.ags.packages.${pkgs.system}.auth
      # inputs.matugen.packages.${pkgs.system}.default
      # material-symbols
      # wl-screenrec
      # hyprpaper
    ];

  programs.ags = {
    enable = true;
    extraPackages = [
      #     pkgs.libsoup_3
      #     pkgs.gtksourceview
      #     pkgs.libnotify
      #     pkgs.webkitgtk_4_1
      #     pkgs.gst_all_1.gstreamer
      #     inputs.ags.packages.${pkgs.system}.apps
      #     inputs.ags.packages.${pkgs.system}.io
      #     inputs.gtk-session-lock.packages.${pkgs.system}.default
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.tray
      #     inputs.ags.packages.${pkgs.system}.greet
      inputs.ags.packages.${pkgs.system}.battery
      #     inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.mpris
      #     inputs.ags.packages.${pkgs.system}.bluetooth
      #     inputs.ags.packages.${pkgs.system}.auth
    ];
  };
}
