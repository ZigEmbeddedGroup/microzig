const microzig = @import("microzig");
const hal = microzig.hal;
const chip = microzig.chip;

/// A single pin.
pub const Pin = enum(u8) {
	_,

	const PinTy = *volatile @FieldType(chip.types.peripherals.PORT0, "PCR0");

	/// Returns the corresponding `Pin`.
	///
	/// This function currently does not check whether the pin is available.
	// TODO: check if a given pin is actually available
	pub fn num(port: u8, pin: u5) Pin {
		@import("std").debug.assert(port <= 5);

		return @enumFromInt((port << 5) | pin);
	}

	pub fn get_port(pin: Pin) hal.Port {
		return hal.Port.num(@intCast(@intFromEnum(pin) >> 5));
	}

	pub fn get_n(pin: Pin) u5 {
		return @truncate(@intFromEnum(pin));
	}

	/// Apply a config to a pin (see `Pin.configure`).
	///
	/// Locking a pin prevent its config to be changed until the next system reset.
	///
	/// Not all config options are available for all pins (this function currently do no checks).
	// TODO: check if features are available for a given pin
	pub fn set_config(pin: Pin, config: Config) void {
		const base = @intFromPtr(&pin.get_port().get_regs().PCR0);
		const reg: PinTy = @ptrFromInt(base + pin.get_n() * @as(u32, 4));

		reg.write_raw(@as(u16, @bitCast(config)));
	}

	/// Returns the pin configurator (essentially a builder).
	/// Each function can change a setting from the default.
	///
	/// The default config is available using `Config.Default`. It is not pin
	/// specific and therefore does not correspond to the actual pin's default config.
	///
	/// Example:
	/// ```zig
	/// pin.configure()
	///     .alt(2)
	///     .enable_input_buffer()
	///     .done();
	/// ```
	pub fn configure(pin: Pin) Configurator {
		return Configurator.default(pin);
	}

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

		/// This default config is not pin specific and therefore does not
		/// correspond to the actual pin's default config.
		pub const Default = Config {
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
		};
	};

	pub const Configurator = struct {
		pin: Pin,
		config: Config,

		// real default value depends on the port and pin
		// we could get it using the reset value provided in the svd
		pub fn default(pin: Pin) Configurator {
			return .{
				.pin = pin,
				.config = .Default
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

		/// Apply the config to the pin.
		pub fn done(c: Configurator) void {
			c.pin.set_config(c.config);
		}
	};
};
