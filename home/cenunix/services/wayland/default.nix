{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./hyprlock
    ./swaync
    ./waybar
    ./wlogout
  ];
}
