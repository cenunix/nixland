{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./chess.nix
    ./gamemode.nix
    ./steam.nix
  ];
}
