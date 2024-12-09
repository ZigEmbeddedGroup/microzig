const std = @import("std");
const microzig = @import("microzig");

pub const Arch = enum {
    arm,
    riscv,
};

pub const Chip = enum {
    RP2040,
    RP2350,
};

pub const arch: Arch = blk: {
    if (std.mem.eql(u8, microzig.config.cpu_name, "cortex_m33")) {
        break :blk .arm;
    } else if (std.mem.eql(u8, microzig.config.cpu_name, "generic_rv32")) {
        break :blk .riscv;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported cpu for RP2XXX HAL: \"{s}\"", .{microzig.config.cpu_name}));
    }
};

pub const chip: Chip = blk: {
    if (std.mem.eql(u8, microzig.config.chip_name, "RP2040")) {
        break :blk .RP2040;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "RP2350")) {
        break :blk .RP2350;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported chip for RP2XXX HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
};
