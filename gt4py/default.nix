{ stdenv, lib, buildPythonPackage, fetchFromGitHub, attrs, black
, cached-property, click, dace, jinja2, numpy, packaging, pybind11, tabulate
, typing-extensions, boltons, cytoolz, devtools, Mako, networkx, pydantic_1_7_4
, toolz, typing-inspect, xxhash, git, boost, llvmPackages, pythonOlder }:
buildPythonPackage rec {
  pname = "gt4py";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "GridTools";
    rev = "58c17846129a581dff74bc503cb51edf8ceffba2";
    repo = pname;
    sha256 = "1hk2w7msxcgdr0k1dmwa7f6kyqapw0cmqcsb770qm3avb7g42m77";
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
    devtools
    Mako
    networkx
    pydantic_1_7_4
    toolz
    typing-inspect
    xxhash
  ];

  # TODO(johannd): Why are these not getting propagated to the environment?
  buildInputs =
    [ git boost (lib.optional stdenv.isDarwin llvmPackages.openmp) ];

  disabled = pythonOlder "3.8";

  # The git link to DaCe breaks resolution of the dependencies
  # skip the resolution since they are all listed above anyway!
  pipInstallFlags = [ "--no-deps" ];

  doCheck = false;
  # # Would like to use this but check complains of lack of .dace.conf file
  # doCheck = true;
  # pythonImportCheck = [ "gt4py" ];
}
