{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, poetry-dynamic-versioning
, pygments
, rich
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "catppuccin";
  version = "2.2.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "catppuccin-python";
    rev = "93f33f58bb1a8421d89b911e3780873dae0f16a1";
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
