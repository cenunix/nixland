return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    -- color_overrides = {
    --   all = {
    --     rosewater = "#506477", --changed "bluegray3"
    --     flamingo = "#F0C6C6",
    --     pink = "#F5BDE6",
    --     mauve = "#add7ff", --changed "blue2"
    --     red = "#7390AA",  --changed "blue4"
    --     maroon = "#FAE4FC", --changed "pink1"
    --     peach = "#fffac2", --changed "yellow"
    --     yellow = "#767c9d", --changed "blueGray2"
    --     green = "#99e6bf", --changed "custom iceberg green"
    --     teal = "#91b4d5", --changed "blue3"
    --     sky = "#5fb3a1",  --changed "teal2"
    --     sapphire = "#89ddff", --changed "blue1"
    --     blue = "#5DE4C7", --changed "teal1"
    --     lavender = "#ffffff", --changed "blueGray1"
    --
    --     text = "#E4F0FB", --changed all below
    --     subtext1 = "#959db8",
    --     subtext0 = "#959db8",
    --     overlay2 = "#7b85a6",
    --     overlay1 = "#626d92",
    --     overlay0 = "#515977",
    --     surface2 = "#5B6078", --these are for comments
    --     surface1 = "#494D64", -- ^
    --     surface0 = "#363A4F", -- ^
    --
    --     base = "#14151e",
    --     mantle = "#171922",
    --     crust = "#171922",
    --   },
    -- },
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
  },
}
