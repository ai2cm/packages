{ stdenv, lib, fetchFromGitHub, cmake, boost, git, cacert, llvmPackages }:
stdenv.mkDerivation rec {
  pname = "gridtools";
  version = "1.1.4";
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "eccd3e057d6deb1c97c7b6f8233ba6bf97a96622";
    sha256 = "x1niPXiJE0JyjWvtXiIkXmae2O5OS/YIx9EVkEAn+5g=";
  };

  propagatedBuildInputs = [ boost.dev ]
    ++ (lib.optional stdenv.cc.isClang llvmPackages.openmp);
  nativeBuildInputs = [ git cmake cacert ];

  cmakeFlags = [ "-DGT_INSTALL_EXAMPLES=OFF" "-DBUILD_TESTING=OFF" ];

  postInstall = "cp -r $curSrc/regression $out/include/gridtools/regression";
}
