{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nheko = {
    enable = true;
  };
}
