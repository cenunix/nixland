return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require("null-ls")

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylelint,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.nixpkgs_fmt,

      -- Diagnostics
      null_ls.builtins.diagnostics.statix,
      null_ls.builtins.diagnostics.deadnix,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.diagnostics.cpplint.with({
        args = { "--filter=-legal", "$FILENAME" },
      }),
    }
    return config -- return final config table
  end,
}
