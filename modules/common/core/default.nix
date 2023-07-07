{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./network
    ./programs
    ./users
    ./nix.nix
  ];
}
