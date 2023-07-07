{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./services
    ./fonts.nix
  ];
}
