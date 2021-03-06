pkgs: self: super: rec {

  call_py_fort = self.callPackage ./call_py_fort { };

  metpy = self.buildPythonPackage rec {
    pname = "MetPy";
    version = "1.0.1";
    src = self.fetchPypi {
      inherit pname version;
      sha256 = "sha256-FvqYBvrMJPMfRUuJh0HsVjmnK6nU/4oZrQ6UYp2Ty5U=";
    };
    propagatedBuildInputs = with self; [
      matplotlib
      numpy
      pandas
      pint
      pooch
      pyproj
      scipy
      traitlets
      xarray
      importlib-resources
      importlib-metadata
    ];
    # The setuptools checks try to use the network which isn't allowed
    # during the Nix build. Disabling them for now.
    doCheck = false;
  };

  old_docrep = self.buildPythonPackage rec {
    pname = "docrep";
    version = "0.2.7";
    src = self.fetchPypi {
      inherit pname version;
      sha256 = "sha256-xIk5rhTXkXKDmlu69aVwrdR/bMRNLBj2sfrI8cON7E0=";
    };
    propagatedBuildInputs = [ self.six ];
    # The setuptools checks try to use the network which isn't allowed
    # during the Nix build. Disabling them for now.
    doCheck = false;
  };

  xgcm = self.buildPythonPackage rec {
    pname = "xgcm";
    version = "0.5.1";
    src = self.fetchPypi {
      inherit pname version;
      sha256 = "sha256-eSPrbbziWCSboaf5FJ8qDn/1372CCR4tz56E4aOjCLM=";
    };
    propagatedBuildInputs =
      [ self.xarray self.future self.dask self.old_docrep ];
    # doesn't find pytest, not sure why, disabling tests for now.
    doCheck = false;
  };

  dacite = self.buildPythonPackage rec {
    pname = "dacite";
    version = "1.6.0";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-1IEl7QoDUtPen0k7+YADgIj0Xz+ddJjwkLUKhH2qpt8";
    };
    # doesn't find pytest, not sure why, disabling tests for now.
    doCheck = false;
  };

  f90nml = self.buildPythonPackage rec {
    pname = "f90nml";
    version = "1.2";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-B/u5EB8hjOiczDQmTsgRFu3J7Qq2mtHNgxbxnqaUzS4";
    };
    doCheck = false;

  };

  fv3config = self.buildPythonPackage rec {
    pname = "fv3config";
    version = "0.9.0";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-iqJdIXQChmiM3hDVcJpV8gc+SoAOSaPGJ6OWuSdzQ0Y=";
    };
    propagatedBuildInputs = with self; [
      f90nml
      appdirs
      requests
      pyyaml
      gcsfs
      backoff
      dacite
      zarr
      xarray
      cftime
      numpy
      fsspec
      typing-extensions
    ];
    doCheck = false;

  };

  fv3gfs-util = self.buildPythonPackage rec {
    pname = "fv3gfs-util";
    version = "0.6.0";
    src = pkgs.fetchFromGitHub {
      owner = "VulcanClimateModeling";
      rev = "76b69643686d1b7e6132e978aa1f1250c6a7d866";
      repo = pname;
      sha256 = "sha256-TGyvaSYW3KKAJLcjxsG0pklmKG9v/+6POqd7I7CTdCY=";
    };
    propagatedBuildInputs = with self; [
      zarr
      xarray
      cftime
      numpy
      fsspec
      typing-extensions
    ];
    # doesn't find pytest, not sure why, disabling tests for now.
    doCheck = false;

  };

  mpi4py = (super.mpi4py.override { mpi = pkgs.mpich; }).overridePythonAttrs {
    doCheck = false;
  };

  pace-util = self.buildPythonPackage rec {
    pname = "pace-util";
    version = "0.7.0";
    src = self.fetchPypi {
      inherit pname version;
      sha256 = "sha256-GBfdbryL0ylSDFefoJCobpFFJc1tfAaQ1gjeK0+BOvg=";
    };
    propagatedBuildInputs = with self; [
      zarr
      xarray
      cftime
      numpy
      fsspec
      typing-extensions
    ];
    doCheck = false;
    pythonImportsCheck = [ "pace.util" ];
  };

  pytest-regtest = self.buildPythonPackage rec {
    pname = "pytest-regtest";
    version = "1.4.5";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-oeTofUg+ST2b9tFacaRt7azLbKq3n6gGb0eo6z5vhuM=";
    };
    propagatedBuildInputs = with self; [ pytest ];
    doCheck = false;

  };

  fv3gfs-wrapper = self.callPackage ./wrapper.nix { };

  dace = self.callPackage ./dace { };

  gt4py = self.callPackage ./gt4py { };

  # This is the VCM development version of gt4py
  gt4py-dev = gt4py.overridePythonAttrs (old: rec {
    version = "${old.version}-dev";
    src = pkgs.fetchFromGitHub {
      owner = "VulcanClimateModeling";
      repo = old.pname;
      rev = "v36";
      sha256 = "k/crvlddVKfkX+FJUSMUmnlmUaiJlgthekNWZ21olIM=";
    };
  });

  fv3core = self.callPackage ./fv3core { };
}
