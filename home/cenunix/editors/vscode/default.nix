{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions;
        [
          arrterian.nix-env-selector
          bbenoist.nix
          catppuccin.catppuccin-vsc
          christian-kohler.path-intellisense
          dbaeumer.vscode-eslint
          eamodio.gitlens
          esbenp.prettier-vscode
          formulahendry.code-runner
          golang.go
          ibm.output-colorizer
          ms-vscode.cpptools
          naumovs.color-highlight
          oderwat.indent-rainbow
          pkief.material-icon-theme
          shardulm94.trailing-spaces
          sumneko.lua
          timonwong.shellcheck
          usernamehw.errorlens
          xaver.clang-format
          yzhang.markdown-all-in-one
          redhat.vscode-yaml
          irongeek.vscode-env
          github.vscode-pull-request-github
          github.codespaces
          WakaTime.vscode-wakatime
          b4dm4n.vscode-nixpkgs-fmt
          github.copilot
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "volar";
            publisher = "vue";
            version = "1.0.12";
            sha256 = "sha256-D9E3KRUOlNVXH4oMv1W0+/mbqO8Se7+6E2F5P/KvCro=";
          }
          {
            name = "vscode-typescript-vue-plugin";
            publisher = "vue";
            version = "1.0.12";
            sha256 = "sha256-WiL+gc9+U861ubLlY/acR+ZcrFT7TdIDR0K1XNNidX8=";
          }
          {
            name = "vscode-typescript-next";
            publisher = "ms-vscode";
            version = "5.0.202301100";
            sha256 = "sha256-8d/L9F06ZaS9dTOXV6Q40ivI499nfZLQURcLdHXoTSM=";
          }
          {
            name = "vscode-chromium-vector-icons";
            publisher = "adolfdaniel";
            version = "1.0.2";
            sha256 = "sha256-Meo53e/3jUP6YDEXOA/40xghI77jj4iAQus3/S8RPZI=";
          }
        ];
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "catppuccin.accentColor" = "mauve";
        "editor.fontFamily" = "JetBrainsMono Nerd Font, Material Design Icons, 'monospace', monospace";
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "workbench.fontAliasing" = "antialiased";
        "files.trimTrailingWhitespace" = true;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "window.titleBarStyle" = "custom";
        "terminal.integrated.automationShell.linux" = "nix-shell";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.enableBell" = false;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.overviewRulerBorder" = false;
        "editor.renderLineHighlight" = "all";
        "editor.inlineSuggest.enabled" = true;
        "editor.smoothScrolling" = true;
        "editor.suggestSelection" = "first";
        "editor.guides.indentation" = true;
        "editor.guides.bracketPairs" = true;
        "editor.bracketPairColorization.enabled" = true;
        "window.nativeTabs" = true;
        "window.restoreWindows" = "all";
        "window.menuBarVisibility" = "toggle";
        "workbench.panel.defaultLocation" = "right";
        "workbench.editor.tabCloseButton" = "left";
        "workbench.startupEditor" = "none";
        "workbench.list.smoothScrolling" = true;
        "security.workspace.trust.enabled" = false;
        "explorer.confirmDelete" = false;
        "breadcrumbs.enabled" = true;
      };
    };
  };
}
