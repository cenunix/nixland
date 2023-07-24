{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = false;
        indent = true;
        moduleConfig.autotag = {
          enable = true;
          filetypes = ["html" "xml" "astro" "javascriptreact" "typescriptreact" "svelte" "vue"];
        };
        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cpp
          html
          javascript
          latex
          lua
          nix
          norg
          python
          rust
          vimdoc
          vim
          regex
          markdown
          markdown_inline
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
