{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-ts-rainbow # treesitter color brackets
      nvim-ts-autotag
      nvim-ts-context-commentstring
    ];
    plugins.telescope = {
      enable = true;
      extensions.fzf-native = {
        enable = true;
        fuzzy = true;
        caseMode = "smart_case";
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
