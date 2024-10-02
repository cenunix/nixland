{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./discord
    ./nheko
    ./obs
    ./obsidian
    ./schizofox
    # ./spotify
  ];
}
