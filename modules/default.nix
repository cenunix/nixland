{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./common
    ./extra
    ./shared
    ./home-manager.nix
  ];
}
