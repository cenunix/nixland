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
    ./ags
    # ./avizo
    # ./hyprlock
    # ./quickshell
    # ./swaync
    # ./waybar
    # ./wlogout
  ];
}
