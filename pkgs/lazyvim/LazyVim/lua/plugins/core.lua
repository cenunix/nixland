return {
{
    "LazyVim/LazyVim",
    opts = {
    colorscheme = function()
        require("catppuccin").load()
            transparent_background = false, -- disables setting the background color.
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
        end,
    end,
  },
}
