# Copied from https://nixos.org/nixos/nix-pills/callpackage-design-pattern.html
{ system ? builtins.currentSystem, pkgs ? import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-release-21.11";
  url =
    "https://github.com/nixos/nixpkgs/archive/573095944e7c1d58d30fc679c81af63668b54056.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "07s5cwhskqvy82b4rld9b14ljc0013pig23i3jx3l3f957rk95pg";
}) }:
pkgs {
  overlays = [ (import ./overlay.nix) ];
  system = system;
}
