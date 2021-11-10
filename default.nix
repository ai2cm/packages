# Copied from https://nixos.org/nixos/nix-pills/callpackage-design-pattern.html
let
  fv3gfs-fortran-src = builtins.fetchFromGitHub {
    owner = "ai2cm";
    repo = "fv3gfs-fortran";
    rev = "2d0ffc194f1b2f4974fcb5b61ab0dcef0b839854";
    sha256 = "13r8pdnlpxqb3jypf87yc32f9vc860l7vcz9kashh1wsy48r5a6z";
  };
  packageOverrides = import ./python.nix;
  overlay = self: super: rec {
    # ensure that everything uses mpich for mpi
    call_py_fort = self.callPackage ./call_py_fort { };
    fms = self.callPackage ./fms { src = fv3gfs-fortran-src; };
    esmf = self.callPackage ./esmf { };
    nceplibs = self.callPackage ./nceplibs { };
    fv3 = self.callPackage ./fv3 { src = fv3gfs-fortran-src; };
    pfunit = self.callPackage ./pfunit { };
    gridtools1 = self.callPackage ./gridtools/1.nix { };
    gridtools2 = self.callPackage ./gridtools/2.nix { };
    serialbox = self.callPackage ./serialbox { };
    serialboxNoFortran =
      self.callPackage ./serialbox { enableFortran = false; };
    python39 =
      super.python39.override { packageOverrides = (packageOverrides self); };
    python38 =
      super.python38.override { packageOverrides = (packageOverrides self); };
    python3 =
      super.python3.override { packageOverrides = (packageOverrides self); };
    python =
      super.python.override { packageOverrides = (packageOverrides self); };
  };
  nixpkgs = import (builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-release-21.05";
    url =
      "https://github.com/nixos/nixpkgs/archive/977b522d3101ad847fd51d695b817fe2cf8efaf6.tar.gz";
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "13r8pdnlpxqb3jypf87yc32f9vc860l7vcz9kashh1wsy48r5a6x";
  }) { overlays = [ overlay ]; };
in nixpkgs
