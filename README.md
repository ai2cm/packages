# Nix Packages

This repo contains a package set containing third party and internal dependencies
of the climate modeling team.

## Getting Started

This repo essentially pins a version of nixpkgs and defines derivations for the various packages
that the climate modeling team develops.
Continuous integration pushes builds to a cachix repo
[ai2climatemodeling](https://app.cachix.org/cache/ai2climatemodeling) that can be used to
pull pre-built versions.

### Stable Workflow

The basic usage is the same as using nixpkgs: fetch and pin a tarball of this attribute set,
then evaluate derivations.
For example to create a shell environment with fv3 and its libraries, create a `shell.nix` with
the following:

```
# shell.nix
let
  pkgs = import (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "ai2cm-packages";
    url = "git@github.com:ai2cm/packages.git";
    ref = "master";
    # SHA of the commit of pkgs to use. This effectively pins all packages to
    # the versions specified in that commit.
    rev = "8dfb5e904a424a3063c14ea47efe1ff0f50be81d";
  }) { };
in pkgs.mkShell {
    buildInputs = [pkgs.fv3];
}
```

Then running `nix-shell` will drop the user into a development shell.

### Flake Workflow

The repo also exposes the derivation set as `legacyPackages` in a `flake.nix`.
Below is an example of the usage:

```
{
  inputs = {
    ai2cm.url = "github:ai2cm/packages/flake-ify";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, ai2cm, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = ai2cm.legacyPackages.${system};
      in {
        defaultPackage = pkgs.fv3;
        devShell = (pkgs.python38.withPackages (ps: [ ps.gt4py ])).env;
      });
}
```

Nix flakes automatically pins all versions of the inputs.

- Executing `nix build .` will build `fv3`
- Executing `nix develop` will launch the development shell with `python` and `gt4py` installed.


## Development

### Linting

The continuous integration will check that nix source is formatted using `nixfmt`.
In order to pass the check, files need to be formatted before pushing to the remote.

There are two options:
1. Install `nixfmt` globally and run it on the pre-file basis: `nixfmt path/to/file.nix`, or
2. Use the provided `pre-commit` capability: `nix-shell --command "pre-commit run --all-files"`

### Git hook

This repository offers the developer a `shell.nix` that, when instantiated using the `nix-shell`
command, drops into an shell with `git`, `nixfmt` and `pre-commit` installed.
Pre-commit can be used on its own, or in conjunction with git.
The pre-commit git hook and `.pre-commit-config.yaml` are generated the first time the shell is instantiated.

A developer looking to add to this repository could use this together with
[direnv](https://direnv.net/) by adding a `.envrc` file with the command
[`use_nix`](https://github.com/direnv/direnv/blob/e6cd601baf6c9d0e5974e2ca7c308056a7687079/stdlib.sh#L1137).
