{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    plugins.indent-blankline.enable = true;
    plugins.lspkind = {
      enable = true;
      cmp = {
        enable = true;
      };
    };
    plugins.luasnip = {
      enable = true;

      fromVscode = [
        {
          lazyLoad = true;
        }
        {
          lazyLoad = true;
          paths = [
            ./snippets
          ];
        }
      ];
    };

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
    ];

    plugins.nvim-cmp = {
      enable = true;
      # preselect = "None";
      snippet.expand = "luasnip";
      mappingPresets = ["insert" "cmdline"];
      mapping = {
        "<C-u>" = ''cmp.mapping.scroll_docs(-4)'';
        "<C-d>" = ''cmp.mapping.scroll_docs(4)'';
        "<C-Space>" = ''cmp.mapping.complete()'';
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = false })";
        "<Tab>" = {
          modes = ["i" "s"];
          action = ''
              function(fallback)
                if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          '';
        };
        "<S-Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              if cmp.visible() then
              cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end
          '';
        };
      };

      # formatting = {
      #   fields = [
      #     "kind"
      #     "abbr"
      #     "menu"
      #   ];
      #   format = ''
      #       function(entry, vim_item)
      #         -- Kind icons
      #         vim_item.kind = string.format(" %s ", kind_icons[vim_item.kind])
      #         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      #         vim_item.menu = ({
      #           nvim_lsp = "[LSP]",
      #           luasnip = "[Snippet]",
      #           buffer = "[Buffer]",
      #           path = "[Path]",
      #         })[entry.source.name]
      #         return vim_item
      #     end
      #   '';
      # };

      sources = [
        # { name = "copilot"; }
        {name = "luasnip";} #-- For luasnip users.
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];
    };

    extraConfigLuaPre = ''
      luasnip = require'luasnip'
      mycmp = require'cmp'
      cmp_autopairs = require('nvim-autopairs.completion.cmp')


      function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      mycmp.setup({
        confirm_opts = {
          behavior = "Replace",
          select = false,
        },
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "rounded";
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
      })

      --   פּ ﯟ   some other good icons
      kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
    '';

    extraConfigLuaPost = ''
      mycmp = require'cmp'
        mycmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    '';
  };
}
