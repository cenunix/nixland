{ config, lib, pkgs, inputs, ... }:
let
  sys = config.modules.system;
  env = config.modules.usrEnv;
  inherit (lib) mkForce mkIf;
in {
  config = mkIf sys.video.enable {
    xdg.portal = {
      enable = true;

      # extraPortals =
      #   [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
      #
      # xdgOpenUsePortal = true;
      # config = {
      #   common = {
      #     "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      #     "org.freedesktop.impl.portal.Screencast" = "hyprland";
      #     "org.freedesktop.portal.Screencast" = "hyprland";
      #     default = [ "hyprland" ];
      #   };
      #   hyprland.default = [ "hyprland" "gtk" ];
      # };
    };
  };
}
