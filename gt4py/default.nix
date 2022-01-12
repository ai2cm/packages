{ stdenv, lib, buildPythonPackage, fetchFromGitHub, attrs, black
, cached-property, click, dace, jinja2, numpy, packaging, pybind11, tabulate
, typing-extensions, boltons, cytoolz, scipy, devtools, Mako, networkx, pydantic
, toolz, typing-inspect, xxhash, boost, gridtools1, gridtools2, git
, llvmPackages, pythonOlder, callPackage, pre-commit, isort, rope, hypothesis
, pytest, pytest-cache, pytest-cov, pytest-factoryboy, sphinx, sphinx_rtd_theme
}:
buildPythonPackage rec {
  pname = "gt4py";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "GridTools";
    repo = pname;
    rev = "72909daf56b16742891d9ab2321c444a37a9c77d";
    sha256 = "148wjyy44b69vsafr3yfx0q0dd9hri7c4871xwfb9p5j3vx6i1kv";
  };
  propagatedBuildInputs = [
    attrs
    black
    cached-property
    click
    dace
    jinja2
    numpy
    packaging
    pybind11
    tabulate
    typing-extensions
    boltons
    cytoolz
    scipy
    devtools
    Mako
    networkx
    pydantic
    toolz
    typing-inspect
    gridtools1
    gridtools2
    xxhash
  ];
  nativeBuildInputs = [ git ];

  # Disabled should also check for (pydantic.version >= "1.8")
  disabled = pythonOlder "3.8";

  # The git link to DaCe breaks resolution of the dependencies
  # skip the resolution since they are all listed above anyway!
  pipInstallFlags = [ "--no-deps" ];

  # Build in paths to boost and gridtools
  boostdev = boost.dev;
  openmp = if stdenv.cc.isClang then llvmPackages.openmp else "/usr/lib";
  inherit gridtools1 gridtools2;
  patches = [ ./substitute-paths.patch ];
  postPatch = "substituteAllInPlace src/gt4py/config.py";

  doCheck = false;
  # # Would like to use this but check complains of lack of .dace.conf file
  # doCheck = true;
  pythonImportCheck = [ "gt4py" ];

  passthru = {
    tests = callPackage ./tests.nix { };
    dev-requirements = [
      pre-commit
      black
      isort
      rope
      devtools
      hypothesis
      pytest
      pytest-cache
      pytest-cov
      pytest-factoryboy
      sphinx
      sphinx_rtd_theme
    ];
  };
}
