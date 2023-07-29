{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "macchiato";
        transparentBackground = false;
        integrations = {
          nvimtree = true;
          which_key = true;
          notify = true;
          noice = true;
          illuminate = true;
          cmp = true;
        };
      };
    };
    extraConfigLua = ''
          require("notify").setup({
        background_colour = "#000000",
      })
    '';
  };
}
