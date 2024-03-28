const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const GPIO = peripherals.GPIO;

pub const gpio = struct {
    fn assertRange(comptime p: comptime_int) void {
        if (p < 0 or p >= 21)
            @compileError(std.fmt.comptimePrint("GPIO {} does not exist. GPIO pins can be between 0 and 21", .{p}));
    }

    pub const Config = struct {
        function: u8 = 0x80,
        invert_function: bool = false,
        direction: microzig.core.experimental.gpio.Direction,
        direct_io: bool = false,
        invert_direct_io: bool = false,
    };

    pub fn init(comptime pin: comptime_int, comptime config: Config) void {
        assertRange(pin);
        GPIO.FUNC_OUT_SEL_CFG[pin].modify(.{
            .OUT_SEL = config.function,
            .INV_SEL = @intFromBool(config.invert_function),
            .OEN_SEL = @intFromBool(config.direct_io),
            .OEN_INV_SEL = @intFromBool(config.invert_direct_io),
        });
        switch (config.direction) {
            .input => GPIO.ENABLE.raw &= ~(@as(u32, 1) << pin),
            .output => GPIO.ENABLE.raw |= (@as(u32, 1) << pin),
        }
    }
};

pub const uart = struct {
    fn reg(comptime index: comptime_int) @TypeOf(@field(peripherals, std.fmt.comptimePrint("UART{}", .{index}))) {
        return @field(peripherals, std.fmt.comptimePrint("UART{}", .{index}));
    }

    pub fn write(comptime index: comptime_int, slice: []const u8) void {
        const r = reg(index);
        for (slice) |c| {
            while (r.STATUS.read().TXFIFO_CNT > 8) {}
            r.FIFO.raw = c;
        }
    }
};
