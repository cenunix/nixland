{ flake
, config
, pkgs
, lib
, ...
}:
# some configurations are taken from
# https://github.com/astronvim/astronvim
let
  inherit (lib) concatStringsSep optional;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  cfg = config.programs.neovim;

  home = config.home.homeDirectory;
  populateEnv = ./populate-nvim-env.py;

  populateEnvScript = ''
    mkdir -p ${config.xdg.dataHome}/nvim/site/plugin
    ${pkgs.python39}/bin/python ${populateEnv} -o ${config.xdg.dataHome}/nvim/site/plugin
  '';
in
{
  # Neovim

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
    source = "${pkgs.astronvim}";
    # recursive = true;
  };

  home.packages = with pkgs; [

    gcc
    lua-language-server
    stylua
    shfmt

    # python
    python311Packages.flake8
    python311Packages.black
    python311Packages.python-lsp-server
    nodePackages_latest.pyright

    # web stuff
    prettierd
    eslint_d
    nodejs-slim
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest.stylelint
    nodePackages_latest.yaml-language-server
    nodePackages_latest.npm
    nodePackages_latest.live-server
    #C/C++
    clang-tools_16
    #go
    go
    gopls
    gofumpt
    # rust
    cargo
    rust-analyzer
    rustfmt
    # config
    taplo
    # nix
    nil
    deadnix
    statix
    nixpkgs-fmt

    (pkgs.writeShellScriptBin "update-nvim-env" ''
      ${populateEnvScript}
    '')
    (pkgs.writeShellScriptBin "clean-nvim-all" ''
      rm -rf ${config.xdg.dataHome}/nvim
      rm -rf ${config.xdg.cacheHome}/nvim
      rm -rf ${config.xdg.stateHome}/nvim
      rm -rf ${config.xdg.configHome}/nvim
    '')
    (pkgs.writeShellScriptBin "clean-nvim" ''
      rm -rf ${config.xdg.dataHome}/nvim
      rm -rf ${config.xdg.stateHome}/nvim
      rm -rf ${config.xdg.cacheHome}/nvim
    '')
  ];

  home.activation.neovim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Populating neovim env..."
    ${populateEnvScript}'';

  programs.zsh.initExtra = lib.mkIf cfg.enable (lib.mkAfter ''
    alias n="${pkgs.neovim}/bin/nvim"
  '');

  # sops = {
  #   age.keyFile = "${home}/.config/sops/age/keys.txt";
  #   age.generateKey = true;
  #   secrets = {
  #     openapi-key = {
  #       # owner = "rayandrew";
  #       mode = "0440";
  #       sopsFile = ../../secrets.yaml;
  #       # path = "%r/openapi-key.txt";
  #       path = "${config.home.homeDirectory}/.openai_api_key";
  #       # neededForUsers = true;
  #     };
  #   };
  # };
}
# vim: foldmethod=marker
