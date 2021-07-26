{ stdenv, lib, buildPythonPackage, fetchFromGitHub, attrs, black
, cached-property, click, dace, jinja2, numpy, packaging, pybind11, tabulate
, typing-extensions, boltons, cytoolz, devtools, Mako, networkx, pydantic_1_7_4
, toolz, typing-inspect, xxhash, boost, gridtools1, gridtools2, git
, llvmPackages, pythonOlder }:
buildPythonPackage rec {
  pname = "gt4py";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "jdahm";
    repo = "gt4py";
    rev = "916c99c3a5090b746b488c93706fe27078a91562";
    sha256 = "1kmz2vqbahpr40x4gjwiyalcskahm9xxbrv37k1j5958fbp68llp";
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
    gridtools1
    gridtools2
    xxhash
  ];

  # Disabled should also check for (pydantic.version >= "1.8")
  disabled = pythonOlder "3.8";

  # The git link to DaCe breaks resolution of the dependencies
  # skip the resolution since they are all listed above anyway!
  pipInstallFlags = [ "--no-deps" ];

  # Build in paths to boost and gridtools
  boostdev = boost.dev;
  openmp = if stdenv.isDarwin then llvmPackages.openmp else "/usr/lib";
  inherit gridtools1 gridtools2;
  patches = [ ./substitute-paths.patch ];
  postPatch = "substituteAllInPlace src/gt4py/config.py";

  doCheck = false;
  # # Would like to use this but check complains of lack of .dace.conf file
  # doCheck = true;
  pythonImportCheck = [ "gt4py" ];
}
