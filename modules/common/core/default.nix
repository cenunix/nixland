{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./env
    ./network
    ./programs
    ./users
    ./nix.nix
  ];
}
