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
    maps.normal."gd" = {
      action = ''<cmd>Telescope lsp_definitions{ reuse_win = true }<CR>'';
      silent = true;
      desc = "Goto Definition";
    };
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
