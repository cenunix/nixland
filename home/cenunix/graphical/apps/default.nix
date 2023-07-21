{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./brave
    ./nheko
    ./obsidian
    ./schizofox
    ./spotify
    ./webcord
  ];
}
