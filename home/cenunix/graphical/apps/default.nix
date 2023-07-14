{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./brave
    ./nheko
    ./schizofox
    ./spotify
    ./webcord
  ];
}
