local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").nil_ls.setup({
  autostart = true,
  capabilities = capabilities,
  cmd = { "nil" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt", "--quiet" },
      },
    },
  },
})
require("lspconfig").clangd.setup({
  autostart = true,
  capabilities = capabilities,
})
require("lspconfig").gopls.setup({
  autostart = true,
  capabilities = capabilities,
})
require("lspconfig").tsserver.setup({
  autostart = true,
  capabilities = capabilities,
})
require("lspconfig").lua_ls.setup({
  autostart = true,
  capabilities = capabilities,
})
require("lspconfig").pyright.setup({
  autostart = true,
  capabilities = capabilities,
})
