{ buildPythonPackage, fetchFromGitHub, aenum, astunparse, chardet, click
, decorator, distro, flask, idna, itsdangerous, jinja2, markupsafe, mpmath
, networkx, numpy, packaging, ply, pyparsing, pyyaml, requests, scikit-build
, six, sympy, urllib3, websockets, werkzeug, dill, cmake, pythonOlder }:
buildPythonPackage rec {
  pname = "dace";
  version = "0.13";
  src = fetchFromGitHub {
    owner = "spcl";
    rev = "v${version}";
    repo = pname;
    sha256 = "1mvt5RQoVs7Rq8GfZU7bRYtnjZ3TtXYdWLyRBZ4Yq4Y=";
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

  pythonImportCheck = [ "dace" ];

  # Complains: error: [Errno 2] No such file or directory: '/homeless-shelter/.dace.conf'
  doCheck = false;
}
