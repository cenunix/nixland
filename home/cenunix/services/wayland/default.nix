{ inputs, outputs, lib, config, pkgs, self, ... }: {
  imports = [
    ./ags
    # ./fuzzel
    ./hypridle
    ./hyprlock
    ./walker
    # ./waybar
  ];
}
