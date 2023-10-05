require("catppuccin").setup {
    transparent_background = true, -- disables setting the background color.
    color_overrides = {
        all = {
            text = "#ffffff",
        },
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {
            base = "#11111b",
            -- mantle = "#242424",
            -- crust = "#474747",
        },
    }
}
vim.cmd("colorscheme catppuccin-mocha")

