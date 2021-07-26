{ stdenv, lib, fetchFromGitHub, cmake, boost, git, cacert, llvmPackages }:
stdenv.mkDerivation rec {
  pname = "gridtools";
  version = "2.0.0";
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "c9c30288e632846fa30d9cd9b5f282aa6886a887";
    sha256 = "167v4x0905fiqw4gcjsfxvc9wrjy4hi5xvbbimr444w9g0yy4nf7";
  };

  propagatedBuildInputs = [ boost git cacert ]
    ++ (lib.optional stdenv.isDarwin llvmPackages.openmp);
  nativeBuildInputs = [ cmake ];

  cmakeFlags = [ "-DGT_INSTALL_EXAMPLES=OFF" "-DBUILD_TESTING=OFF" ];
}
