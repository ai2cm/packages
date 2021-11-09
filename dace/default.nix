{ buildPythonPackage, fetchFromGitHub, aenum, astunparse, chardet, click
, decorator, distro, flask, idna, itsdangerous, jinja2, markupsafe, mpmath
, networkx, numpy, packaging, ply, pyparsing, pyyaml, requests, scikit-build
, six, sympy, urllib3, websockets, werkzeug, dill, cmake, pythonOlder }:
buildPythonPackage rec {
  pname = "dace";
  version = "0.10.8";
  src = fetchFromGitHub {
    owner = "spcl";
    rev = "aa94b8f603e2341215647ae0ce4056df55049fe2";
    repo = pname;
    sha256 = "1mnqajqg2mk88paxxzl0wqm0fyv8870acvak5kfk2lh2zhwmlpml";
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
