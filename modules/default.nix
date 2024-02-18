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
    ./shared
    ./options
    ./home-manager.nix
  ];
}
