{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./xdg-ninja
    # ./gui.nix
  ];
}
