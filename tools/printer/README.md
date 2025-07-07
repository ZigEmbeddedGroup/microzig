# Printer

Printer is a tool to process logging output from your code and print it in a
readable and pretty format. As of now it only annotates addresses from stack
traces with source code locations, but it can be extended later to also print
defmt (when this kind of logger will be added to microzig).

## Use it like a library!

You can easily write a small zig script that flashes the device and then prints
pretty logs to console on `zig build run`. Checkout
[](examples/rp2xxx_runner.zig)
