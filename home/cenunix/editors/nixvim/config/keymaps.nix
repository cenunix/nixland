{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    maps.normal."<leader>w" = {
      action = "<cmd>w<CR>";
      silent = true;
      desc = "Save";
    };
    maps.normal."<leader>q" = {
      action = "<cmd>confirm q<CR>";
      silent = true;
      desc = "Quit";
    };
    maps.normal."<leader>e" = {
      action = ":Neotree action=focus reveal toggle<CR>";
      silent = true;
      desc = "Toggle Neotree";
    };
    maps.normal."<leader>ff" = {
      action = ":Telescope find_files<CR>";
      silent = true;
      desc = "Find Files";
    };
    maps.normal."<leader>fw" = {
      action = ":Telescope live_grep<CR>";
      silent = true;
      desc = "Grep Files";
    };
    maps.normal."<leader>fb" = {
      action = ":Telescope buffers<CR>";
      silent = true;
      desc = "Grep Buffers";
    };
    maps.normal."<leader>fh" = {
      action = ":Telescope help_tags<CR>";
      silent = true;
      desc = "Grep Help Tags";
    };
    maps.normal."<leader>fd" = {
      action = ":Telescope diagnostics<CR>";
      silent = true;
      desc = "Grep Diagnostics";
    };
    maps.normal."<leader>fg" = {
      action = ":Telescope git_files<CR>";
      silent = true;
      desc = "Grep Git Files";
    };
    maps.normal."<leader>fp" = {
      action = ":Telescope oldfiles<CR>";
      silent = true;
      desc = "Grep Old Files";
    };
    maps.normal."]g" = {
      action = "<cmd>Gitsigns next_hunk<CR>";
      silent = true;
      desc = "Next Git hunk";
    };
    maps.normal."[g" = {
      action = "<cmd>Gitsigns prev_hunk<CR>";
      silent = true;
      desc = "Previous Git hunk";
    };
    maps.normal."<leader>gl" = {
      action = "<cmd>Gitsigns blame_line<CR>";
      silent = true;
      desc = "View Git blame";
    };
    maps.normal."<leader>gL" = {
      action = "<cmd>Gitsigns blame_line {full = true}<CR>";
      silent = true;
      desc = "View full Git blame";
    };
    maps.normal."<leader>gp" = {
      action = "<cmd>Gitsigns preview_hunk<CR>";
      silent = true;
      desc = "Preview Git hunk";
    };
    maps.normal."<leader>gh" = {
      action = "<cmd>Gitsigns reset_hunk<CR>";
      silent = true;
      desc = "Reset Git hunk";
    };
    maps.normal."<leader>gr" = {
      action = "<cmd>Gitsigns reset_buffer<CR>";
      silent = true;
      desc = "Reset Git buffer";
    };
    maps.normal."<leader>gs" = {
      action = "<cmd>Gitsigns stage_hunk<CR>";
      silent = true;
      desc = "Stage Git hunk";
    };
    maps.normal."<leader>gS" = {
      action = "<cmd>Gitsigns stage_buffer<CR>";
      silent = true;
      desc = "Stage Git buffer";
    };
    maps.normal."<leader>gu" = {
      action = "<cmd>Gitsigns undo_stage_hunk<CR>";
      silent = true;
      desc = "Unstage Git hunk";
    };
    maps.normal."<leader>gd" = {
      action = "<cmd>Gitsigns diffthis<CR>";
      silent = true;
      desc = "View Git diff";
    };
    maps.normal."<leader>lD" = {
      action = "<cmd>Telescope diagnostics<CR>";
      silent = true;
      desc = "Search Diagnostics";
    };
    maps.normal."<leader>li" = {
      action = "<cmd>LspInfo<CR>";
      silent = true;
      desc = "LSP Information";
    };
    maps.normal."<leader>lI" = {
      action = "<cmd>NullLsInfo<CR>";
      silent = true;
      desc = "Null-ls Information";
    };
    maps.normal."<leader>la" = {
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      silent = true;
      desc = "LSP Code Action";
    };
    maps.normal."<leader>ll" = {
      action = "<cmd>lua vim.lsp.codelens.refresh()<CR>";
      silent = true;
      desc = "LSP CodeLens Refresh";
    };
    maps.normal."<leader>lL" = {
      action = "<cmd>lua vim.lsp.codelens.run()<CR>";
      silent = true;
      desc = "LSP CodeLens run";
    };
    maps.normal."gd" = {
      action = '':Telescope lsp_definitions<CR>'';
      silent = true;
      desc = "Goto Definition";
    };
    maps.normal."gI" = {
      action = '':Telescope lsp_implementations<CR>'';
      silent = true;
      desc = "Goto Definition";
    };
    maps.normal."gl" = {
      action = ''<cmd>lua vim.diagnostic.open_float()<CR>'';
      silent = true;
      desc = "Hover Diagnostics";
    };
    maps.normal."[d" = {
      action = ''<cmd>lua vim.diagnostic.goto_prev()<CR>'';
      silent = true;
      desc = "Previous Diagnostic";
    };
    maps.normal."]d" = {
      action = ''<cmd>lua vim.diagnostic.goto_next()<CR>'';
      silent = true;
      desc = "Next Diagnostic";
    };
    maps.normal."K" = {
      action = ''<cmd>lua vim.lsp.buf.hover()<CR>'';
      silent = true;
      desc = "Hover symbol details";
    };

    # maps.normal."gD" = {
    #   action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
    #   desc = "Goto Declaration";
    # };
    # maps.normal."gd" = "<cmd>lua vim.lsp.buf.definition()<CR>";
    maps.normal."gi" = "<cmd>lua vim.lsp.buf.implementation()<CR>";
    # maps.normal."<C-k>" = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
    maps.normal."gr" = "<cmd>lua vim.lsp.buf.references()<CR>";
    maps.normal."<leader>ck" = "<cmd>lua vim.diagnostic.open_float()<CR>";
    maps.normal."<leader>ca" = "<cmd>lua vim.lsp.buf.code_action()<CR>";
    maps.normal."<leader>cf" = "<cmd>lua vim.lsp.buf.format()<CR>";

    # maps.normal."<leader>w" = {
    #   action = "<cmd>w<CR>";
    #   silent = true;
    #   desc = "Save";
    # };
    # maps.normal."<leader>q" = {
    #   action = "<cmd>confirm q<CR>";
    #   silent = true;
    #   desc = "Quit";
    # };
    extraConfigLua = ''
      tree_toggle = function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end
      vim.keymap.set("n", "<leader>o", tree_toggle)
    '';
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
