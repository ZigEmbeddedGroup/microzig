const microzig = @import("microzig");

pub const peripherals = microzig.chip.peripherals;

pub const drivers = struct {};

pub fn init() void {}

pub const gpio = struct {
    pub inline fn write(port: anytype, pin: u4, level: u1) void {
        if (level == 1) {
            port.BSHR.raw = @as(u32, 1) << pin;
        } else {
            port.BCR.raw = @as(u32, 1) << pin;
        }
    }
};
