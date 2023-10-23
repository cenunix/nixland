{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
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
        };
        servers = {
          tailwindcss.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          bashls.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          yamlls.enable = true;
          tsserver = {
            enable = true;
            extraOptions = {
              root_dir = { __raw = ''require("lspconfig.util").root_pattern("tsconfig.json")''; };
              single_file_support = true;
            };
          };
          gopls = {
            enable = true;
            autostart = true;
            filetypes = [
              "go"
              "gomod"
              "gowork"
              "gotmpl"
            ];
            extraOptions = {
              single_file_support = true;
              rootDir = { __raw = ''require 'lspconfig.util'.root_pattern('go.work', 'go.mod', '.git')''; };
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
