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
    # ./nheko
    # ./obs
    # ./obsidian
    # ./schizofox
    # ./spotify
    ./webcord
  ];
}
