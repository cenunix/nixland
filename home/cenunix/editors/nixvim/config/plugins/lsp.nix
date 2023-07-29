{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      clangd-extensions = {
        enable = true;
        enableOffsetEncodingWorkaround = true;
        server = {
          extraOptions = {
            # keys = {__raw = ''{ "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" }'';};
            cmd = [
              ''${pkgs.clang-tools}/bin/clangd''
              ''--offset-encoding=utf-16''
              ''--background-index''
              ''--clang-tidy''
              ''--header-insertion=iwyu''
              ''--completion-style=detailed''
              ''--function-arg-placeholders=false''
              ''--fallback-style=llvm''
            ];
            # root_dir = "require 'lspconfig.util'.root_pattern('Makefile','CMakeLists.txt','configure.ac','configure.in','config.h.in','meson.build','meson_options.txt','build.ninja')";

            # capabilities = {
            #   __raw = '''';
            #   # require("cmp_nvim_lsp")'';
            # };
            single_file_support = true;
            init_options = {
              usePlaceholders = true;
              completeUnimported = true;
              clangdFileStatus = true;
            };
          };
        };
      };
      nix.enable = true;
      lspsaga.enable = true;
      lsp = {
        enable = true;
        # preConfig = ''
        #   capabilities = require("cmp_nvim_lsp").default_capabilities()
        # '';

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            # "<leader>k" = "goto_prev";
            # "<leader>j" = "goto_next";
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
          jsonls.enable = true;
          bashls.enable = true;

          nil_ls.enable = true;
          lua-ls.enable = true;
          rust-analyzer.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          clangd = {
            enable = true;
          };
          tsserver = {
            enable = true;
            extraOptions = {
              root_dir = { __raw = ''require("lspconfig.util").root_pattern("tsconfig.json")''; };
              single_file_support = true;
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
