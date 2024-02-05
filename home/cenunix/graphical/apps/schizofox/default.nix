{ config
, lib
, pkgs
, osConfig
, ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
  startpage = pkgs.substituteAll {
    src = ./startpage.html;
  };
  user = osConfig.modules.system.username;
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    xdg.configFile."firefoxcss/chrome".source = ./chrome;
    programs.firefox = mkDefault {
      enable = true;
      profiles.default.id = 0;
      profiles.default.name = "mine";
      profiles.default.isDefault = true;
      profiles.default = {
        # userChrome = ''
        #   @import "/home/${user}/.config/firefoxcss/chrome/userChrome.css";
        # '';
        # userContent = ''
        #   @import "/home/${user}/.config/firefoxcss/chrome/userContent.css";
        # '';
        settings = mkIf (osConfig.modules.device.gpu == "nvidia") {
          "media.ffmpeg.vaapi.enabled" = true;
          "widget.dmabuf.force-enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "media.av1.enabled" = true;
          "gfx.x11-egl.force-enabled" = true;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.fullscreen.autohide" = false;
          "browser.newtab.extensionControlled" = false;
          "browser.startup.homepage" = "file://${startpage}";

          "media.hardware-video-decoding.force-enabled" = true;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "layout.frame_rate" = 60;
          "layout.css.backdrop-filter.enabled" = true;

          "layout.css.devPixelsPerPx" = "-1.0";
          "devtools.chrome.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # "browser.startup.homepage" = "file://${startpage}";
          # "browser.newtabpage.enabled" = false;
          # Normal useragent
          "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36";

          "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
          "browser.uidensity" = 1;

          #   # remove useless stuff from the bar
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_temporary-containers-browser-action","nixos_ublock-browser-action","nixos_ether_metamask-browser-action","nixos_cookie-autodelete-browser-action","screenshot-button","panic-button","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_sponsor-block-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_darkreader-browser-action","bookmarks-menu-button","nixos_df-yt-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","sponsorblocker_ajay_app-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","dontfuckwithpaste_raim_ist-browser-action","ryan_unstoppabledomains_com-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","fxa-toolbar-menu-button","nixos_absolute-copy-browser-action","webextension_metamask_io-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action","nixos_dontcare-browser-action","nixos_skipredirect-browser-action","nixos_ublock-browser-action","nixos_darkreader-browser-action","nixos_fb-container-browser-action","nixos_vimium-ff-browser-action","nixos_df-yt-browser-action","nixos_sponsor-block-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","dontfuckwithpaste_raim_ist-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","ryan_unstoppabledomains_com-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","webextension_metamask_io-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":29}
          '';
        };
      };

      package = with pkgs;
        wrapFirefox
          firefox-bin-unwrapped
          {
            # see https://github.com/mozilla/policy-templates/blob/master/README.md
            extraPolicies = {
              ExtensionSettings =
                let
                  mkForceInstalled = extensions:
                    builtins.mapAttrs
                      (name: cfg: { installation_mode = "force_installed"; } // cfg)
                      extensions;
                in
                mkForceInstalled {
                  "addon@darkreader.org".install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                  "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                  "{36bdf805-c6f2-4f41-94d2-9b646342c1dc}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/export-cookies-txt/latest.xpi";
                  "{74145f27-f039-47ce-a470-a662b129930a}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
                  "{b86e4813-687a-43e6-ab65-0bde4ab75758}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
                  "DontFuckWithPaste@raim.ist".install_url = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
                  "{c607c8df-14a7-4f28-894f-29e8722976af}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
                  "skipredirect@sblask".install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
                  "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                  "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
                  "{47bf427e-c83d-457d-9b3d-3db4118574bd}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/nighttab/latest.xpi";
                };

              FirefoxHome = {
                Pocket = false;
                Snippets = false;
              };
              PasswordManagerEnabled = false;
              # PromptForDownloadLocation = false;
              UserMessaging = {
                ExtensionRecommendations = true;
                SkipOnboarding = true;
              };
              # SanitizeOnShutdown = {
              #   Cache = true;
              #   History = true;
              #   Cookies = true;
              #   Downloads = true;
              #   FormData = true;
              #   Sessions = true;
              #   OfflineApps = true;
              # };
            };
          };
    };
  };
}
