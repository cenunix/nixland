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
      null-ls = {
        enable = true;
        sources.formatting.gofmt = {
          enable = true;
        };
        sources.formatting.goimports = {
          enable = true;
        };
      };
    };
  };
}
