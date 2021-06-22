{ fetchFromGitHub, lib, stdenv, cmake, boost, python3, gfortran, enableFortran ? true }:

stdenv.mkDerivation rec {
  pname = "serialbox";
  version = "v2.6.1";

  src = fetchFromGitHub {
    owner = "GridTools";
    repo = pname;
    rev = version;
    sha256 = "143ggdfbbmnnj6mllmagyg378vzrjc9q6yp0spf2yanjxwkbmbi2";
  };

  nativeBuildInputs = [ boost cmake ];
  buildInputs = [ python3 python3.pkgs.numpy ];

  cmakeFlags = [
    "-DSERIALBOX_ENABLE_C=ON"
    "-DSERIALBOX_ENABLE_PYTHON=ON"
    "-DSERIALBOX_BENCHMARKING=OFF"
    "-DSERIALBOX_EXAMPLES=OFF"
    "-DSERIALBOX_TESTING=OFF"
  ] ++ lib.optional (!enableFortran) "-DSERIALBOX_ENABLE_FORTRAN=OFF";

  meta = {
    description =
      "Serialbox is a serialization library and tools for C/C++, Python3 and Fortran";
    homepage = "https://gridtools.github.io/serialbox/";
  };

}
