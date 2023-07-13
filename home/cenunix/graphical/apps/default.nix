{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nheko
    ./schizofox
    ./spotify
    ./webcord
  ];
}
