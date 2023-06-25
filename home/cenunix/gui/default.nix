{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./anyrun
    ./dunst
    ./gtk
    ./nheko
    ./spotify
  ];
}
