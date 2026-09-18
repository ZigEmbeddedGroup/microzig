const microzig = @import("microzig");
const syscon = @import("syscon.zig");
const MRCC0 = microzig.chip.peripherals.MRCC0;

const Clock_Source = enum(u3) {
    FRO_12M = 0,
    FRO_HF_DIV = 1,
    CLK_IN = 2,
    CLK_16K = 3,
    SLOW_CLK = 6,
    no_Clock = 7,
};

pub fn enable(src: Clock_Source, div: u4) void {
    syscon.unlock_clock_configuration();
    defer syscon.freeze_clock_configuration();

    MRCC0.MRCC_CLKOUT_CLKSEL.modify_one("MUX", @fromBackingInt(@intCast(@backingInt(src))));

    MRCC0.MRCC_CLKOUT_CLKDIV.write(.{
        .DIV = div,
        .HALT = .OFF,
        .RESET = .OFF,
    });

    MRCC0.MRCC_CLKOUT_CLKDIV.write(.{
        .DIV = div,
        .HALT = .ON,
        .RESET = .ON,
    });

    while (MRCC0.MRCC_CLKOUT_CLKDIV.read().UNSTAB == .OFF) {}
}
