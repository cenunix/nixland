{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    maps.normal."<S-h>" = {
      action = ":bprevious<CR>";
      silent = true;
      desc = "Previous Buffer";
    };
    maps.normal."<S-l>" = {
      action = ":bnext<CR>";
      silent = true;
      desc = "Next Buffer";
    };
    maps.normal."<leader>c" = {
      action = ":bdelete!<CR>";
      silent = true;
      desc = "Close Buffer";
    };

    plugins = {
      bufferline.enable = true;
    };
  };
}
