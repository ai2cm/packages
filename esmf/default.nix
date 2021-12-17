{ stdenvNoCC, fetchFromGitHub, netcdffortran, gfortran, mpich, coreutils, which
, llvmPackages, lib }:
stdenvNoCC.mkDerivation rec {
  pname = "esmf";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "esmf-org";
    repo = pname;
    rev = "ESMF_8_0_0";
    sha256 = "07lvjsy8lfbv6vlwdqjhm67b32vaqb65s41sch0ay5ylfbp1jg6z";
  };

  buildPhase = ''
    # set build variables
    export ESMF_DIR=$(pwd)

    export ESMF_INSTALL_PREFIX=$out
    export ESMF_INSTALL_HEADERDIR=$out/include
    export ESMF_INSTALL_MODDIR=$out/include
    export ESMF_INSTALL_LIBDIR=$out/lib
    export ESMF_INSTALL_BINDIR=$out/bin
    export ESMF_INSTALL_DOCDIR=$out/share/docs

    export ESMF_NETCDF_INCLUDE=$netcdffortran/include
    export ESMF_NETCDF_LIBS="-lnetcdf -lnetcdff"
    export ESMF_BOPT=O
    export ESMF_CXXCOMPILEOPTS="$ESMF_CXXCOMPILEOPTS -Wno-format-security"

    # compile
    make -j$NIX_BUILD_CORES
    make install
    make installcheck
  '';

  # need to fix the linked libraries for some reason.
  # The "id" of these dylibs points to the build directory
  postFixup = lib.optionalString stdenvNoCC.isDarwin ''
    function fixNameLib {
        install_name_tool -id "$1" "$1"
    }
    fixNameLib $out/lib/libesmf.dylib
    fixNameLib $out/lib/libesmf_fullylinked.dylib
  '';

  # nativeBuildInputs = [ m4 ];
  # buildInputs = [ hdf5 curl mpi ];
  buildInputs = [ netcdffortran gfortran mpich gfortran.cc coreutils which ]
    ++ lib.optionals stdenvNoCC.isDarwin [ llvmPackages.openmp ];
  inherit netcdffortran gfortran;
  CXX = "${gfortran}/bin/g++";
  CC = "${gfortran}/bin/gcc";
  ESMF_CXXCOMPILER = "${CXX}";
  ESMF_CCOMPILER = "${CC}";
}
