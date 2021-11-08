const registers = @import("registers.zig");

pub fn init(comptime clocks_config: anytype) void {
    registers.XOSC.STARTUP.modify(.{
        .DELAY = clocks_config.xosc.delay,
    });
    registers.XOSC.CTRL.write(.{
        .FREQ_RANGE = clocks_config.xosc.frequency_range,
        .ENABLE = if (clocks_config.xosc.enable) .ENABLE else .DISABLE,
    });

    // wait for the XOSC to be stable
    if (clocks_config.xosc.enable) {
        while (registers.XOSC.STATUS.read().STABLE == 0)
            asm volatile ("" ::: "memory");
    }
}

pub fn disable() void {
    //TODO
}
