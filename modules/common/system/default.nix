{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bootloaders
    ./display
    ./media
    ./module
    ./hardware
  ];
}
