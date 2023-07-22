{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    maps.normal."<S-h>" = {
      action = ":BufferPrevious<CR>";
      silent = true;
      desc = "Previous Buffer";
    };
    maps.normal."<S-l>" = {
      action = ":BufferNext<CR>";
      silent = true;
      desc = "Next Buffer";
    };
    maps.normal."<leader>c" = {
      action = ":BufferClose<CR>";
      silent = true;
      desc = "Close Buffer";
    };

    plugins = {
      barbar.enable = true;
    };
  };
}
