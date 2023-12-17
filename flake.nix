{
  description = "nix configuration for python for Abi";

  inputs = {
    nixpkgs.url     = github:nixos/nixpkgs/b8eceddc; # master-2023-11-07
    flake-utils.url = github:numtide/flake-utils/c0e246b9;
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system:
      let
        pkgs    = nixpkgs.legacyPackages.${system};
      in
        rec {
          packages = flake-utils.lib.flattenTree (with pkgs; {
            python = python3.withPackages(ps: with ps; [
              ipykernel jupytext mpmath nbconvert numpy sympy
            ]);
          });
        }
    );
}
