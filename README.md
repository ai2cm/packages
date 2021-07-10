# Nix Packages

This repo contains a package set containing third party and internal dependencies
of the climate modeling team.

## Linting

The continuous integration will check that nix source is formatted using `nixfmt`.
In order to pass the check, files need to be formatted before pushing to the remote.

There are two options:
1. Install `nixfmt` globally and run it on the pre-file basis: `nixfmt path/to/file.nix`, or
2. Use the provided `pre-commit` capability: `nix-shell --command "pre-commit run --all-files"`

## Git hook

This repository offers the developer a `shell.nix` that, when instantiated using the `nix-shell`
command, drops into an shell with `git`, `nixfmt` and `pre-commit` installed.

A developer looking to add to this repository could use this together with
[direnv](https://direnv.net/) by adding a `.envrc` file with the command
[`use_nix`](https://github.com/direnv/direnv/blob/e6cd601baf6c9d0e5974e2ca7c308056a7687079/stdlib.sh#L1137).
