{ lib, buildPythonPackage, fetchFromGitHub, poetry-core
, poetry-dynamic-versioning, pygments, rich, pytestCheckHook }:

buildPythonPackage rec {
  pname = "catppuccin";
  version = "2.2.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "python-catppuccin";
    rev = "9144e99ef44b33eef2f9004c3774d1ff77841bdb";
    hash = "sha256-DzCC8X9lCvextO9E4g7pPgGrwpYRouwuZ4nZNljV2wA=";
  };

  build-system = [ poetry-core poetry-dynamic-versioning ];

  optional-dependencies = {
    pygments = [ pygments ];
    rich = [ rich ];
  };

  nativeCheckInputs = [ pytestCheckHook ]
    ++ lib.flatten (lib.attrValues optional-dependencies);

  pythonImportsCheck = [ "catppuccin" ];

  meta = {
    description = "Soothing pastel theme for Python";
    homepage = "https://github.com/catppuccin/python";
    maintainers = with lib.maintainers; [ fufexan tomasajt ];
    license = lib.licenses.mit;
  };
}
