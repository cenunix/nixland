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
      clangd-extensions = {
        enable = true;
      };
      nix.enable = true;
      lspsaga.enable = true;
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          # lspBuf = {
          #   gd = "definition";
          #   gr = "Telescope lsp_references";
          #   gD = "declaration";
          #   gt = "type_definition";
          #   gi = "implementation";
          #   K = "hover";
          #   "<F2>" = "rename";
          # };
        };

        servers = {
          tailwindcss.enable = true;
          html.enable = true;
          ccls.enable = true;
          jsonls.enable = true;
          bashls.enable = true;

          nil_ls.enable = true;
          lua-ls.enable = true;
          rust-analyzer.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          clangd = {
            enable = true;
            extraOptions = {
              __raw = ''
                cmd = {
                  "clangd",
                  "--offset-encoding=utf-16",
                },
              '';
            };
          };
          tsserver = {
            enable = true;
            extraOptions = {
              root_dir = {__raw = ''require("lspconfig.util").root_pattern("tsconfig.json")'';};
              single_file_support = false;
            };
          };
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
