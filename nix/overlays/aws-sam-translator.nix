final: prev: {
  python3Packages = prev.python3Packages // {
    aws-sam-translator = prev.python3Packages.aws-sam-translator.overrideAttrs (old: rec {
      version = "1.97.0";

      src = prev.fetchFromGitHub {
        owner = "aws";
        repo = "serverless-application-model";
        tag = "v${version}";
        hash = "sha256-3otCvuVB+TARBYSsNuDldw3A+n2m0HNHjEHD66Hk49U=";
      };

      doCheck = false;

      meta = old.meta // {
        version = version;
      };
    });
  };
}

