{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./spotify-player # Spotify command line interface
  ];
}
