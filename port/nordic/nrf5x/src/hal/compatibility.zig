const std = @import("std");
const microzig = @import("microzig");
const Chip = @import("chip.zig").Chip;

pub const chip: Chip = blk: {
    if (std.mem.eql(u8, microzig.config.chip_name, "nrf51")) {
        break :blk .nrf51;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52")) {
        break :blk .nrf52;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52833")) {
        break :blk .nrf52833;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52840")) {
        break :blk .nrf52840;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported chip for nRF5x HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
};
