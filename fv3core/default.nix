{ buildPythonPackage, fetchFromGitHub, fv3gfs-util, f90nml, gt4py-dev, pytest
, pytest-subtests }:
let
  # Newer version of fv3gfs-util -- should match submodule version
  fv3gfs-util-dev = fv3gfs-util.overridePythonAttrs (old: {
    src = fetchFromGitHub {
      owner = "VulcanClimateModeling";
      rev = "1d7c302b836befe905d776b0a972f464bfd3a255";
      repo = old.pname;
      sha256 = "02hr8797gw582650g4x9mw6giaw3kamhzkdb0jkxs0wbnzi3zbkr";
    };
  });

in buildPythonPackage rec {
  pname = "fv3core";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "VulcanClimateModeling";
    repo = pname;
    rev = "64e63957119641fa842a530f38b1b306e8f554eb";
    sha256 = "0krcb8l07648mrdp00ps6ykfds5jiqavhq1h3xj8cqz7xhjnazb5";
  };

  propagatedBuildInputs = [ f90nml fv3gfs-util-dev gt4py-dev serialbox ];

  pipInstallFlags = [ "--no-deps" ];
  doCheck = false;
  pythonImportCheck = [ "fv3core" ];
}
