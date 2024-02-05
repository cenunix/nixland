require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {    -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  term_colors = true,
  styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },     -- Change the style of comments
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
  color_overrides = {
    mocha = {
      base = "#11111b",
    },
  },
  custom_highlights = {
    -- Comment = { fg = colors.flamingo },
    -- TabLineSel = { bg = colors.pink },
    -- CmpBorder = { fg = "#11111b" },
    Pmenu = { bg = "#11111b" },
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    neotree = true,
    treesitter = true,
    notify = true,
    navic = true,
    noice = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})
--local mocha = require('catppuccin.palettes').get_palette 'mocha'
-- =========================
-- UI Elements
-- =========================
--vim.api.nvim_set_hl(0, 'Pmenu', { bg = mocha.surface0 })
--vim.api.nvim_set_hl(0, 'PmenuSel', { fg = mocha.text, bg = mocha.surface1, bold = true })
--vim.api.nvim_set_hl(0, 'NormalFloat', { bg = mocha.surface0 })
vim.cmd.colorscheme("catppuccin")
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })

