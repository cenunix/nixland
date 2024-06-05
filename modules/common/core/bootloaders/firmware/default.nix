{ stdenvNoCC, pkgs, lib, fetchFromGitHub }:

let
  aarch64-firmware = stdenvNoCC.mkDerivation rec {
    pname = "aarch64-firmware";
    version = "9f07579ee64aba56419cfd0fbbca9f26741edc90";

    src = fetchFromGitHub {
      owner = "linux-surface";
      repo = pname;
      rev = version;
      sha256 = "Lyav0RtoowocrhC7Q2Y72ogHhgFuFli+c/us/Mu/Ugc=";
    };

    dontFixup = true;
    dontBuild = true;

    installPhase = ''
      install -D -m644 firmware/qcom/sc8280xp/qcdxkmsuc8280.mbn $out/lib/firmware/qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    '';
  };

  x13s-alarm-firmware = stdenvNoCC.mkDerivation rec {
    pname = "x13s-alarm-firmware";
    version = "1.0.0";

    src = fetchFromGitHub {
      owner = "ironrobin";
      repo = "x13s-alarm";
      rev = "ab5b7ace34aac2ead4c006875fc9b2f85c39422d";
      sha256 = "sha256-MkuqxpzsSHzEOZHc4QyWA5XGauz0jsotJwdWDUBq/N0=";
    };

    dontFixup = true;
    dontBuild = true;

    installPhase = ''
      for i in a690_gmu.bin hpnv21.b8c  qcvss8280.mbn;
      do
        install -D -m644 x13s-firmware/$i $out/$i
      done
    '';
  };

in {
  linux-firmware-modified = stdenvNoCC.mkDerivation rec {
    pname = "linux-firmware-modified";
    version = pkgs.linux-firmware.version;

    dontFixup = true;
    dontBuild = true;

    src = pkgs.linux-firmware;

    installPhase = ''
      mkdir $out
      cp -Pr lib $out/lib

      # Video acceleration
      cp ${x13s-alarm-firmware}/qcvss8280.mbn $out/lib/firmware/qcom/sc8280xp/LENOVO/21BX
      install -D -m644 ${aarch64-firmware}/lib/firmware/qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn $out/lib/firmware/qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn

      # Install bluetooth firmware for X13s
      cp ${x13s-alarm-firmware}/hpnv21.b8c $out/lib/firmware/qca
      # rm $out/lib/firmware/qcom/sc8280xp/SC8280XP-LENOVO-X13S-tplg.bin
      # ln -s ${pkgs.linux-firmware}/lib/qcom/sc8280xp/LENOVO/21BX/audioreach-tplg.bin $out/lib/firmware/qcom/sc8280xp/SC8280XP-LENOVO-X13S-tplg.bin

      # Install gpu firmware for X13s
      cp ${x13s-alarm-firmware}/a690_gmu.bin $out/lib/firmware/qcom
    '';
  };
}
