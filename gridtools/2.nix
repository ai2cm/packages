{ stdenv, lib, fetchFromGitHub, cmake, boost, git, cacert, llvmPackages }:
stdenv.mkDerivation rec {
  pname = "gridtools";
  version = "2.1.0";
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "a8039cbde1552f88424690f74211acb34a7f2720";
    sha256 = "189na3bh6zndd1jnrdjv83d7jchydhbpyl40007qjmj6kayi7h8c";
  };

  propagatedBuildInputs = [ boost.dev ]
    ++ (lib.optional stdenv.cc.isClang llvmPackages.openmp);
  nativeBuildInputs = [ git cmake cacert ];

  cmakeFlags = [ "-DGT_INSTALL_EXAMPLES=OFF" "-DBUILD_TESTING=OFF" ];
}
