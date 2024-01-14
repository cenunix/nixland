require('null-ls').setup {
    sources = {
    require('null-ls').builtins.formatting.alejandra,
    require('null-ls').builtins.formatting.stylua

    require('null-ls').builtins.diagnostics.deadnix
    }
}