-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true,       -- sets vim.opt.number
    spell = false,       -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false,        -- sets vim.opt.wrap
    guifont = "Iosevka:h12",
  },
  g = {
    mapleader = " ",                 -- sets vim.g.mapleader
    autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true,              -- enable completion at start
    autopairs_enabled = true,        -- enable autopairs at start
    diagnostics_enabled = true,      -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements

    neovide_transparency = 1.0,
    neovide_refresh_rate = 240,
    neovide_refresh_rate_idle = 5,
    neovide_cursor_animation_length = 0.10,
    neovide_cursor_trail_size = 0.5,
    neovide_cursor_vfx_mode = "wireframe",
    neovide_remember_window_size = true,
    neovide_remember_window_position = true,

    -- black
    terminal_color_0 = "#14151e",
    terminal_color_8 = "#ffffff",
    -- red
    terminal_color_1 = "#d0679d",
    terminal_color_9 = "#d0679d",
    -- green
    terminal_color_2 = "#5de4c7",
    terminal_color_10 = "#5de4c7",
    -- yellow
    terminal_color_3 = "#fffac2",
    terminal_color_11 = "#fffac2",
    -- blue
    terminal_color_4 = "#89ddff",
    terminal_color_12 = "#add7ff",
    -- magenta
    terminal_color_5 = "#fcc5e9",
    terminal_color_13 = "#fae4fc",
    -- cyan
    terminal_color_6 = "#add7ff",
    terminal_color_14 = "#89ddff",
    -- white
    terminal_color_7 = "#ffffff",
    terminal_color_15 = "#ffffff",
  },
}
