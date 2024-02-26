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
  };
}
