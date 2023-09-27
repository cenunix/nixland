{ lib
, pkgs
, python3
, stdenv
, fetchFromGitHub
, python310Packages
,
}:
let
  my-python-packages = [
    python3.pkgs.buildPythonPackage
    rec {
      pname = "rd_api_py";
      version = "0.0.1";
      src = fetchFromGitHub {
        owner = "s-krilla";
        repo = "rd_api_py";
        rev = "aa5ccd9816ad9805cbccb420cf324ea7b9c86df4";
        sha256 = "sha256-vQj46o1cTEHGFJZekyFKAKAQlN9qE0odEynIdguI9Uw=";
      };
      propagatedBuildInputs = [ pkgs.python310Packages.pip python310Packages.python-dotenv ];
      meta = with lib; {
        homepage = "https://github.com/s-krilla/rd_api_py";
        description = "Real_debrid python api";
        license = licenses.gpl3Only;
        maintainers = with maintainers; [ cenunix ];
      };
    }
  ];
in
stdenv.mkDerivation {
  pname = "rd_refresh";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "s-krilla";
    repo = "rd_refresh";
    rev = "9af31e6e62192ddaac1c86bd7a4f79b987284181";
    sha256 = "";
  };
  propagatedBuildInputs = [ my-python-packages ];
  installPhase = "
      install -Dm755 refresh.py $out/bin/refresh
      install -Dm755 unrestrict.py $out/bin/unrestrict
      install -Dm755 functions.py $out/bin/functions
      ";
  meta = with lib; {
    homepage = "https://github.com/s-krilla/rd_api_py";
    description = "Real_debrid python api";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ cenunix ];
  };
}
