{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    plugins = {
      notify.enable = true;
      illuminate.enable = true;
      gitsigns.enable = true;
      nvim-ufo.enable = true;
      noice = {
        enable = true;
        presets = {
          command_palette = true;
        };
      };
    };
  };
}
