let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in
''
  * {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: Material Design Icons, Iosevka Nerd Font;
  }

  window#waybar {
    background-color: #24273a;
    border-radius: 0px;
    color: #cad3f5;
    font-size: 16px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #pulseaudio {
    color: #a6da95;
  }

  #custom-vpn,
  #network {
    color: #8aadf4;
  }

  #cpu {
    color: #8aadf4;
  }

  #workspaces button {
    background-color: transparent;
    /* Use box-shadow instead of border so the text isn't offset */
    color: #8aadf4;
    padding-left: 6px;
    box-shadow: inset 0 -3px transparent;
    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
  }

  #workspaces button:hover {
    color: #b7bdf8;
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #custom-power {
      color: #8aadf4;
      margin: 7px;
      font-size: 24px;
  }

  #workspaces button.active {
    color: #eed49f;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
  }

  #workspaces button.urgent {
    background-color: #ee99a0;
  }
  #custom-weather,

  #clock,
  #network,
  #custom-swallow,
  #cpu,
  #battery,
  #backlight,
  #memory,
  #workspaces,
  #custom-todo,
  #custom-lock,
  #custom-vpn,
  #custom-weather,
  #custom-eth,
  #volume,
  #pulseaudio {
    border-radius: 15px;
    background-color: #11111b;
    padding: 0px 10px 0px 10px;
    margin: 5px 0px 5px 0px;
  }

  #custom-swallow {
    color: #8bd5ca;
  }


  #custom-eth {
    color: #8aadf4;
  }

  #custom-lock {
      color: #8aadf4;
      padding: 0 20px 0 20px;
  }

  #custom-todo {
    color: #b8c0e0;
  }

  #custom-search {
    background-image: url("${snowflake}");
    background-size: 65%;
    padding: 0 15px 0 15px;
    margin: 5px;
    background-position: center;
    background-repeat: no-repeat;
  }
  #backlight {
    color: #eed49f;
  }
  #battery {
    color: #a6da95;
  }

  #battery.warning {
    color: #f5a97f;
  }

  #battery.critical:not(.charging) {
    color: #ed8796;
  }
  tooltip {
    font-family: 'Lato', sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
  }
  tooltip label {
    font-family: 'Lato', sans-serif;
    padding: 20px;
  }
''
