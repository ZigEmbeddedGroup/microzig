const microzig = @import("microzig");
const hal = microzig.hal;
const chip = microzig.chip;

pub const Pin = enum(u8) {
	_,

	const PinTy = *volatile @FieldType(chip.types.peripherals.PORT0, "PCR0");
	// TODO: check if a given pin is actually available
	pub fn num(port: u3, pin: u5) Pin {
		@import("std").debug.assert(port <= 5);
		return @enumFromInt((@as(u8, port) << 5) | pin);
	}

	pub fn get_port(pin: Pin) hal.Port {
		return @enumFromInt(@intFromEnum(pin) >> 5);
	}

	pub fn get_n(pin: Pin) u5 {
		return @truncate(@intFromEnum(pin));
	}

	// TODO: check if features are available for a given pin
	pub fn set_config(pin: Pin, c: Config) void {
		const base = @intFromPtr(&pin.get_port().get_regs().PCR0);
		const reg: PinTy = @ptrFromInt(base + pin.get_n() * @as(u32, 4));

		reg.write_raw(@as(u16, @bitCast(c)));
	}

	pub fn configure(pin: Pin) Configurator {
		return Configurator.default(pin);
	}

	// TODO: not all options are available on all port and pins
	pub const Config = packed struct (u16) {
		pull: Pull,
		pull_resistor_strength: Strength, // not supported everywhere
		slew_rate: SlewRate, // same
		passive_filter_enabled: bool, // same
		open_drain_enabled: bool,
		drive_strength: Strength, // same
		reserved7: u1 = 0,
		mux: u4,
		input_buffer_enabled: bool,
		invert_input: bool,
		reserved14: u1 = 0,
		lock: bool,

		pub const Pull = enum(u2) { disabled = 0, down = 0b10, up = 0b11 };
		pub const SlewRate = enum(u1) { fast = 0, slow = 1 };
		pub const Strength = enum(u1) { low = 0, high = 1 };
	};

	pub const Configurator = struct {
		pin: Pin,
		config: Config,

		// real default value depends on the port and pin
		// we could get it using the reset value provided in the svd
		pub fn default(pin: Pin) Configurator {
			return .{
				.pin = pin,
				.config = .{
					.pull = .disabled,
					.pull_resistor_strength = .low,
					.slew_rate = .fast,
					.passive_filter_enabled = false,
					.open_drain_enabled = false,
					.drive_strength = .low,
					.mux = 0,
					.input_buffer_enabled = false,
					.invert_input = false,
					.lock = false
				}
			};
		}

		pub fn set_pull(old: Configurator, pull: Config.Pull) Configurator {
			var new = old;
			new.config.pull = pull;
			return new;
		}

		pub fn set_pull_strength(old: Configurator, strength: Config.Strength) Configurator {
			var new = old;
			new.config.pull_resistor_strength = strength;
			return new;
		}

		pub fn set_slew_rate(old: Configurator, slew_rate: Config.SlewRate) Configurator {
			var new = old;
			new.config.slew_rate = slew_rate;
			return new;
		}

		/// Enables the pin's passive filter
		pub fn enable_filter(old: Configurator) Configurator {
			var new = old;
			new.config.passive_filter_enabled = true;
			return new;
		}

		pub fn disable_filter(old: Configurator) Configurator {
			var new = old;
			new.config.passive_filter_enabled = false;
			return new;
		}

		pub fn enable_open_drain(old: Configurator) Configurator {
			var new = old;
			new.config.open_drain_enabled = true;
			return new;
		}

		pub fn disable_open_drain(old: Configurator) Configurator {
			var new = old;
			new.config.open_drain_enabled = false;
			return new;
		}

		pub fn set_drive_strength(old: Configurator, strength: Config.Strength) Configurator {
			var new = old;
			new.config.drive_strength = strength;
			return new;
		}

		pub fn alt(old: Configurator, mux: u4) Configurator {
			var new = old;
			new.config.mux = mux;
			return new;
		}

		pub fn enable_input_buffer(old: Configurator) Configurator {
			var new = old;
			new.config.input_buffer_enabled = true;
			return new;
		}

		pub fn disable_input_buffer(old: Configurator) Configurator {
			var new = old;
			new.config.input_buffer_enabled = false;
			return new;
		}

		/// Enables the pin's passive filter
		pub fn invert_input(old: Configurator, enabled: bool) Configurator {
			var new = old;
			new.config.invert_input = enabled;
			return new;
		}

		pub fn lock(old: Configurator, enabled: bool) Configurator {
			var new = old;
			new.config.lock = enabled;
			return new;
		}

		pub fn done(c: Configurator) void {
			c.pin.set_config(c.config);
		}
	};
};
