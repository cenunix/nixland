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
    ./quickshell
    ./swaync
    ./waybar
    ./wlogout
  ];
}
