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
  } @ inputs: (
    flake-utils.lib.eachSystem ["x86_64-linux"] (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
          ];
        };
      in {
        packages.nimble = pkgs.callPackage ./nix/nimble {
          inherit system;
        };
        apps.nimble = flake-utils.lib.mkApp {
          drv = self.packages.${system}.nimble;
        };

        /*
         pkgs.nimPackages.buildNimPackage {
          pname = "nimble";
          version = "1df4a0dad3d24ef7aa424ebce0fe7d476e1069ee";
          src = inputs.nimble;
          nativeBuildInputs = with pkgs; [openssl];
          buildInputs = [];
        };
        */

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
