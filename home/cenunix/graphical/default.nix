{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dunst
    ./gtk
    ./nheko
    ./spotify
    ./launchers
  ];
}
