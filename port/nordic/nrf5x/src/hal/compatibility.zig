const std = @import("std");
const microzig = @import("microzig");
const Chip = @import("chip.zig").Chip;

pub const chip: Chip =
    if (std.mem.eql(u8, microzig.config.chip_name, "nrf51"))
        .nrf51
    else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52"))
        .nrf52832
    else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52833"))
        .nrf52833
    else if (std.mem.eql(u8, microzig.config.chip_name, "nrf52840"))
        .nrf52840
    else
        unsupported_chip("");

pub inline fn unsupported_chip(for_what: []const u8) void {
    @compileError(std.fmt.comptimePrint("unsupported chip for nRF5x {s}HAL: \"{s}\"", .{
        for_what ++ " ",
        microzig.config.chip_name,
    }));
}
