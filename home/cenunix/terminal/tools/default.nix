{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./git
    ./rbw # Alternative bitwarden command line interface
    ./xdg.nix
  ];
}
