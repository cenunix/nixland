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
            require("null-ls").builtins.formatting.clang_format,
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
