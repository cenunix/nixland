{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./autopairs.nix
    ./bufferline.nix
    ./colorscheme.nix
    ./lsp.nix
    ./formatting.nix
    ./lualine.nix
    ./neotree.nix
    ./presence.nix
    ./telescope.nix
    ./terminal.nix
    ./treesitter.nix
    ./which-key.nix
  ];
  config = {
    plugins = {
      gitsigns = {
        enable = true;
      };

      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
    };
  };
}
