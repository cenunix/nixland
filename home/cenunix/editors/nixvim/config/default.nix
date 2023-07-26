{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./completions.nix
    ./core.nix
    ./plugins
    ./keymaps.nix
  ];
  config = {
    options = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus"; # Connection to the system clipboard
      # fileencoding = "utf-8"; # File content encoding for the bufferf
      timeoutlen = 300;
      tabstop = 2;
      shiftwidth = 2;
      scrolloff = 2; # keeps lines above and below
      breakindent = true; # Wrap indent to match  line start
      preserveindent = true; # Preserve indent structure as much as possible
      expandtab = true;
      copyindent = true; # Copy the previous indentation on autoindenting
      wrap = false;
      linebreak = true;
      hlsearch = false;
      smartcase = true;
      ignorecase = true;
      # fillchars = {eob = " ";}; # Disable `~` on nonexistent lines
      foldenable = true; # enable fold for nvim-ufo
      foldlevel = 99; # set high foldlevel for nvim-ufo
      foldlevelstart = 99; # start with all code unfolded
      foldcolumn = "1"; # show foldcolumn in nvim 0.9
    };
    extraPlugins = [
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.vim-clang-format
      pkgs.vimPlugins.presence-nvim
      pkgs.nodePackages_latest.live-server
      pkgs.clang-tools
    ];
    extraConfigLua = ''
      -- Description of each option can be found in https://github.com/andweeb/presence.nvim
      require("presence").setup({
          -- General options
          auto_update         = true,
          neovim_image_text   = "How do i exit this thing (⚈₋₍⚈)",
          main_image          = "neovim",
          client_id           = "793271441293967371",
          log_level           = nil,
          debounce_timeout    = 10,
          enable_line_number  = false,
          blacklist           = {},
          buttons             = true,
          file_assets         = {},
          show_time           = true,

          -- Rich Presence text options
          editing_text        = "Prolly debugging  (っ⇀__↼ ς)",
          file_explorer_text  = "Prolly debugging  (っ⇀__↼ ς)",
          git_commit_text     = "Prolly debugging  (っ⇀__↼ ς)",
          plugin_manager_text = "Prolly debugging  (っ⇀__↼ ς)",
          reading_text        = "Prolly debugging  (っ⇀__↼ ς)",
          workspace_text      = "Working on %s",
          line_number_text    = "Prolly debugging  (っ⇀__↼ ς)",
      })
    '';
  };
}
