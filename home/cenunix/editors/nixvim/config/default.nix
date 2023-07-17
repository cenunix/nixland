{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    colorschemes.gruvbox.enable = true;
    options = {
      number = true;
      relativenumber = true;
    };
  };
}
