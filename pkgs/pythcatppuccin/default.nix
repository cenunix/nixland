{ lib, buildPythonPackage, fetchFromGitHub, poetry-core
, poetry-dynamic-versioning, pygments, rich, pytestCheckHook }:

buildPythonPackage rec {
  pname = "catppuccin";
  version = "2.2.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "catppuccin-python";
    rev = "f6a1d2d8c04107e8fe427b4f4b3d18f067c1a9bc";
    hash = "sha256-ye/JCznxCRWUlEbDScfEYL7/W9I8yw6gkK4jlhCkFfg=";
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
