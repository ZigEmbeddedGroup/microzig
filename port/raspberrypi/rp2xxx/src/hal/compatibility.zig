const std = @import("std");
const microzig = @import("microzig");

pub const CPU = enum {
    RP2040,
    RP2350,
};

pub fn get_cpu() CPU {
    if (std.mem.eql(u8, microzig.config.chip_name, "RP2040")) {
        return .RP2040;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "RP2350")) {
        return .RP2350;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported CPU for RP2XXX chip HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
}
