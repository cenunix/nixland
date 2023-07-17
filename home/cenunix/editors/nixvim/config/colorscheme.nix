{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "macchiato";
        transparentBackground = true;
      };
    };
  };
}
