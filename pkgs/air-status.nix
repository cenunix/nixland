{
  lib,
  pkgs,
  python3,
  fetchFromGitHub,
  python3Packages,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "AirStatus";
  version = "0.1.2";
  format = "pyproject";
  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "AirStatus";
    rev = "56d521a78df18899985cb1971bb86a6694477a90";
    sha256 = "sha256-WRJixBV45Fm+cmDkXzCr9fZoulv2sRsq2hX6tlEaLSk=";
  };
  propagatedBuildInputs = [pkgs.python310Packages.bleak pkgs.python310Packages.poetry-core];
  meta = with lib; {
    homepage = "https://github.com/delphiki/AirStatus";
    description = "Battery level for airpods";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [cenunix];
  };
}
