{ cfn-lsp-extra }:
final: prev: 
let
  aws-sam-translator = prev.python3Packages.aws-sam-translator.overrideAttrs (old: rec {
    version = "1.97.0";

    src = prev.fetchFromGitHub {
      owner = "aws";
      repo = "serverless-application-model";
      tag = "v${version}";
      hash = "sha256-3otCvuVB+TARBYSsNuDldw3A+n2m0HNHjEHD66Hk49U=";
    };

    doCheck = false;
  });
  cfn-lint = (prev.python3Packages.cfn-lint.overrideAttrs (old: rec {
    version = "1.34.2";

    src = prev.fetchFromGitHub {
      owner = "aws-cloudformation";
      repo = "cfn-lint";
      tag = "v${version}";
      hash = "sha256-sd+K2BdVi7zYWRuvnJpRie0g2GshoBQWuFC6mH5sPoY=";
    };

    doCheck = false;
  })).override { aws-sam-translator = aws-sam-translator; };
in
{
  python3Packages = prev.python3Packages // {
    cfn-lsp-extra = final.python3Packages.buildPythonApplication {
        name = "cfn-lsp-extra";
        version = "0.7.3";
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

