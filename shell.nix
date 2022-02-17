with import ./default.nix { };
mkShell {
  buildInputs = [ git nixfmt nix-prefetch-git ];
  shellHook = ''
    ${(import ./release.nix).pre-commit-check.shellHook}
  '';
}
