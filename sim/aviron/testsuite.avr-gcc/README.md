# Testsuite Sources

This folder contains all files that cannot be compiled with Zig as-is and require the `avr-gcc` + `avr-binutils` toolchain.

Run `zig build update-testsuite` from the main folder to update all files. This requires `avr-gcc` to be in the `PATH`!
