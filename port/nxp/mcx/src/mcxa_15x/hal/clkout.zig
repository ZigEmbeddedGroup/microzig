const std = @import("std");
const microzig = @import("microzig");
const syscon = @import("syscon.zig");
const mapper = @import("mapper.zig");
const port = @import("port.zig");
const meta = @import("meta_utils.zig");

const Clock_Source = enum(u3) {
    FRO_12M = 0,
    FRO_HF_DIV = 1,
    CLK_IN = 2,
    CLK_16K = 3,
    SLOW_CLK = 6,
    no_Clock = 7,
};

pub fn enable(comptime pin: mapper.PIN, src: Clock_Source, div: u4) void {
    syscon.set_clock(.CLKOUT, div, @fromBackingInt(@backingInt(src)));

    port.Port.configure_pin(pin, .{
        .MUX = comptime meta.check_mux(pin, .CLKOUT_clkout),
    });
}
