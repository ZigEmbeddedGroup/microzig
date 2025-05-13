const std = @import("std");
const microzig = @import("microzig");
const Chip = @import("chip.zig").Chip;

pub const chip: Chip = blk: {
    if (std.mem.eql(u8, microzig.config.chip_name, "RP2040")) {
        break :blk .RP2040;
    } else if (std.mem.eql(u8, microzig.config.chip_name, "RP2350")) {
        break :blk .RP2350;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported chip for RP2XXX HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
};

pub const Arch = enum {
    arm,
    riscv,
};

pub const arch: Arch = switch (chip) {
    .RP2040 => if (std.mem.eql(u8, microzig.config.cpu_name, "cortex_m0plus"))
        .arm
    else
        @compileError(std.fmt.comptimePrint("Unsupported cpu for RP2040: \"{s}\"", .{microzig.config.cpu_name})),
    .RP2350 => if (std.mem.eql(u8, microzig.config.cpu_name, "cortex_m33"))
        .arm
    else if (std.mem.eql(u8, microzig.config.cpu_name, "hazard3"))
        .riscv
    else
        @compileError(std.fmt.comptimePrint("Unsupported cpu for RP2350: \"{s}\"", .{microzig.config.cpu_name})),
};

pub const has_rp2350b = chip == .RP2350 and @hasDecl(microzig.board, "has_rp2350b") and microzig.board.has_rp2350b;
