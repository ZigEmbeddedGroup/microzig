const std = @import("std");
const microzig = @import("microzig");
const CPU = @import("cpu.zig").CPU;

pub const cpu: CPU = blk: {
    if (std.mem.eql(u8, microzig.config.chip_name, "RP2040")) {
        break :blk .RP2040;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "RP2350")) {
        break :blk .RP2350;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported CPU for RP2XXX chip HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
};
