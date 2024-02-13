{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.qtgreet = {
    package = pkgs.qtgreet;
    enable = true;
  };
}
