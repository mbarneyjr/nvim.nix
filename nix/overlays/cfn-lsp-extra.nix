{ cfn-lsp-extra }:
final: prev: {
  python3Packages = prev.python3Packages // {
    cfn-lsp-extra = final.python3Packages.buildPythonApplication {
        name = "cfn-lsp-extra";
        version = "0.7.2";
        src = cfn-lsp-extra;
        pyproject = true;
        propagatedBuildInputs = with final.python3Packages; [
          poetry-core
          poetry-dynamic-versioning
          setuptools
          click
          cfn-lint
          pygls
          pyyaml
          types-pyyaml
          platformdirs
          attrs
          importlib-resources
          aws-sam-translator
          botocore
        ];
        doCheck = false;
      };
  };
}

