{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  neovim = pkgs.neovim.override {
    # stupid defaults
    withPython3 = false;
    withRuby = false;
    configure = {
      customRC = ''
        lua << EOF
        local k = vim.keymap.set
        vim.g.mapleader = "<Space>"
        k("n", "<C-DOWN>", "<cmd>resize +2<cr>")
        k("n", "<C-UP>", "<cmd>resize -2<cr>")
        k("n", "<C-RIGHT>", "<cmd>vertical resize -2<cr>")
        k("n", "<C-LEFT>", "<cmd>vertical resize +2<cr>")
        k("n", "<S-LEFT>", "<C-w>h")
        k("n", "<S-DOWN>", "<C-w>j")
        k("n", "<S-UP>", "<C-w>k")
        k("n", "<S-RIGHT>", "<C-w>l")
        k('t', '<esc>', "<C-\\><C-n>")
        vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
        vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
        vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
        vim.keymap.set('n', '<leader>ft', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
        vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>e', ':Neotree action=focus reveal toggle<CR>', { desc = 'NeoTree Toggle' })

        local o = vim.opt
        o.lazyredraw = true
        o.shell = "zsh"
        o.shadafile = "NONE"
        o.ttyfast = true
        o.termguicolors = true
        o.undofile = true
        o.smartindent = true
        o.tabstop = 2
        o.shiftwidth = 2
        o.shiftround = true
        o.expandtab = true
        o.cursorline = true
        o.relativenumber = true
        o.number = true
        o.viminfo = ""
        o.viminfofile = "NONE"
        o.wrap = false
        o.splitright = true
        o.splitbelow = true
        o.laststatus = 0
        o.cmdheight = 0
        vim.api.nvim_command("autocmd TermOpen * startinsert")
        vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          background = { -- :h background
              light = "latte",
              dark = "mocha",
          },
          transparent_background = true, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
              comments = { "italic" }, -- Change the style of comments
              conditionals = { "italic" },
              loops = {},
              functions = {},
              keywords = {},
              strings = {},
              variables = {},
              numbers = {},
              booleans = {},
              properties = {},
              types = {},
              operators = {},
          },
          color_overrides = {},
          custom_highlights = {},
          integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              notify = true,
              mini = {
                  enabled = true,
                  indentscope_color = "",
              },
              -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
          },
        })
        vim.cmd.colorscheme 'catppuccin'
        require('neo-tree').setup ({
        })
        require('lualine').setup {
          options = {
            icons_enabled = true,
            component_separators = { left = '>', right = '<'},
            section_separators = { left = '|', right = '|'},
            globalstatus = true,
          },
        }
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
        require('null-ls').setup {
          sources = {
            require('null-ls').builtins.formatting.alejandra,
            require('null-ls').builtins.diagnostics.deadnix
          }
        }
        require("bufferline").setup{
          options = {
            offsets = {
              {
                filetype = "neo-tree",
                text="File Tree",
                separator= true,
                text_align = "left"
              }
            },
            diagnostics = "nvim_lsp",
            separator_style = {"", ""},
            modified_icon = '●',
            show_close_icon = false,
            show_buffer_close_icons = false,
          }
        }
        EOF
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          nvim-lspconfig
          null-ls-nvim
          nvim-treesitter
          neo-tree-nvim
          nvim-web-devicons
          lualine-nvim
          bufferline-nvim
          which-key-nvim
          telescope-nvim
          catppuccin-nvim
        ];
      };
    };
  };
in
{
  config = {
    home.packages = with pkgs; [
      neovim
      deadnix
      statix
      nil
      alejandra
    ];
  };
}
