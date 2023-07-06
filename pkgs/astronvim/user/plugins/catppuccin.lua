return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    dim_inactive = { enabled = false, percentage = 0.25 },
    integrations = {
      nvimtree = true,
      aerial = true,
      dap = { enabled = true, enable_ui = true },
      mason = true,
      neotree = true,
      notify = true,
      sandwich = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      which_key = true,
    },
    custom_highlights = {
      NeoTreeNormal = { bg = "NONE", fg = "NONE" },
      NeoTreeNormalNC = { bg = "NONE", fg = "NONE" },
    },
  },
}
