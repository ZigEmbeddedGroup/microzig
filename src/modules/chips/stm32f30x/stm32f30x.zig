const std = @import("std");
const micro = @import("microzig");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format.";

    if (!std.mem.eql(u8, spec, "PE9")) {
        @compileError(invalid_format_msg);
    }
    return struct {};
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        _ = pin;
        registers.RCC.AHBENR.modify(.{ .IOPEEN = 1 });
        registers.GPIOE.MODER.modify(.{ .MODER9 = 0b01 });
    }

    pub fn setInput(comptime pin: type) void {
        _ = pin;
        registers.RCC.AHBENR.modify(.{ .IOPEEN = 1 });
        registers.GPIOE.MODER.modify(.{ .MODER9 = 0b00 });
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        _ = pin;
        return @intToEnum(micro.gpio.State, registers.GPIOE.IDR.read().IDR9);
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        _ = pin;
        switch (state) {
            .low => registers.GPIOE.BRR.modify(.{ .BR9 = 1 }),
            .high => registers.GPIOE.BSRR.modify(.{ .BS9 = 1 }),
        }
    }
};
