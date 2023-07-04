{
  lib,
  pkgs,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage {
  pname = "AirStatus";
  version = "1.0.1";
  src = fetchFromGitHub {
    owner = "delphiki";
    repo = "AirStatus";
    rev = "47e86aee790dea4bc2463559f8093687434fdbd5";
    sha256 = "";
  };
  propagatedBuildInputs = [
    pkgs.python310Packages.bleak
  ];
  meta = with lib; {
    homepage = "https://github.com/delphiki/AirStatus";
    description = "Battery level for airpods";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [cenunix];
  };
}
