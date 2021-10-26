# Nix Packages

This repo contains a package set containing third party and internal dependencies
of the climate modeling team.

For example the following code specifies an environment with FV3 installed.

```
# shell.nix
let
  vcmpkgs = import (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "vcm-packages";
    url = "git@github.com:VulcanClimateModeling/packages.git";
    ref = "master";
    # SHA of the commit of vcmpkgs to use. This effectively pins all packages to
    # the versions specified in that commit.
    rev = "f9f66a438833ffc83830fbb0701f4ed656c89bfd";
  });
in vcmpkgs.mkShell {
    buildInputs = [vcmpkgs.fv3];
}
```

Save this code to `shell.nix` and enter the environment by running

    nix-shell

from the same directory.

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
