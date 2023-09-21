{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.zig_0_11_0
    pkgs.picotool
    pkgs.llvmPackages_16.bintools
  ];
  buildInputs = [];
}
