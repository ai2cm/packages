{ buildPythonPackage, fetchFromGitHub, aenum, astunparse, chardet, click
, decorator, distro, flask, idna, itsdangerous, jinja2, markupsafe, mpmath
, networkx, numpy, packaging, ply, pyparsing, pyyaml, requests, scikit-build
, six, sympy, urllib3, websockets, werkzeug, dill, cmake, pythonOlder }:
buildPythonPackage rec {
  pname = "dace";
  version = "0.10.8";
  src = fetchFromGitHub {
    owner = "spcl";
    rev = "a654383d173881a981f34549c03cd90cc6db5594";
    repo = pname;
    sha256 = "1plvj8wf837scrmp3aqph96yw6hjnjvkg2kbfmwxs8ajlzfn1hjg";
  };
  propagatedBuildInputs = [
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
  nativeBuildInputs = [ cmake ];
  patches = [ ./remove-cmake-req.patch ];
  dontUseCmakeConfigure = true;
  disabled = pythonOlder "3.6";
  doCheck = false;
}
