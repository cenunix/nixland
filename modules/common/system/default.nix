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
    ./media
    ./module
    ./hardware
    ./network
    ./virtualization
  ];
}
