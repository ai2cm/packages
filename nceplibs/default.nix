{ stdenvNoCC, bash, fetchFromGitHub, system, rsync, gfortran, mpich, coreutils
, perl }:
stdenvNoCC.mkDerivation rec {
  pname = "nceplibs";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "NCAR";
    repo = pname;
    rev = "3da51e139d5cd731c9fc27f39d88cb4e1328212b";
    sha256 = "123h9l2gvwahgzp1h65ffqwsrsjvp40w14dxs9xifwhzp0zlspvk";
  };

  buildPhase = ''
    mkdir -p $out
    echo "y" | bash make_ncep_libs.sh -s ${arch} -c gnu -d $out -o 1
  '';

  dontInstall = true;

  # nativeBuildInputs = [ m4 ];
  # buildInputs = [ hdf5 curl mpi ];
  buildInputs = [ bash rsync gfortran mpich coreutils perl ];
  FFLAGS = "-I${gfortran.libc}/include";
  arch = if system == "x86_64-darwin" then "macosx" else "linux";

}
