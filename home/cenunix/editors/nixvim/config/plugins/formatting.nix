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

    extraConfigLuaPre = ''
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
          sources = {
            require("null-ls").builtins.formatting.gofumpt,
            require("null-ls").builtins.formatting.goimports,
          },
      })
    '';
  };
}
