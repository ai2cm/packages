# Copied from https://nixos.org/nixos/nix-pills/callpackage-design-pattern.html
let
  fv3gfs-fortran-src = builtins.fetchGit {
    url = "https://github.com/VulcanClimateModeling/fv3gfs-fortran.git";
    ref = "master";
    rev = "2d0ffc194f1b2f4974fcb5b61ab0dcef0b839854";
  };
  packageOverrides = import ./python.nix;
  overlay = self: super: rec {
    # ensure that everything uses mpich for mpi
    fms = self.callPackage ./nix/fms { src=fv3gfs-fortran-src; };
    esmf = self.callPackage ./nix/esmf { };
    nceplibs = self.callPackage ./nix/nceplibs { };
    fv3 = self.callPackage ./nix/fv3 { src=fv3gfs-fortran-src; };
    pfunit = self.callPackage ./pfunit { };
    serialbox = self.lib.makeOverridable (self.callPackage ./serialbox) { };
    serialboxNoFortran = serialbox.override { enableFortran = false; };
    python3 = super.python3.override { packageOverrides = (packageOverrides self); };
    python = super.python.override { packageOverrides = (packageOverrides self); };
  };
  nixpkgs = import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-as-of-2021-19";
  # this commit has caches on cache.nixos.org, but doesn't update the mpich
  # version from 20.09
  url = "https://github.com/nixos/nixpkgs/archive/7750e6a2c95dd157d4f75a6af00923910870dd5e.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0mw0w4mk65a6k2v6mdwa5id5rq01sjbx1klcmri9m7i77q7mzd5x";
}) {overlays = [overlay];};
in nixpkgs
