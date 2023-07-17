{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./colorscheme.nix];
  config = {
    options = {
      number = true;
      relativenumber = true;
    };
  };
}
