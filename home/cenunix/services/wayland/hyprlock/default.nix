{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];
  programs.hyprlock = {
    enable = true;
    backgrounds = [
      {
        monitor = "";
        path = "/home/cenunix/Personal/nicks/home/cenunix/graphical/wms/hyprland/wall.png";
      }
    ];
  };
}
