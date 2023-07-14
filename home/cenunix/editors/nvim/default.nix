{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep optional;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  populateEnv = ./populate-nvim-env.py;

  populateEnvScript = ''
    mkdir -p ${config.xdg.dataHome}/nvim/site/plugin
    ${pkgs.python39}/bin/python ${populateEnv} -o ${config.xdg.dataHome}/nvim/site/plugin
  '';
  # }}}
in {
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim.enable = true;

  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  xdg.configFile."nvim" = {
    source = "${pkgs.lazyvim}";
  };

  home.packages = with pkgs; [
    lazyvim
    neovide # neovim gui
    (pkgs.writeShellScriptBin "update-nvim-env" ''
      #
      # update-nvim-env
      #
      # Update neovim env such that it can be used in neovide or other GUIs.
      ${populateEnvScript}
    '')
  ];

  home.activation.neovim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Populating neovim env..."
    ${populateEnvScript}
  '';

  programs.bash.initExtra = lib.mkAfter ''
    export EDITOR="${config.programs.neovim.package}/bin/nvim"
  '';

  programs.zsh.initExtra = lib.mkAfter ''
    export EDITOR="${config.programs.neovim.package}/bin/nvim"
  '';

  # Required packages -------------------------------------------------------------------------- {{{

  programs.neovim = {
    extraPackages = with pkgs; [
      lazygit # git TUI
      #Lua
      lua-language-server # lua lsp
      stylua # lua linter

      # C/C++
      gcc
      cpplint # C
      clang-tools
      gnumake

      #Shell stuffs
      shfmt # shell
      shellcheck # bash

      # nix shit
      nil # nix language server
      nixpkgs-fmt # nix package formatter
      statix # nix linter and suggestions
      deadnix # remove unused nix

      # GoLang
      go
      gopls # go
      revive # go formatter
      asmfmt # go formatter 2
      gofumpt # go formattter 3

      black # python
      nodejs # take a guess
      marksman # markdown language server
      nodePackages.pyright
      nodePackages.prettier
      nodePackages.stylelint
      nodePackages.jsonlint # JSON
      nodePackages.typescript-language-server # Typescript
      nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.node2nix # node and tix, we game
      vimPlugins.nvim-treesitter.withAllGrammars
      nodePackages_latest.live-server # for web dev
    ];
    plugins = with pkgs; [
      vimPlugins.clangd_extensions-nvim
    ];
  };
  # }}}
}
