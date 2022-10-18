{
  pkgs,
  lib,
  nimPackages,
  ...
}: let
  lockfile = lib.importJSON ../../flake.lock;
  lockNimble = lockfile.nodes.nimble;
in
  nimPackages.buildNimPackage {
    pname = "nimble";
    version = lockNimble.locked.rev;
    src = pkgs.fetchFromGitHub {
      inherit (lockNimble.locked) owner repo rev;
      sha256 = lockNimble.locked.narHash;
    };
    nativeBuildInputs = with pkgs; [
      openssl
    ];
    buildInputs = with pkgs; [
      nim-unwrapped
    ];
  }
