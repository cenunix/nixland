-- enable gofumpt formatter for gopls lsp server??? pls work
return {
  -- override table for require("lspconfig").gopls.setup({...})
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
}
