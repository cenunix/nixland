{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  home.packages = with pkgs;
  # exclude server device type
    [qbittorrent];
}
