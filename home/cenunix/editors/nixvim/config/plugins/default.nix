{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./colorscheme.nix
    ./lsp.nix
    ./formatting.nix
    ./lualine.nix
    ./neotree.nix
    ./telescope.nix
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
