{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh.enable = true;
  };
}
