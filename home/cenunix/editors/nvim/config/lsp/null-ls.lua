local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.nixfmt,
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.formatting.qmlformat.with({
      extra_args = { "-w 2" },
    }),
    require("null-ls").builtins.diagnostics.eslint_d,
    require("null-ls").builtins.diagnostics.deadnix,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
