{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./btop
    ./git
    ./lf
    ./rbw # Alternative bitwarden command line interface
    ./sss # Screenshot tool written in rust with fancy processin*
    ./xdg.nix
  ];
}
