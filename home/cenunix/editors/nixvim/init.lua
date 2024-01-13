local k = vim.keymap.set
vim.g.mapleader = " "
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
-- vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
-- vim.keymap.set('n', '<leader>ft', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
-- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
-- vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
-- vim.keymap.set('n', '<leader>e', ':Neotree action=focus reveal toggle<CR>', { desc = 'NeoTree Toggle' })

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
vim.o.timeout = true
vim.o.timeoutlen = 0
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
local mocha = require("catppuccin.palettes").get_palette "mocha"
-- =========================
-- UI Elements
-- =========================
vim.api.nvim_set_hl(0, "Pmenu", { bg = mocha.surface0 })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = mocha.text, bg = mocha.surface1, bold = true })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = mocha.surface0 })
vim.cmd.colorscheme 'catppuccin'
local wk = require("which-key")
wk.register({
    ["<leader>"] = {
    w = { "<cmd>w<cr>", "Save Buffer" },
    q = { "<cmd>q<cr>", "Quit" },
    e = { ":Neotree action=focus reveal toggle<cr>", "Toggle Neotree" },
    f = {
        name = "File",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        n = { "<cmd>enew<cr>", "New File" },
        w = { "<cmd>Telescope live_grep<cr>", "Grep Files" },
        b = { "<cmd>Telescope buffers<cr>", "Grep Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Grep Help Tags" },
        d = { "<cmd>Telescope diagnostics<cr>", "Grep Diagnostics" },
        g = { "<cmd>Telescope git_files<cr>", "Grep Git Files" },
    },
    g = {
        name = "Git",
        l = { "<cmd>Gitsigns blame_line<cr>", "View Git Blame" },
        L = { "<cmd>Gitsigns blame_line {full = true}<cr>", "View full Git Blame" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git Hunk" },
        h = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Git Hunk" },
        r = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Git Buffer" },
        s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Git Hunk" },
        S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Git Buffer" },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Unstage Git Hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "View Git Diff" },
    },
    l = {
        name = "Lsp",
        i = { "<cmd>LspInfo<cr>", "LSP Information" },
        I = { "<cmd>NullLsInfo<cr>", "Null-ls Information" },
    },
    },
})
vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    -- ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
        },
        },
        move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
        },
        goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
        },
        goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
        },
        goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
        },
        },
        swap = {
        enable = true,
        swap_next = {
            ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
            ['<leader>A'] = '@parameter.inner',
        },
        },
    },
    }
end, 0)
require('neo-tree').setup ({
    window = {
    position = "float",
    mappings = {
        ["<space>"] = false,
    },
    },
})
require('gitsigns').setup()
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
