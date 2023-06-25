local utils = require("astronvim.utils")
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter", enabled = false
  -- },
  { import = "astrocommunity.pack.yaml" },
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    init = function()
      astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "dartls")
    end,
    opts = {
      lsp = require("astronvim.utils.lsp").config("dartls"),
      debugger = {
        enabled = true,
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "dart")
        end,
      },
    },
  },
  -- Add "flutter" extension to "telescope"
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      require("telescope").load_extension("flutter")
    end,
  },
}
