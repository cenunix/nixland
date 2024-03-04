local wk = require("which-key")
wk.setup({
  window = {
    border = "single",
  },
})
wk.register({
  ["<leader>"] = {
    w = { "<cmd>w<cr>", "Save Buffer" },
    q = { "<cmd>q<cr>", "Quit" },
    e = { ":Neotree action=focus reveal toggle<cr>", "Toggle Neotree" },
    o = {
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd("p")
        else
          vim.cmd.Neotree("focus")
        end
      end,
      "Neotree Focus",
    },
    c = { ":bdelete!<CR>", "Close Buffer" },
    a = {
      name = "Harpoon",
      a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" },
      e = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Open Quick Menu" },
      ["1"] = {
        function()
          require("harpoon.ui").nav_file(1)
        end,
        "Nav File 1",
      },
      ["2"] = {
        function()
          require("harpoon.ui").nav_file(2)
        end,
        "Nav File 2",
      },
      ["3"] = {
        function()
          require("harpoon.ui").nav_file(3)
        end,
        "Nav File 3",
      },
      ["4"] = {
        function()
          require("harpoon.ui").nav_file(4)
        end,
        "Nav File 4",
      },
    },

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
    t = {
      name = "File",
      t = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
      f = { "<cmd>ToggleTerm direction=float<cr>", "Toggle Float Terminal" },
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
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code Action" },
      h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Current Symbol" },
      l = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "LSP CodeLens Refresh" },
      L = { "<cmd>lua vim.lsp.codelens.run()<cr>", "LSP CodeLens Run" },
      R = { "<cmd>Telescope lsp_references<cr>", "Search References" },
    },
  },
  ["g"] = {
    d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    I = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
    r = { "<cmd>Telescope lsp_references<cr>", "Search References" },
    l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Hover Diagnostics" },
    y = { "<cmd>Telescope lsp_type_definitions<cr>", "Definition of Current Type" },
  },
  ["<S-h>"] = { "<cmd>bprevious<cr>", "Left Buffer" },
  ["<S-l>"] = { "<cmd>bnext<cr>", "Right Buffer" },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Symbol Details" },
})
