{ pkgs
, helpers
, ...
}:
{
  config = {
    plugins = {
      null-ls = {
        enable = true;
      };
    };
    extraPackages = [
      # GoLang
      pkgs.gofumpt
      pkgs.gotools
      # Web Stuff
      pkgs.html-tidy
      pkgs.nodePackages.stylelint
      pkgs.nodePackages.prettier
      pkgs.nodePackages.eslint
      pkgs.prettierd
      pkgs.nodePackages.eslint_d
      # nix related
      pkgs.deadnix
      pkgs.statix
      pkgs.nixpkgs-fmt
    ];
    extraConfigLuaPre = ''
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.goimports,
          require("null-ls").builtins.formatting.gofumpt,
          require("null-ls").builtins.diagnostics.tidy,
          require("null-ls").builtins.formatting.prettierd,
          -- require("null-ls").builtins.formatting.eslint_d,
          -- require("null-ls").builtins.code_actions.eslint_d,
          require("null-ls").builtins.diagnostics.eslint_d,
          -- require("null-ls").builtins.code_actions.statix,
          require("null-ls").builtins.diagnostics.deadnix,
          require("null-ls").builtins.formatting.nixpkgs_fmt,
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                  vim.lsp.buf.format({ async = false })
                end,
            })
          end
        end,
      })
    '';
  };
}
