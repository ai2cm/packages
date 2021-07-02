{ pkgs, self, super }:
self.buildPythonPackage rec {
  pname = "gt4py";
  version = "0.1.0";
  src = pkgs.fetchFromGitHub {
    owner = "GridTools";
    rev = "beeb9754b8def1626a8a65b72b82b97f49934285";
    repo = pname;
    sha256 = "1hk2w7msxcgdr0k1dmwa7f6kyqapw0cmqcsb770qm3avb7g42m77";
  };
  propagatedBuildInputs = with self; [
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
    pydantic
    toolz
    typing-inspect
    xxhash
  ];
  nativeBuildInputs = [ pkgs.git ];
  patches = [ ./remove-dace-req.patch ];

  doCheck = false;
}
