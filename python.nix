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

  fv3gfs-wrapper = self.callPackage ./wrapper.nix { };

  devtools = self.buildPythonPackage rec {
    pname = "devtools";
    version = "0.6.1";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "1ms2kp1h395880k1bcn71ap53s33ffb2jxnzx3x2hpfkjisk0m50";
    };
    doCheck = false;
  };

  # Included because version 0.6.0 in nixpkgs 21.05 is broken in Python 3.9
  typing-inspect = self.buildPythonPackage rec {
    pname = "typing-inspect";
    version = "0.7.1";

    src = super.fetchPypi {
      inherit version;
      pname = "typing_inspect";
      sha256 = "1al2lyi3r189r5xgw90shbxvd88ic4si9w7n3d9lczxiv6bl0z84";
    };

    propagatedBuildInputs = with self; [ typing-extensions mypy-extensions ];
  };

  dace = self.callPackage ./dace { };

  serialbox = self.buildPythonPackage rec {
    pname = "serialbox";
    version = "2.6.1";

    src = pkgs.fetchFromGitHub {
      owner = "GridTools";
      repo = pname;
      rev = "e1406251e11c1ebafef5f1a896dde4f0cecc1f01";
      sha256 = "MYAkVjt/pb9qMtTIPhXKTqbkip0k/b6ZVwPufAm2UCo=";
    };

    propagatedBuildInputs = [ self.setuptools self.numpy ];
    nativeBuildInputs = [ pkgs.cmake boost boost.dev ];
    dontUseCmakeConfigure = true;

    boost = pkgs.boost;
    patches = [ ./serialbox/boost.patch ];
    boostincdir = "${boost.dev}/include";
    boostlibdir = "${boost}/lib";
    postPatch = "substituteAllInPlace setup.py";

    # It builds in the TMPDIR source directory
    sourceRoot = "source/src/serialbox-python";
    preBuild = "chmod -R +w $TMPDIR";

    doCheck = false;
    pythonImportCheck = [ "serialbox" ];
  };

  gt4py = self.callPackage ./gt4py { };

  # This is the VCM development version of gt4py
  gt4py-dev = gt4py.overridePythonAttrs (old: rec {
    version = "${old.version}-dev";
    src = pkgs.fetchFromGitHub {
      owner = "VulcanClimateModeling";
      repo = old.pname;
      rev = "v31";
      sha256 = "1prq3qvhxj2zf1473k6n7vr2fgbc6f34l7f5phlm22904gyxg7qg";
    };
  });

  fv3core = self.callPackage ./fv3core { };
}
