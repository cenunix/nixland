{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./usrEnv.nix
    ./device.nix
    ./hardware
  ];
}
