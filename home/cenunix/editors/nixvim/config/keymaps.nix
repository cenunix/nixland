{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    maps.normal."<leader>w" = {
      action = "<cmd>w<CR>";
      silent = true;
      desc = "Save";
    };
    maps.normal."<leader>q" = {
      action = "<cmd>confirm q<CR>";
      silent = true;
      desc = "Quit";
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
