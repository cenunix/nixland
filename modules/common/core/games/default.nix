{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mangohud
  ];
  imports = [
    ./chess.nix
    ./gamemode.nix
    ./gamescope.nix
    ./steam.nix
  ];
}
