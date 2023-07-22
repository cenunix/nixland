{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    options.completeopt = [ "menu" "menuone" "noselect" ];

    plugins = {
      ##comment
      luasnip.enable = true;
      copilot-lua = {
        enable = false;
        suggestion = {
          enabled = false;
        };
        panel = {
          enabled = false;
        };

      };
      #copilot-cmp.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            #copilot = "[Copilot]";
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            # neorg = "[neorg]";
            # cmp_tabnine = "[TabNine]";
          };
        };
      };
      copilot.enable = true;
      #cmp-copilot.enable = true;
      nvim-cmp = {
        enable = true;

        snippet.expand = "luasnip";

        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = "cmp.mapping.select_next_item()";
          };
          "<S-Tab>" = {
            modes = [ "i" "s" ];
            action = "cmp.mapping.select_prev_item()";
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          #{name = "copilot";}
          # { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "path"; }
          #   {name = "neorg";}
        ];
      };
    };
  };
}
