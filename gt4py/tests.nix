{ stdenv, python38, gt4py, hypothesis, pytest, pytest-cov, pytest-factoryboy
, pytest-xdist }:
let
  mypython = python38.withPackages
    (ps: [ gt4py hypothesis pytest pytest-cov pytest-factoryboy pytest-xdist ]);
in stdenv.mkDerivation {
  name = "gt4py-tests";
  buildInputs = [ mypython ];
  src = gt4py.src;
  dontConfigure = true;
  dontBuild = true;
  doCheck = true;

  checkPhase = ''
    pytest tests/
  '';

  installPhase = ''
    touch $out
  '';
}
