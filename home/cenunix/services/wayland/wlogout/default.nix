{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.wlogout = {
    enable = true;
    layout.logout.action = "hyprctl dispatch exit none";
  };
}
