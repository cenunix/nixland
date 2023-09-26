{ lib
, pkgs
, python3
, fetchFromGitHub
, python3Packages
,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "rd_api_py";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "s-krilla";
    repo = "rd_api_py";
    rev = "aa5ccd9816ad9805cbccb420cf324ea7b9c86df4";
    sha256 = "";
  };
  #   propagatedBuildInputs = [ pkgs.python310Packages.bleak pkgs.python310Packages.poetry-core ];
  meta = with lib; {
    homepage = "https://github.com/s-krilla/rd_api_py";
    description = "Real_debrid python api";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ cenunix ];
  };
}
