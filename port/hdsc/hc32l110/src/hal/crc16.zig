const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.chip;

const CRC = chip.peripherals.CRC;

pub fn calculate(T: type, data: []const T) u16 {
    switch (T) {
        u8, u16, u32 => {},
        else => @compileError("unsupported type"),
    }

    CRC.RESULT.write(.{ .RESULT = 0xffff, .FLAG = 0 });

    const ptr: *volatile T = @ptrCast(&CRC.DATA);
    for (data) |d| {
        ptr.* = d;
    }

    return CRC.RESULT.read().RESULT;
}

pub fn check(T: type, data: []const T, value: u16) bool {
    switch (T) {
        u8, u16, u32 => {},
        else => @compileError("unsupported type"),
    }

    CRC.RESULT.write(.{ .RESULT = value, .FLAG = 0 });

    const ptr: *volatile T = @ptrCast(&CRC.DATA);
    for (data) |d| {
        ptr.* = d;
    }

    return CRC.RESULT.read().FLAG == 1;
}
