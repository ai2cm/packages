# Nix Packages

This repo contains a package set containing third party and internal dependencies
of the climate modeling team.

## Linting

The continuous integration will check that nix source is formatted using `nixfmt`.
In order to pass the check, files need to be formatted before pushing to the remote.

There are two options:
1. Install `nixfmt` globally and run it on the pre-file basis: `nixfmt path/to/file.nix`, or
2. Use the provided `pre-commit` capability: `nix-shell --command "pre-commit run --all-files"`
