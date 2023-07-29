{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      null-ls = {
        enable = true;
        sources = {
          code_actions = {
            eslint = {
              enable = true;
            };
            statix = {
              enable = true;
            };
          };
          diagnostics = {
            eslint = {
              enable = true;
            };
            deadnix = {
              enable = true;
            };
          };
          formatting = {
            prettier = {
              enable = true;
            };
            nixpkgs_fmt = {
              enable = true;
            };
          };
        };
      };
    };
    extraPlugins = with pkgs; [
    ];

    extraConfigLuaPost = ''
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.gofumpt,
          require("null-ls").builtins.formatting.goimports,
          require("null-ls").builtins.formatting.clang_format,
        }
      })
    '';
  };
}
