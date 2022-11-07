{
  pkgs,
  nimPackages,
}: {
  nightly = nimPackages.buildNimPackage {
    pname = "nimble";
    version = "1df4a0dad3d24ef7aa424ebce0fe7d476e1069ee";
    src = pkgs.fetchFromGitHub {
      owner = "nim-lang";
      repo = "nimble";
      rev = "1df4a0dad3d24ef7aa424ebce0fe7d476e1069ee";
      sha256 = "sha256-4dw8FMhl+u14mMpdbkGiUv7X/q/p8FqqfHdr6WhNL7w=";
    };
    nativeBuildInputs = with pkgs; [openssl];
  };
}
