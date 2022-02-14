{ buildPythonPackage, pace-src, numpy, gt4py, pace-util }:
buildPythonPackage {
  name = "pace-dsl";
  version = "0.1.0";
  src = "${pace-src}/stencils";
  propagatedBuildInputs = [ gt4py pace-util ];
  pipInstallFlags = [ "--no-deps" ];
  doCheck = false;
}
