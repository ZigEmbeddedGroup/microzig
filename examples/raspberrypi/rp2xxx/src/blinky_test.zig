const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;

// Tests can reference microzig when using the `add_test()` from the Firmware
// object (returned by `add_firmware()`). The tests will run on your PC, so
// they won't be able to execute code tightly coupled to the microcontroller
// hardware. You can access and inspect many things, and when you run into a
// wall you'll receive a compiler error.
test "microzig.chip exists" {
    try std.testing.expect(@hasDecl(microzig, "chip"));
    try std.testing.expect(@hasDecl(rp2xxx, "gpio"));
}
