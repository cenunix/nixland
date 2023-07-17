{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./plugins
    ./keymaps.nix
  ];
  config = {
    options = {
      number = true;
      relativenumber = true;
    };
  };
}
