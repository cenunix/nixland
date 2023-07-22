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
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          tailwindcss.enable = true;
          tsserver.enable = true;
          html.enable = true;
          ccls.enable = true;
          jsonls.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          rust-analyzer.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          gopls = {
            enable = true;
            filetypes = [
              "go"
              "gomod"
              "gowork"
              "gotmpl"
            ];
            rootDir = "require 'lspconfig.util'.root_pattern('go.work', 'go.mod', '.git')";
            extraOptions.settings = {
              completeUnimported = true;
              usePlaceholders = true;
              analyses = {
                unusedparams = true;
              };
            };
          };
        };
      };
    };
  };
}
