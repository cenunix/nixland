{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unzip
    ripgrep
    nmap
    fd
    xh
    jq
    fzf
    p7zip
    grex
    lm_sensors
  ];
}
