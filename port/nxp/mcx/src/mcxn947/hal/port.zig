const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");
const chip = microzig.chip;

pub fn num(comptime n: u3) Port {
    return @enumFromInt(n);
}

pub const Port = enum(u3) {
    _,

    pub fn init(comptime port: Port) void {
        const tag = switch (@intFromEnum(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
            4 => .PORT4,
			// TODO
            // 5 => .PORT5,
            else => unreachable
        };

        syscon.peripheral_reset_release(tag);
		// TODO: check why it is said "module has no clocking consideration" put it is possible to enable clock
        syscon.module_enable_clock(tag);
    }

    pub fn get_gpio(comptime port: Port, comptime pin: u5) gpio.GPIO {
		// TODO: check unavailable pins
        return gpio.num(@intFromEnum(port), pin);
    }

	pub fn reset(port: Port) void {
        const tag = switch (@intFromEnum(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
            4 => .PORT4,
            5 => .PORT5,
            else => unreachable
        };
		syscon.peripheral_reset_assert(tag);
		syscon.peripheral_reset_release(tag);
	}

    pub fn get_regs(port: Port) *volatile chip.types.peripherals.PORT0 {
		// const base: u32 = @intFromPtr(chip.peripherals.PORT0);
        return switch (@intFromEnum(port)) {
			0 => @ptrCast(chip.peripherals.PORT0),
			1 => @ptrCast(chip.peripherals.PORT1),
			2 => @ptrCast(chip.peripherals.PORT2),
			3 => @ptrCast(chip.peripherals.PORT3),
			4 => @ptrCast(chip.peripherals.PORT4),
			5 => @ptrCast(chip.peripherals.PORT5),
			// TODO: doesn't work for PORT5
            // 0...5 => |i| @ptrFromInt(base + i * @as(u32, 0x1000)),
            else => unreachable
        };
    }

	fn get_pin_control_reg(port: Port, pin: u5) *volatile @TypeOf(chip.peripherals.PORT0.PCR0) {
		// I am pretty sure all the structs are the same
		// the only thing changing is the reset value
		const base: u32 = @intFromPtr(port.get_regs().PCR0);

		return @ptrFromInt(base + pin * 4);
	}
};
