{ pkgs
, lib
, inputs
, ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.hostPlatform.system}.default.overrideAttrs (self: {
      makeWrapperArgs = with pkgs;
        self.makeWrapperArgs
          or [ ]
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath [
            clang-tools
            marksman
            nil
            luajitPackages.lua-lsp
            nodePackages.bash-language-server
            nodePackages.vscode-css-languageserver-bin
            nodePackages.vscode-langservers-extracted
            nodePackages.prettier
            rustfmt
            rust-analyzer
            black
            nixpkgs-fmt
            shellcheck
          ])
        ];
    });

    settings = {
      theme = "catppuccin_macchiato";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "X" = "extend_line_above";
        "esc" = [ "collapse_selection" "keep_primary_selection" ];
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":bc";
        "C-q" = ":xa";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };
      keys.select = {
        "%" = "match_brackets";
      };
      editor = {
        color-modes = true;
        cursorline = true;
        mouse = false;
        idle-timeout = 1;
        line-number = "relative";
        scrolloff = 5;
        rainbow-brackets = true;
        completion-replace = true;
        cursor-word = true;
        bufferline = "always";
        true-color = true;
        soft-wrap.enable = true;
        indent-guides = {
          render = true;
        };
        sticky-context.enable = false;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        statusline = {
          mode-separator = "";
          separator = "";
          left = [ "mode" "selections" "spinner" "file-name" "total-line-numbers" ];
          center = [ ];
          right = [ "diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };
    };

    # override catppuccin theme and remove background to fix transparency

    languages = {
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "${pkgs.shfmt}/bin/shfmt";
            args = [ "-i" "2" "-" ];
          };
        }
        {
          name = "html";
          file-types = [ "html" "tera" ];
        }
        {
          name = "nix";
          auto-format = true;
        }
      ];

      language-server = {
        bash-language-server = {
          command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
          args = [ "start" ];
        };

        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
          clangd.fallbackFlags = [ "-std=c++2b" ];
        };

        typescript-language-server = with pkgs.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
        };


        nil = {
          command = lib.getExe pkgs.nil;
          config.nil.formatting.command = [ "${lib.getExe pkgs.nixpkgs-fmt}" ];
        };

        vscode-css-language-server = {
          command = "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver";
          args = [ "--stdio" ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
    typst
    shellcheck
    lldb
    gopls
    rust-analyzer
    clang-tools
    nodejs
    guile
    nim
    zig
    texlab
    zls
    jre8
    gcc
    uncrustify
    black
    nixpkgs-fmt
    shellcheck
    gawk
    haskellPackages.haskell-language-server
    java-language-server
    kotlin-language-server
    nodePackages.vls
    nodePackages.jsonlint
    nodePackages.yarn
    nodePackages.vscode-langservers-extracted
    cargo
  ];
}
