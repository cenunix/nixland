{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Alternative bitwarden command line interface
    ./rbw
    ./xdg.nix
  ];
}
