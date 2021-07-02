{ pkgs, self, super }:
self.buildPythonPackage rec {
  pname = "dace";
  version = "0.10.8";
  src = pkgs.fetchFromGitHub {
    owner = "spcl";
    rev = "43fe08b12c0c94d2d61dc46c3748543135b8cd11";
    repo = pname;
    sha256 = "00c6x8ryrsxzjbpw5d35cj8rzrzcsklqg5fdfjih0h166cmpl55v";
  };
  propagatedBuildInputs = with self; [
    aenum
    astunparse
    chardet
    click
    decorator
    distro
    flask
    idna
    itsdangerous
    jinja2
    markupsafe
    mpmath
    networkx
    numpy
    packaging
    ply
    pyparsing
    pyyaml
    requests
    scikit-build
    six
    sympy
    urllib3
    websockets
    werkzeug
    dill
  ];
  nativeBuildInputs = [ pkgs.cmake ];
  patches = [ ./remove-cmake-req.patch ];
  dontUseCmakeConfigure = true;
  doCheck = false;
}
