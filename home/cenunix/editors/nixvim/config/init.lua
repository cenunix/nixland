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
k("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
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
vim.g.neovide_transparency = 0.8
-- vim.g.transparency = 0.8
-- vim.g.neovide_background_color = "#11111b"
vim.g.neovide_floating_shadow = false
vim.g.neovide_window_floating_opacity = 0
vim.g.neovide_floating_blur_amount_x = 5.0
vim.g.neovide_floating_blur_amount_y = 5.0
local o = vim.opt
-- o.lazyredraw = false
o.shell = "zsh"
-- o.shadafile = 'NONE'
-- o.ttyfast = true
o.guifont = "VictorMono Nerd Font:h14" -- text below applies for VimScript
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
o.winblend = 80
o.pumblend = 80
vim.g.floaterm_winblend = 80
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
