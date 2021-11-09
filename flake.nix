{
  description = "A flake that provides packages for pgquarrel: https://github.com/eulerto/pgquarrel";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem ["aarch64-linux" "x86_64-linux"] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        packages.pgquarrel = pkgs.callPackage ./pkg.nix {};

        defaultPackage = packages.pgquarrel;

        overlay = final: prev: {
          pgquarrel = packages.pgquarrel;
        };
      }
    );
}
