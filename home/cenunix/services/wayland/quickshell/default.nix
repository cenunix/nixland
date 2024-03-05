{
  pkgs,
  config,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [
      inputs.quickshell.packages.${pkgs.system}.default
    ];
  };
  xdg.configFile."quickshell/shell.qml".source = ./shell.qml;
}
