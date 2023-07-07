{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cava # Audio visualizer
    ./spotify-player # Spotify command line interface
  ];
}
