{ buildPythonPackage, pace-src, cftime, numpy, fsspec, typing-extensions, f90nml
}:
buildPythonPackage {
  name = "pace-util";
  version = "0.1.0";
  src = "${pace-src}/pace-util";
  propagatedBuildInputs = [ cftime numpy fsspec typing-extensions f90nml ];
}
