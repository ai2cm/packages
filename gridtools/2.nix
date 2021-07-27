{ stdenv, lib, fetchFromGitHub, cmake, boost, git, cacert, llvmPackages }:
stdenv.mkDerivation rec {
  pname = "gridtools";
  version = "2.0.0";
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "c9c30288e632846fa30d9cd9b5f282aa6886a887";
    sha256 = "1k1sqzib81352xsvkzyv38bmq5k5asfjdrck274i9q27w3fp1s5r";
  };

  propagatedBuildInputs = [ boost.dev ]
    ++ (lib.optional stdenv.cc.isClang llvmPackages.openmp);
  nativeBuildInputs = [ git cmake cacert ];

  cmakeFlags = [ "-DGT_INSTALL_EXAMPLES=OFF" "-DBUILD_TESTING=OFF" ];
}
