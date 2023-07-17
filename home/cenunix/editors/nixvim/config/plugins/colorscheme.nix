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
        integrations = {
          barbar = true;
          neotree = true;
          which_key = true;
        };
      };
    };
  };
}
