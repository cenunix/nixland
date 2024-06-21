{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./cava # Audio Visualizer
    # ./spotify-player # Spotify command line interface
  ];
}
