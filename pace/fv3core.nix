{ buildPythonPackage, pace-src, numpy, gt4py, f90nml, pace-util }:
buildPythonPackage {
  name = "pace-fv3core";
  version = "0.1.0";
  src = "${pace-src}/fv3core";
  propagatedBuildInputs = [ f90nml gt4py pace-util ];
  pipInstallFlags = [ "--no-deps" ];
  doCheck = false;
}
