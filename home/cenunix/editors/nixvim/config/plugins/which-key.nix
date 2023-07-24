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
    extraConfigLuaPost = ''
      local wk = require("which-key")
      wk.setup {
      }

      wk.register {
          ["<leader>"] = {
              f = {
                  name = "Telescope",
              },
              g = {
                  name = "Git",
              },
              t = {
                name = "Terminal",
              },
          },
      }
    '';
  };
}
