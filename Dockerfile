FROM nixos/nix:2.3.12
RUN nix-env -iA nixpkgs.cachix nixpkgs.bash nixpkgs.git nixpkgs.openssl
COPY . /pkgs
RUN cd /pkgs && nix-build --max-jobs 4 --verbose release.nix
