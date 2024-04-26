{ inputs, outputs, lib, config, pkgs, ... }:
let
  neovim = pkgs.neovim.override {
    # stupid defaults
    withPython3 = false;
    withRuby = false;
    configure = {
      # customRC = ''
      #   lua << EOF
      #   ${builtins.readFile config/init.lua}
      #   ${builtins.readFile config/autopairs.lua}
      #   ${builtins.readFile config/utils/icons.lua}
      #   ${builtins.readFile config/theme.lua}
      #   ${builtins.readFile config/bufferline.lua}
      #   ${builtins.readFile config/treesitter.lua}
      #   ${builtins.readFile config/navic.lua}
      #   ${builtins.readFile config/maps.lua}
      #   ${builtins.readFile config/gitsigns.lua}
      #   ${builtins.readFile config/harpoon.lua}
      #   ${builtins.readFile config/lualine.lua}
      #   ${builtins.readFile config/telescope.lua}
      #   ${builtins.readFile config/toggleterm.lua}
      #   ${builtins.readFile config/ui.lua}
      #   ${builtins.readFile config/comment.lua}
      #   ${builtins.readFile config/lsp/lsp.lua}
      #   ${builtins.readFile config/lsp/completions.lua}
      #   ${builtins.readFile config/lsp/null-ls.lua}
      #   ${builtins.readFile config/neotree.lua}
      # '';
      packages.myPlugins = with pkgs.vimPlugins; { start = [ lazyvim ]; };
    };
  };
in {
  config = {
    home.packages = with pkgs; [
      neovim
      neovide
      # deadnix
      # statix
      # nixd
      # nil
      # gopls
      # clang-tools
      # nodePackages.vscode-langservers-extracted
      # nodePackages.typescript-language-server
      # lua-language-server
      # stylua
      # prettierd
      # eslint_d
      # nixpkgs-fmt
      # nixfmt
      # nodePackages.pyright
      # qt6.qtdeclarative
      # black
      # isort
      # go
    ];
  };
}
