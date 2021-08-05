{ stdenv, lib, fetchFromGitHub, cmake, boost, git, cacert, llvmPackages }:
stdenv.mkDerivation rec {
  pname = "gridtools";
  version = "1.1.3";
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "eccd3e057d6deb1c97c7b6f8233ba6bf97a96622";
    sha256 = "167v4x0905fiqw4gcjsfxvc9wrjy4hi5xvbbimr444w9g0yy4nf7";
  };

  propagatedBuildInputs = [ boost.dev ]
    ++ (lib.optional stdenv.cc.isClang llvmPackages.openmp);
  nativeBuildInputs = [ git cmake cacert ];

  cmakeFlags = [ "-DGT_INSTALL_EXAMPLES=OFF" "-DBUILD_TESTING=OFF" ];

  postInstall = "cp -r regression $out/include/regression";
}
