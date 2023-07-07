{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell.nix
    ./tools.nix
  ];
}
