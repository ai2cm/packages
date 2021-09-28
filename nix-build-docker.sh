#!/bin/bash

docker run -v nix-store:/nix/store -v $(pwd):/workdir -w /workdir -ti nixos/nix
