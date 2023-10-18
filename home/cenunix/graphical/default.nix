{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./apps
    ./games
    ./launchers
    ./wms
  ];
}
