with import ./default.nix;
mkShell {
  buildInputs = [ git nixfmt ];
  shellHook = ''
    ${(import ./release.nix).pre-commit-check.shellHook}
  '';
}
