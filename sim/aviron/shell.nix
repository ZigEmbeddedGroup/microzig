{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.zig_0_11_0
    pkgs.llvmPackages_16.bintools
    pkgs.pkgsCross.avr.buildPackages.gcc
  ];
}
