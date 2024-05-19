{ lib, buildPythonPackage, fetchFromGitHub, poetry-core
, poetry-dynamic-versioning, pygments, rich, pytestCheckHook }:

buildPythonPackage rec {
  pname = "catppuccin";
  version = "2.2.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "catppuccin-python";
    rev = "46fea9b5720ff4aaaff3b8d515b345e29ecf0ed8";
    hash = "sha256-PaMVH2tMpRTA9aUKC92z5Qdb2Ax5wKy0kEN7FgdbdIM=";
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
