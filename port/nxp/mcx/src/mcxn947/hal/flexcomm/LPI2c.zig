const std = @import("std");
const microzig = @import("microzig");
const FlexComm = @import("../flexcomm.zig").FlexComm;

const chip = microzig.chip;
const peripherals = chip.peripherals;

pub const LPI2c = enum(u4) {
	_,

	pub const LPI2cTy = *volatile chip.types.peripherals.LPI2C0;
	const Registers: [10]LPI2cTy = .{
		peripherals.LPI2C0,
		peripherals.LPI2C1,
		peripherals.LPI2C2,
		peripherals.LPI2C3,
		peripherals.LPI2C4,
		peripherals.LPI2C5,
		peripherals.LPI2C6,
		peripherals.LPI2C7,
		peripherals.LPI2C8,
		peripherals.LPI2C9,
	};

	pub const Config = struct {
		baudrate: u32 = 100_000,
		enabled: bool = true,
		mode: OperatingMode = .standard,

		pub const OperatingMode = enum { standard, fast, fastplus, highspeed, ultrafast };
	};

	pub const Error = error {
		UnexpectedNack,
		ArbitrationLost,
		FifoError,
		PinLowTimeout,
		BusBusy
	};

	// controller only
	pub fn init(interface: u4, config: Config, clk: u32) !LPI2c {
		FlexComm.num(interface).init(.I2C);

		const i2c: LPI2c = @enumFromInt(interface);
		const regs = i2c.get_regs();
		i2c.reset();

		try i2c.set_baudrate(config.mode, config.baudrate, clk);

		regs.MCFGR1.modify_one("PINCFG", .OPEN_DRAIN_2_PIN);
		// TODO: clear flags

		if(config.enabled) i2c.set_enabled(true);

		return i2c;
	}

	fn is_bus_busy(i2c: LPI2c) bool {
		return i2c.get_regs().MSR.read().BBF == .BUSY;
	}

	pub fn check_flags(i2c: LPI2c) Error!void {
		const MSR = i2c.get_regs().MSR.read();
		const NDF: bool = MSR.NDF == .INT_YES;
		const ALF: bool = MSR.ALF == .INT_YES;
		const FEF: bool = MSR.FEF == .INT_YES;
		const PLTF: bool = MSR.PLTF == .INT_YES;
		if(NDF or ALF or FEF or PLTF) {
			// note: this may not clear FLTF flag (see reference manual)
			i2c.clear_flags();

			// The sdk resets the fifos for some reason
			// i2c.reset_fifos();

			if(NDF) return error.UnexpectedNack;
			if(ALF) return error.ArbitrationLost;
			if(FEF) return error.FifoError;
			if(PLTF) return error.PinLowTimeout;
		}
		return;
	}

	pub fn clear_flags(i2c: LPI2c) void {
		i2c.get_regs().MSR.write_raw(0);
	}

	fn reset_fifos(i2c: LPI2c) void {
		i2c.get_regs().MCR.modify(.{
			.RRF = .RESET,
			.RTF = .RESET
		});
	}

	pub fn send_start(i2c: LPI2c, address: u7, mode: enum(u2) { write = 0, read = 1}) Error!void {
		if(i2c.is_bus_busy()) return Error.BusBusy;

		i2c.get_regs().MTDR.write(.{
			.DATA = (@as(u8, address) << 1) | @intFromEnum(mode),
			.CMD = .GENERATE_START_AND_TRANSMIT_ADDRESS_IN_DATA_7_THROUGH_0
		});
	}

	pub fn send_stop(i2c: LPI2c) !void {
		// wait for space in tx fifo
		while(!i2c.can_write()) try i2c.check_flags();
		i2c.get_regs().MTDR.write(.{
			.DATA = 0,
			.CMD = .GENERATE_STOP_CONDITION
		});
	}

	// TODO: multiple sends
	pub fn send_blocking(i2c: LPI2c, address: u7, data: []const u8) Error!void {
		const MTDR: *volatile u8 = @ptrCast(&i2c.get_regs().MTDR);

		if(i2c.is_bus_busy()) return error.BusBusy;
		i2c.clear_flags();

		try i2c.send_start(address, .write);

		for(data) |c| {
			while(!i2c.can_write()) try i2c.check_flags();
			MTDR.* = c;
		}
		try i2c.send_stop();
		var flags = i2c.get_regs().MSR.read();
		try i2c.check_flags();
		while(flags.SDF != .INT_YES and flags.TDF != .ENABLED) {
			flags = i2c.get_regs().MSR.read();
			try i2c.check_flags();
		}
		i2c.get_regs().MSR.write_raw(1 << 9);
	}

	pub fn recv_blocking(i2c: LPI2c, address: u7, buffer: []u8) Error!void {
		const MRDR: *volatile u8 = @ptrCast(&i2c.get_regs().MRDR);

		i2c.send_start(address, .read);
		for(buffer) |*c| {
			// could be made more optimal by reading `RXEMPTY` from `MRDR`
			while(!i2c.can_read()) try i2c.check_flags();
			c.* = MRDR.*;
		}
		i2c.send_stop();
	}

	fn can_read(i2c: LPI2c) bool {
		return i2c.get_fifo_counts().rx > 0;
	}

	pub fn can_write(i2c: LPI2c) bool {
		return i2c.get_fifo_counts().tx < i2c.get_fifo_sizes().tx;
	}

	// The `PARAM` register is readonly with default value of 3
	// for `MTXFIFO` and `MRXFIFO`
	pub fn get_fifo_sizes(i2c: LPI2c) struct { tx: u16, rx: u16 } {
		_ = i2c;
		// const param = i2c.get_regs().PARAM.read();
		// return .{ @as(u16, 1) << param.MTXFIFO, @as(u16, 1) << param.MRXFIFO };
		return .{ .tx = 8, .rx = 8 };
	}

	pub fn get_fifo_counts(i2c: LPI2c) struct { tx: u8, rx: u8 } {
		const MFSR  = i2c.get_regs().MFSR.read();
		return .{ .tx = MFSR.TXCOUNT, .rx = MFSR.RXCOUNT };
	}

	/// Resets the Uart interface and deinit the corresponding FlexComm interface.
	pub fn deinit(i2c: LPI2c) void {
		i2c.reset();
		FlexComm.num(i2c.get_n()).deinit();
	}

	/// Resets the I2C interface.
	pub fn reset(i2c: LPI2c) void {
		i2c.get_regs().SCR.modify_one("RST", .RESET);
		i2c.get_regs().SCR.modify_one("RST", .NOT_RESET);
		// TODO: reset the SCR register
	}

	fn get_n(i2c: LPI2c) u4 {
		return @intFromEnum(i2c);
	}

	pub fn get_regs(i2c: LPI2c) LPI2cTy {
		return LPI2c.Registers[i2c.get_n()];
	}

	/// `lpi2c_clk` in Hz
	/// controller (master) mode only
	pub fn set_baudrate(i2c: LPI2c, mode: Config.OperatingMode, baudrate: u32, lpi2c_clk_f: u32) error { BaudrateUnavailable }!void {
		const regs = i2c.get_regs();
		// We currently assume these are negligible, but it could be useful
		// to make them configurable
		const scl_risetime: u8 = 0;
		const sda_risetime: u8 = 0;

		// time constraints from I2C's specification (UM10204)
		// we use the unit of 10ns to avoid floats
		//
		// see the comments above the definition of `sethold` below for more details
		const max_baudrate: u32,
		const min_sethold: u32,
		const min_clk_low: u32,
		const min_clk_high: u32 = switch(mode) {
			//               baudrate (Hz), sethold (10ns), clk_lo (10ns), clk_hi (10ns)
			.standard => .{   100_000,      470,            470,           400  },
			.fast 	  => .{   400_000,       60,            130,           60   },
			.fastplus => .{ 1_000_000,      260,             50,           26   },
			else => @panic("Invalid mode")
		};
		// to convert from 10ns to 1s, we divide by 10^8
		const conv_factor = std.math.pow(u32, 10, 8);
		if(baudrate > max_baudrate) return error.BaudrateUnavailable;


		// The variables used here correspond to the ones in NXP's reference manual
		// of the LPI2C module, plus a few others

		// baudrate = 1/t_SCL
		// t_SCL = (clk_hi + clk_lo + 2 + scl_latency) * 2^prescale   *  lpi2c_clk_t = 1/baudrate
		// scl_latency = floor((2 + filt_scl + scl_risetime) / 2^prescale)
		//
		// => clk_hi + clk_lo = lpi2c_clk_f / baudrate / 2^prescale - 2 - scl_latency
		//
		//
		// 1/baudrate >= 1/limits[0]
		// clk_hi + clk_lo + 2 + scl_latency >= (lpi2c_clk_f / 2^prescale) / limits[0] >= 1 / limits[0] 

		const filt_scl, const filt_sda = blk: {
			const mcfgr2 = regs.MCFGR2.read();
			break :blk .{ mcfgr2.FILTSCL, mcfgr2.FILTSDA };
		};
		var best_prescale: ?u3 = 0;
		var @"best clk_hi + clk_lo": u7 = 0;
		var best_err: u32 = std.math.maxInt(u32);

		for(0..8) |p| {
			const prescale: u3 = @intCast(p);
			const scl_latency: u8 = (2 + filt_scl + scl_risetime) >> prescale;

			if((lpi2c_clk_f / baudrate) >> prescale < 2 + scl_latency) break;

			const @"clk_hi + clk_lo": u32 = ((lpi2c_clk_f / baudrate) >> prescale) - 2 - scl_latency;
			// the max available for clk_hi and clk_lo is both 63
			if(@"clk_hi + clk_lo" > 126) continue; // we need a bigger prescaler
			
			const computed_baudrate = lpi2c_clk_f / (@"clk_hi + clk_lo" + 2 + scl_latency) << prescale;
			const err = if(computed_baudrate > baudrate) computed_baudrate - baudrate else baudrate - computed_baudrate;
			if(computed_baudrate > max_baudrate) continue;
			// TODO: do we want the smallest or the largest prescaler ?
			if(err < best_err) {
				best_err = err;
				best_prescale = @intCast(prescale);
				@"best clk_hi + clk_lo" = @intCast(@"clk_hi + clk_lo");
				if(err == 0) break;
			}
		}

		if(best_prescale == null) return error.BaudrateUnavailable;

		const prescale = best_prescale.?;
		const sda_latency: u8 = (2 + filt_sda + scl_risetime) >> prescale;
		const scl_latency: u8 = (2 + filt_scl + sda_risetime) >> prescale;

		// We want clk_lo >= clk_hi to let more time for the signal to settle
		// we start from a duty cycle of ~50% and then adjust the timings
		// because we are guaranteed that (clk_hi + clk_lo + 2 + scl_latency) >= 1/limits[0] >= t_low_min + t_high_min >= 2 × t_high_min
		// ...
		var clk_lo: u6 = @intCast(std.math.divCeil(u7, @"best clk_hi + clk_lo", 2) catch unreachable);

		// t_low = (clk_lo + 1) × 2^prescale  × lpi2c_clk_t >= min_clk_low
		// <=>                   (clk_lo + 1) × 2^prescale  >= min_clk_low × lpi2c_clk_f  (with `min_clk_low` in seconds)
		const min_low_cycle_count: u32 = @intCast(std.math.divCeil(u64, @as(u64, min_clk_low) * lpi2c_clk_f, conv_factor) catch unreachable);
		while(((clk_lo + 1) << prescale) < min_low_cycle_count) {
			clk_lo += 1;
		}
		const clk_hi: u6 = @intCast(@"best clk_hi + clk_lo" - clk_lo);

		std.debug.assert(((clk_hi + 1 + scl_latency) << prescale) >= @as(u64, min_clk_high) * lpi2c_clk_f / conv_factor);
		std.debug.assert(((clk_lo + 1 			   ) << prescale) >= @as(u64, min_clk_low ) * lpi2c_clk_f / conv_factor);

		// corresponds somewhat to t_HD;STA, t_SU;STA and t_SU;STO
		// per I2C spec, we must have
		// t_HD;STA >= 4.0µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
		// t_SU;STA >= 4.7µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
		// t_SU;STO >= 4.0µs, 0.6µs, 0.26µs (in standard, fast, fast+ mode)
		// `min_sethold` is the max of that
		//
		// we need t_hold = (sethold + 1 + scl_latency) × 2^prescale × lpi2c_clk_t >= min_sethold (s)
		// => sethold >= min_sethold (s) × lpi2c_clk_f / 2^prescale - scl_latency - 1
		const sethold = ((@as(u64, min_sethold) * lpi2c_clk_f / conv_factor) >> prescale) - scl_latency;

		// corresponds to t_HD;DAT, t_VD;DAT and t_VD;ACK
		// min: 0
		// max: t_low
		//
		// I am not sure about what value to chose, so I take the highest possible
		// to maximize the time the value in the data bus is available
		const datavd = clk_lo - sda_latency - 1; // given by NXP's doc

		// minimize time disabled by disabling here
		const enabled = i2c.disable();
		defer i2c.set_enabled(enabled);
		regs.MCCR0.write(.{
			.CLKLO = clk_lo,
			.CLKHI = clk_hi,
			.SETHOLD = @intCast(sethold),
			.DATAVD = @intCast(datavd)
		});

		regs.MCFGR1.modify_one("PRESCALE", @enumFromInt(prescale));
	}

	pub fn get_actual_baudrate(i2c: LPI2c, clk: u32) f32 {
		const regs = i2c.get_regs();
		const MCCR0 = regs.MCCR0.read();
		const MCFGR1 = regs.MCFGR1.read();
		const prescale = @intFromEnum(MCFGR1.PRESCALE);

		const filt_scl: u8 = regs.MCFGR2.read().FILTSCL;
		const scl_risetime = 0;
		const scl_latency: u8 = (2 + filt_scl + scl_risetime) >> prescale;
		var computed_baudrate: f32 = @floatFromInt(clk);
		computed_baudrate /= @floatFromInt(@as(u8, MCCR0.CLKLO) + MCCR0.CLKHI + 2 + scl_latency);
		computed_baudrate /= std.math.pow(f32, 2, @floatFromInt(prescale));

		return computed_baudrate;
	}

	pub fn disable(i2c: LPI2c) bool {
		const regs = i2c.get_regs();
		var MCR = regs.MCR.read();
		const enabled = MCR.MEN == .ENABLED;

		MCR.MEN = .DISABLED;
		regs.MCR.write(MCR);
		return enabled;
	}

	pub fn set_enabled(i2c: LPI2c, enabled: bool) void {
		i2c.get_regs().MCR.modify_one("MEN", if(enabled) .ENABLED else .DISABLED);
	}
};

// TODO: use the register VERID to check the presence of controller mode
