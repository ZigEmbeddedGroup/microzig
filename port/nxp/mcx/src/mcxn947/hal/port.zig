const assert = @import("std").debug.assert;
const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");
const Pin = @import("pin.zig").Pin;
const chip = microzig.chip;

/// A pin Port.
/// Used to control pin configurations.
///
/// A port must be inited using `init` to change its / its pins' configuration.
pub const Port = enum(u3) {
	_,

	/// Returns the corresponding port.
	/// `n` must be at most 5 (inclusive).
	pub fn num(n: u3) Port {
		assert(n <= 5);
		return @enumFromInt(n);
	}

	/// Returns the port's index.
	pub fn get_n(port: Port) u3 {
		return @intFromEnum(port);
	}

	fn get_module(port: Port) syscon.Module {
		return @enumFromInt(@intFromEnum(syscon.Module.PORT0) + port.get_n());
	}

	/// Init the port by releasing an eventual reset and enabling its clock.
	pub fn init(port: Port) void {
		const module = port.get_module();

		syscon.module_reset_release(module);
		syscon.module_enable_clock(module);
	}

	/// Deinit the port by disabling its clock and asserting its reset.
	pub fn deinit(port: Port) void {
		const module = port.get_module();

		syscon.module_disable_clock(module);
		syscon.module_reset_assert(module);
	}

	/// Disables the port's clock.
	pub fn disable_clock(port: Port) void {
		syscon.module_disable_clock(port.get_module());
	}

	/// Resets the port to its default configuration by asserting then
	/// releasing the port's reset.
	pub fn reset(port: Port) void {
		const module = port.get_module();

		syscon.module_reset_assert(module);
		syscon.module_reset_release(module);
	}

	/// Returns the corresponding `GPIO`.
	///
	/// Not all port have 32 pins available (this function currently do no checks).
	pub fn get_gpio(port: Port, pin: u5) gpio.GPIO {
		// TODO: check unavailable pins
		return gpio.num(port.get_n(), pin);
	}

	/// Returns the corresponding `Pin`. Used to configure it.
	///
	/// Not all port have 32 pins available (this function currently do no checks).
	pub fn get_pin(port: Port, pin: u5) Pin {
		// TODO: check unavailable pins
		return Pin.num(port.get_n(), pin);
	}

	/// Returns the port's control registers
	pub fn get_regs(port: Port) *volatile chip.types.peripherals.PORT0 {
		const base: u32 = @intFromPtr(chip.peripherals.PORT0);

		return switch (port.get_n()) {
			0...4 => |i| @ptrFromInt(base + i * @as(u32, 0x1000)),
			5 => @ptrCast(chip.peripherals.PORT5), // port5 has a different address
			else => unreachable
		};
	}
};
