{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, pre-commit-hooks, ... }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      checks."x86_64-linux" = {
        pre-commit-check = pre-commit-hooks.lib."x86_64-linux".run {
          src = ./.;
          hooks = {
            # Nix
            nixfmt-rfc-style.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      };

      devShells."x86_64-linux".default = pkgs.mkShellNoCC {
        packages = [
          pkgs.mdbook
          pkgs.mdbook-mermaid
          pkgs.mdbook-admonish
        ];

        inherit (inputs.self.checks.x86_64-linux.pre-commit-check) shellHook;

      };

      packages."x86_64-linux".default = pkgs.stdenv.mkDerivation {
        pname = "nixalted-website";
        version = "0.1.0";

        src = ./.;

        buildInputs = [
          pkgs.mdbook
          pkgs.mdbook-mermaid
          pkgs.mdbook-admonish
        ];

        buildPhase = ''
          mdbook build
          cp -r book $out
        '';
      };
    };
}
