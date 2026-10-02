pub const std_options = microzig.std_options(.{});

const microzig = @import("microzig");
const std = @import("std");
const hal = microzig.hal;
const Port = hal.port.Port;
const clkout = hal.clkout;

const PORT4: Port = @fromBackingInt(@intCast(4));

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    PORT4.init();
    clkout.enable(.P4_2, .SLOW_CLK, 0);
    try hal.syscon.clock_init(.{
        .frohf = .{ .freq = .@"96Mhz", .fro_hf_div = 1 },
        .ahb_div = 4,
    });
    while (true) {}
}
