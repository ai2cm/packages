{
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };
  outputs = { self, flake-utils }:
    flake-utils.lib.eachDefaultSystem
    (system: { legacyPackages = (import ./. { system = system; }); });
}
