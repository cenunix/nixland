{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # ./brave
    ./discord
    ./nheko
    ./obsidian
    ./schizofox
    ./spotify
    ./webcord
  ];
}
