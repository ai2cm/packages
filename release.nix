{ ... }:
let pkgs = (import ./.);
in {
  fms = pkgs.fms;
  esmf = pkgs.esmf;
  nceplibs = pkgs.nceplibs;
  fv3 = pkgs.fv3;
  pfunit = pkgs.pfunit;
  serialbox = pkgs.serialbox;
}
