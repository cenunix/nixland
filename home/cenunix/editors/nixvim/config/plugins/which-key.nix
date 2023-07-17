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
      which-key = {
        enable = true;
      };
    };
  };
}
