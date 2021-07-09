{ stdenv, bash, fms, esmf, nceplibs, netcdf, netcdffortran, lapack, blas, mpich
, perl, gfortran, getopt, src }:
stdenv.mkDerivation {
  name = "fv3";
  buildInputs = [
    fms
    esmf
    nceplibs
    netcdf
    netcdffortran
    lapack
    blas
    mpich
    perl
    gfortran
    getopt
  ];

  propagatedBuildInputs = [ mpich ];

  srcs = src;

  patchPhase = ''

    patchShebangs FV3/configure
      # need to call this since usr/bin/env isn't 
      # installed in sandboxed build environment
      # there goes 1 hr...
      patchShebangs FV3/mkDepends.pl
  '';

  config = ./configure.fv3;

  configurePhase = ''
    cd FV3
    cp $config conf/configure.fv3
    # ./configure gnu_docker
    cd ..
  '';

  buildPhase = ''
    make -C FV3 -j 4
  '';

  installPhase = ''
    PREFIX=$out make -C FV3 install -j 4
  '';

  SHELL = "${bash}/bin/bash";
  FMS_DIR = "${fms}/include";
  ESMF_DIR = "${esmf}";
  LD_LIBRARY_PATH = "${esmf}/lib/:${fms}/libFMS/.libs/:$${SERIALBOX_DIR}/lib";
  INCLUDE = "-I${fms}/include -I${netcdffortran}/include -I${esmf}/include/";
  NCEPLIBS_DIR = "${nceplibs}/lib";
  OMPI_CC = "${gfortran.cc}/bin/gcc";
}

