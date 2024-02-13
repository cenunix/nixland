{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "logout";
        action = "hyprctl dispatch exit none";
        text = "Logout";
      }
    ];
  };
}
