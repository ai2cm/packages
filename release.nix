let
  pkgs = (import ./.);
  nix-pre-commit-hooks = import (builtins.fetchTarball
    "https://github.com/cachix/pre-commit-hooks.nix/tarball/397f0713d007250a2c7a745e555fa16c5dc8cadb");
in {
  pre-commit-check = nix-pre-commit-hooks.run {
    src = ./.;
    hooks = { nixfmt.enable = true; };
  };
  call_py_fort = pkgs.call_py_fort;
  fms = pkgs.fms;
  esmf = pkgs.esmf;
  nceplibs = pkgs.nceplibs;
  fv3 = pkgs.fv3;
  pfunit = pkgs.pfunit;
  serialbox = pkgs.serialbox;
  fv3gfs-wrapper = pkgs.python3Packages.fv3gfs-wrapper;
  gridtools1 = pkgs.gridtools1;
  gridtools2 = pkgs.gridtools2;
  gt4py = pkgs.python3Packages.gt4py;
  fv3core = pkgs.python3Packages.fv3core;
}
