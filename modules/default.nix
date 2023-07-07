{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common
    ./extra
    ./home-manager.nix
  ];
}
