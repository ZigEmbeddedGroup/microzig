const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");

const PORT_T = microzig.chip.types.peripherals.PORT0;

//TODO ADD ALL PIN CONFG
pub const PinConfig = struct {
    MUX: u3,
};

const PIN = @FieldType(microzig.chip.types.peripherals.PORT0, "PCR0");

pub fn num(comptime n: u2) Port {
    return @fromBackingInt(n);
}

pub const Port = enum(u3) {
    _,

    pub fn init(comptime port: Port) void {
        const tag = switch (@backingInt(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
            4 => .PORT4,
            else => @panic("INVALID PORT"),
        };

        syscon.reset_release(tag);
        syscon.enable_clock(tag);
    }

    pub fn get_regs(self: Port) *volatile PORT_T {
        const val: u3 = @backingInt(self);

        if (val > 4) @panic("INVALID PORT");

        return switch (val) {
            0 => microzig.chip.peripherals.PORT0,
            1 => @ptrCast(microzig.chip.peripherals.PORT1),
            2 => @ptrCast(microzig.chip.peripherals.PORT2),
            3 => @ptrCast(microzig.chip.peripherals.PORT3),
            4 => @ptrCast(microzig.chip.peripherals.PORT4),
            else => unreachable,
        };
    }

    pub fn configure_pin(self: Port, pin: u5, config: PinConfig) void {
        const regs = self.get_regs();
        const pin_regs: *volatile PIN = @ptrFromInt(@as(usize, @intFromPtr(regs)) + (0x80 + (4 * @as(usize, pin))));

        pin_regs.modify_one("LK", .lk0);
        defer pin_regs.modify_one("LK", .lk1);

        pin_regs.modify_one("MUX", @fromBackingInt(@intCast(config.MUX)));
    }

    pub fn get_gpio(comptime port: Port, comptime pin: u5) gpio.GPIO {
        return gpio.num(@backingInt(port), pin);
    }
};
