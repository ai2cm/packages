{ buildPythonPackage, fetchFromGitHub, aenum, astunparse, chardet, click
, decorator, distro, flask, idna, itsdangerous, jinja2, markupsafe, mpmath
, networkx, numpy, packaging, ply, pyparsing, pyyaml, requests, scikit-build
, six, sympy, urllib3, websockets, werkzeug, dill, cmake, pythonOlder }:
buildPythonPackage rec {
  pname = "dace";
  version = "0.10.8";
  src = fetchFromGitHub {
    owner = "spcl";
    rev = "d4f32d97cd1fafd9ad8e52ca7ad5283461c64e78";
    repo = pname;
    sha256 = "0xsha6qsbp123a6lpjrfwkpnmjlzazfff13pln9jb1wipl0ax6y3";
    fetchSubmodules = true;
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
