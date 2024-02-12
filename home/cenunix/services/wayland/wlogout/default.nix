{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.wlogout = {
    enable = true;
  };
}
