{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nimble = {
      url = "github:nim-lang/nimble/1df4a0dad3d24ef7aa424ebce0fe7d476e1069ee";
      flake = false;
    };
  };
  # dev
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    {
      overlays.default = import ./nix/overlay.nix;
    }
    // (
      flake-utils.lib.eachDefaultSystem (
        system: let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in {
          packages = flake-utils.lib.flattenTree rec {
            nimble-nightly = pkgs.nimPackages.nimble;
            nimble = nimble-nightly;
          };

          apps.nimble = flake-utils.lib.mkApp {
            drv = self.packages.${system}.nimble;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              alejandra
              treefmt
              nim-unwrapped
            ];
          };
        }
      )
    );
}
