require('lspconfig').nil_ls.setup {
    autostart = true,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = {'nil'},
    settings = {
    ['nil'] = {
        formatting = {
        command = {'alejandra', '--quiet'},
        }
    }
    }
}
