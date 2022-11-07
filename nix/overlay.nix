final: prev: let
  nimble-versions = final.callPackages ./nimble {};
in {
  nimble = nimble-versions.nightly;
  nimPackages =
    prev.nimPackages
    // {
      nimble = nimble-versions.nightly;
    };
}
