# Printer

Printer is supposed to process logging output from your microzig code and show
it in a readable format.

## Features:
- [x] pretty stack traces (similar to those of a non freestanding zig binary)
- [ ] defmt support

## Use it like a library!

You can easily write a small zig script that flashes the device and then prints
pretty logs to console on `zig build run`. Checkout
[](examples/rp2xxx_runner.zig)
