local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').nil_ls.setup {
    autostart = true,
    capabilities = capabilities,
    cmd = {'nil'},
    settings = {
    ['nil'] = {
        formatting = {
        command = {'alejandra', '--quiet'},
        }
    }
    }
}
require('lspconfig').clangd.setup {
    autostart = true,
    capabilities = capabilities,
}
require('lspconfig').gopls.setup {
    autostart = true,
    capabilities = capabilities,
}
