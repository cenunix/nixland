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
        flavour = "mocha";
        transparentBackground = true;
        integrations = {
          neotree = true;
          which_key = true;
          notify = true;
          noice = true;
          illuminate.enabled = true;
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
