const assert = @import("std").debug.assert;
const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");
const chip = microzig.chip;

pub const Port = enum(u3) {
	_,

	pub fn num(n: u3) Port {
		assert(n <= 5);
		return @enumFromInt(n);
	}

	pub fn get_n(port: Port) u3 {
		return @intFromEnum(port);
	}

	fn get_module(port: Port) syscon.Module {
		return @enumFromInt(@intFromEnum(syscon.Module.PORT0) + port.get_n());
	}

	pub fn init(port: Port) void {
		const module = port.get_module();

		syscon.module_reset_release(module);
		syscon.module_enable_clock(module);
	}

	pub fn deinit(port: Port) void {
		const module = port.get_module();

		syscon.module_disable_clock(module);
		syscon.module_reset_assert(module);
	}

	pub fn disable_clock(comptime port: Port) void {
		syscon.module_disable_clock(switch (@intFromEnum(port)) {
			0 => .PORT0,
			1 => .PORT1,
			2 => .PORT2,
			3 => .PORT3,
			4 => .PORT4,
			// TODO
			// 5 => .PORT5,
			else => unreachable
		});
	}

	pub fn get_gpio(comptime port: Port, comptime pin: u5) gpio.GPIO {
		// TODO: check unavailable pins
		return gpio.num(@intFromEnum(port), pin);
	}

	pub fn reset(port: Port) void {
		const module = port.get_module();

		syscon.module_reset_assert(module);
		syscon.module_reset_release(module);
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
