{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = false;
        indent = true;

        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          bash
          c
          html
          javascript
          latex
          lua
          nix
          norg
          python
          rust
          vimdoc
          go
        ];
      };

      treesitter-refactor = {
        enable = false;
        highlightDefinitions.enable = true;
      };
    };
  };
}
