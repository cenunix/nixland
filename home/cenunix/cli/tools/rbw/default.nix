{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wtype
    rofi
    rofi-rbw
  ];
  programs.rbw = {
    enable = true;
    settings.email = "caden.hargrave@gmail.com";
  };
}
