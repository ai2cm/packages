{ buildPythonPackage, fetchFromGitHub, aenum, astunparse, chardet, click
, decorator, distro, flask, idna, itsdangerous, jinja2, markupsafe, mpmath
, networkx, numpy, packaging, ply, pyparsing, pyyaml, requests, scikit-build
, six, sympy, urllib3, websockets, werkzeug, dill, cmake, pythonOlder }:
buildPythonPackage rec {
  pname = "dace";
  version = "0.10.8";
  src = fetchFromGitHub {
    owner = "spcl";
    rev = "54e707ee675ca3ac68199d6b0e132c8639fb4cd2";
    repo = pname;
    sha256 = "1w6k2g79kyy30qva3qk1xswpc5a8a6kzn8dab68jrxlhmlpqghrb";
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
