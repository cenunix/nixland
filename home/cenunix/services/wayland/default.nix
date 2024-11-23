{ inputs, outputs, lib, config, pkgs, self, ... }: {
  imports = [
    ./ags # ./anyrun
    ./fuzzel
    ./hypridle
    ./hyprlock # ./walker ./waybar
  ];
}
