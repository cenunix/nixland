{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ inputs.hyprland.homeManagerModules.default ./hyprland ];
}
