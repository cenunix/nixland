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
      desc = "Toggle Neotree";
    };
    plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
    };
  };
}
