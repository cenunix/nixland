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
    ./avizo
    ./hyprlock
    ./swaync
    ./waybar
    ./wlogout
  ];
}
