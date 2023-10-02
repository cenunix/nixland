{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./btop
    ./git
    ./lf
    ./rbw # Alternative bitwarden command line interface
    ./xdg.nix
  ];
}
