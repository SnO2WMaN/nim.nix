final: prev: let
  nimble-versions = final.callPackages ./nimble {};
in {
  nimPackages =
    prev.nimPackages
    // {
      nimble = nimble-versions.nightly;
    };
}
