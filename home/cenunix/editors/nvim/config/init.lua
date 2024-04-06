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
vim.g.neovide_transparency = 0.8
-- vim.g.transparency = 0.8
-- vim.g.neovide_background_color = "#07070b"
vim.g.neovide_floating_shadow = false
vim.g.neovide_refresh_rate = 240
-- vim.g.neovide_window_floating_opacity = 0
-- vim.g.neovide_floating_blur_amount_x = 5.0
-- vim.g.neovide_floating_blur_amount_y = 5.0
local o = vim.opt
-- o.lazyredraw = false
o.shell = "zsh"
-- o.shadafile = 'NONE'
-- o.ttyfast = true
o.guifont = "Maple Mono SC NF:h14" -- text below applies for VimScript
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
o.clipboard = "unnamedplus"
o.splitright = true
o.splitbelow = true
o.laststatus = 0
o.cmdheight = 0
vim.o.timeout = true
vim.o.timeoutlen = 0
-- o.winblend = 80
-- o.pumblend = 80
-- vim.g.floaterm_winblend = 80
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
