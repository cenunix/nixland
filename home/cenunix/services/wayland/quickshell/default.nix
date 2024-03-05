{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      inputs.quickshell.packages.${pkgs.system}.default
    ];
  };
  xdg.configFile."quickshell/shell.qml".source = ./shell.qml;
}
