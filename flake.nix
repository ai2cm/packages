{
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };
  outputs = { self, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = (import ./. { system = system; });
      in {
        legacyPackages = pkgs;
        devShell = with pkgs;
          mkShell { buildInputs = [ git nixfmt nix-prefetch-git ]; };
      });
}
