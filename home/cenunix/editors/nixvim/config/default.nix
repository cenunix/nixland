{ inputs
, outputs
, lib
, config
, pkgs
, ...
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
      pkgs.clang-tools_16
    ];
  };
}
