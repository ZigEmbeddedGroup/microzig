const std = @import("std");
const microzig = @import("microzig");

pub const StatusRegister = enum(u8) {
    // machine information
    mvendorid,
    marchid,
    mimpid,
    mhartid,

    // machine trap setup
    mstatus,
    misa,
    mtvec,
};

pub inline fn setStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrs zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub inline fn clearStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrc zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub inline fn cli() void {
    clearStatusBit(.mstatus, 0x08);
}

pub inline fn sei() void {
    setStatusBit(.mstatus, 0x08);
}

pub const startup_logic = microzig.chip.startup_logic;
