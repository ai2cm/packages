pkgs: self: super: {

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

  gcsfs = self.buildPythonPackage rec {
    pname = "gcsfs";
    version = "0.7.1";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-A2WN+/GnNNmHqrNjHgo0Kz1+JKJJmLTY0kkf3SEFNyA=";
    };
    propagatedBuildInputs = with self; [
      crcmod
      google-auth
      google-auth-oauthlib
      requests
      decorator
      fsspec
      aiohttp
      ujson
    ];

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
    version = "0.7.1";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-ijkWwsmgNLGX4QNuqhpN93uhCmeQqD5uN1jArHT/52E";
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
    # doesn't find pytest, not sure why, disabling tests for now.
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

  devtools = self.buildPythonPackage rec {
    pname = "devtools";
    version = "0.6.1";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "1ms2kp1h395880k1bcn71ap53s33ffb2jxnzx3x2hpfkjisk0m50";
    };
    doCheck = false;
  };

  typing-inspect = self.buildPythonPackage rec {
    pname = "typing-inspect";
    version = "0.7.1";

    src = super.fetchPypi {
      inherit version;
      pname = "typing_inspect";
      sha256 = "1al2lyi3r189r5xgw90shbxvd88ic4si9w7n3d9lczxiv6bl0z84";
    };

    propagatedBuildInputs = with self; [
      typing-extensions
      mypy-extensions
    ];
    meta = with super.lib; {
      description = "Runtime inspection utilities for Python typing module";
      homepage = "https://github.com/ilevkivskyi/typing_inspect";
      icense = licenses.mit;
      maintainers = with maintainers; [ albakham ];
    };
  };

  dace = import ./dace { inherit pkgs self super; };
  gt4py = import ./gt4py { inherit pkgs self super; };

}
