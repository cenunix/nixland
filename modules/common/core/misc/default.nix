{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./xdg-portals.nix
    ./fonts.nix
  ];
}
