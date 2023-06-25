{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;
}
