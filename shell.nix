(import ./default.nix).mkShell {
  shellHook = ''
    ${(import ./release.nix).pre-commit-check.shellHook}
  '';
}
