{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = ["desktop" "laptop" "armlaptop"];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
