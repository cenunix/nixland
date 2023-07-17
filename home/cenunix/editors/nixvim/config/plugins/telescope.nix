{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
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
      action = ":Telescope buggers<CR>";
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
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        # "<leader>ff" = "find_files";
        # "<leader>fg" = "live_grep";
        # "<leader>fb" = "buffers";
        # "<leader>fh" = "help_tags";
        # "<leader>fd" = "diagnostics";

        # FZF like bindings
        # "<C-p>" = "git_files";
        # "<leader>p" = "oldfiles";
        # "<C-f>" = "live_grep";
      };

      keymapsSilent = true;

      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}
