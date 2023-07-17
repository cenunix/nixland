{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    maps.normal."<leader>n" = {
      action = ":Neotree action=focus reveal toggle<CR>";
      silent = true;
    };
    plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
    };
  };
}
