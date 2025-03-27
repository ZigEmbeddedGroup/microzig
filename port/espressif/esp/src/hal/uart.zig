const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const UART = peripherals.UART;

fn reg(comptime index: comptime_int) @TypeOf(@field(peripherals, std.fmt.comptimePrint("UART{}", .{index}))) {
    return @field(peripherals, std.fmt.comptimePrint("UART{}", .{index}));
}

pub fn write(comptime index: comptime_int, slice: []const u8) void {
    const r = reg(index);
    for (slice) |c| {
        while (r.STATUS.read().TXFIFO_CNT > 8) {}
        r.FIFO.raw = c;
    }
}
