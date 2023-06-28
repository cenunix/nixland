{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./apps
    ./launchers
    ./wms
  ];
}
