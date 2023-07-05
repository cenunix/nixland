{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # spotify command line interface
    ./spotify-player
  ];
}
