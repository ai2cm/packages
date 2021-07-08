{ ... }:
let pkgs = (import ./.);
in {
  fms = pkgs.fms;
  esmf = pkgs.esmf;
  nceplibs = pkgs.nceplibs;
  fv3 = pkgs.fv3;
  pfunit = pkgs.pfunit;
  serialbox = pkgs.serialbox;
  fv3gfs-wrapper = pkgs.python3Packages.fv3gfs-wrapper;
  gt4py = pkgs.python38Packages.gt4py;
}
