{
  description = "A minimal C project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "hello";
          src = ./.;
          buildPhase = "gcc -o hello hello.c";
          installPhase = ''
            mkdir -p $out/bin
            cp hello $out/bin/
          '';
          buildInputs = [ pkgs.gcc ];
        };
      }
    );
}
