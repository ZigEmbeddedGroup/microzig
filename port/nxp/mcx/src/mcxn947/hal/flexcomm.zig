const std = @import("std");
const microzig = @import("microzig");
const syscon = microzig.hal.syscon;
const chip = microzig.chip;
const peripherals = chip.peripherals;

const assert = @import("std").debug.assert;


pub const FlexComm = enum(u4) {
	_,


	pub const Type = enum(u3) {
		none 		= 0,
		UART 		= 1,
		SPI  		= 2,
		I2C  		= 3,
		@"UART+I2C" = 7 // this is not a mistake
	};
	
	pub const FlexCommTy = *volatile chip.types.peripherals.LP_FLEXCOMM0;
	const Registers: [10]FlexCommTy = .{
		peripherals.LP_FLEXCOMM0,
		peripherals.LP_FLEXCOMM1,
		peripherals.LP_FLEXCOMM2,
		peripherals.LP_FLEXCOMM3,
		peripherals.LP_FLEXCOMM4,
		peripherals.LP_FLEXCOMM5,
		peripherals.LP_FLEXCOMM6,
		peripherals.LP_FLEXCOMM7,
		peripherals.LP_FLEXCOMM8,
		peripherals.LP_FLEXCOMM9,
	};

	pub fn num(n: u4) FlexComm {
		assert(n <= 9);
		return @enumFromInt(n);
	}

	pub fn init(flexcomm: FlexComm, ty: Type) void {
        syscon.peripheral_reset_release(switch (@intFromEnum(flexcomm)) {
            0 => .FC0,
            1 => .FC1,
            2 => .FC2,
            3 => .FC3,
            4 => .FC4,
            5 => .FC5,
            6 => .FC6,
            7 => .FC7,
            8 => .FC8,
            9 => .FC9,
            else => unreachable
        }
);
        syscon.module_enable_clock(switch (@intFromEnum(flexcomm)) {
            0 => .FC0,
            1 => .FC1,
            2 => .FC2,
            3 => .FC3,
            4 => .FC4,
            5 => .FC5,
            6 => .FC6,
            7 => .FC7,
            8 => .FC8,
            9 => .FC9,
            else => unreachable
        }
);
		flexcomm.get_regs().PSELID.modify_one("PERSEL", @enumFromInt(@intFromEnum(ty)));
	}

	pub fn deinit(flexcomm: FlexComm) void {
		syscon.module_disable_clock(switch (@intFromEnum(flexcomm)) {
			0 => .FC0,
			1 => .FC1,
			2 => .FC2,
			3 => .FC3,
			4 => .FC4,
			5 => .FC5,
			6 => .FC6,
			7 => .FC7,
			8 => .FC8,
			9 => .FC9,
			else => unreachable
		}
		);
		syscon.peripheral_reset_assert(switch (@intFromEnum(flexcomm)) {
			0 => .FC0,
			1 => .FC1,
			2 => .FC2,
			3 => .FC3,
			4 => .FC4,
			5 => .FC5,
			6 => .FC6,
			7 => .FC7,
			8 => .FC8,
			9 => .FC9,
			else => unreachable
		}
		);
	}

	fn get_n(flexcomm: FlexComm) u4 {
		return @intFromEnum(flexcomm);
	}

	fn get_regs(flexcomm: FlexComm) FlexCommTy {
		return FlexComm.Registers[flexcomm.get_n()];
	}
};

// TODO: integrate reader / writer interface
pub const LPUart = enum(u4) {
	_,

	pub const LPUartTy = *volatile chip.types.peripherals.LPUART0;
	const Registers: [10]LPUartTy = .{
		peripherals.LPUART0,
		peripherals.LPUART1,
		peripherals.LPUART2,
		peripherals.LPUART3,
		peripherals.LPUART4,
		peripherals.LPUART5,
		peripherals.LPUART6,
		peripherals.LPUART7,
		peripherals.LPUART8,
		peripherals.LPUART9,
	};

	pub const Config = struct {
		data_mode: DataMode = .@"8bit",
		stop_bits_count: enum { one, two } = .one,
		parity: enum(u2) { none = 0, even = 0b10, odd = 0b11 } = .none,
		baudrate: u32 = 115200,
		enable_send: bool = true,
		enable_receive: bool = true,
		bit_order: enum { lsb, mbs } = .lsb,

		/// Whether received bits should be inverted (also applies to start and stop bits)
		rx_invert: bool = false,
		/// Whether transmitted bits should be inverted (also applies to start and stop bits)
		tx_invert: bool = false,

		pub const DataMode = enum {
			@"7bit",
			@"8bit",
			@"9bit",
			@"10bit",
		};
	};

	pub fn init(interface: u4, config: Config, clk: u32) !LPUart {
		FlexComm.num(interface).init(.UART);

		const lpuart: LPUart = @enumFromInt(interface);
		const regs = lpuart.get_regs();
		lpuart.reset();
		_ = lpuart.disable();

		try lpuart.set_baudrate(config.baudrate, clk);
		if(config.data_mode == .@"10bit") regs.BAUD.modify_one("M10", .ENABLED);
		if(config.stop_bits_count == .two) regs.BAUD.modify_one("SBNS", .TWO);

		var ctrl = std.mem.zeroes(@TypeOf(regs.CTRL).underlying_type);
		ctrl.M7 = if(config.data_mode == .@"7bit") .DATA7 else .NO_EFFECT;
		ctrl.PE = if(config.parity != .none) .ENABLED else .DISABLED;
		ctrl.PT = if(@intFromEnum(config.parity) & 1 == 0) .EVEN else .ODD;
		ctrl.M  = if(config.data_mode == .@"9bit") .DATA9 else .DATA8;
		ctrl.TXINV = if(config.tx_invert) .INVERTED else .NOT_INVERTED;
		ctrl.IDLECFG = .IDLE_2; // TODO: make this configurable ?
		ctrl.ILT = .FROM_STOP; // same
		regs.CTRL.write(ctrl);


		// clear flags and set bit order
		var stat = std.mem.zeroes(@TypeOf(regs.STAT).underlying_type);
		// read and write on these bits are different
		// writing one cleare those flags
		stat.RXEDGIF = .EDGE;
		stat.IDLE = .IDLE;
		stat.OR = .OVERRUN;
		stat.NF = .NOISE;
		stat.FE = .ERROR;
		stat.PF = .PARITY;
		stat.LBKDIF = .DETECTED;
		stat.MA1F = .MATCH;
		stat.MA2F = .MATCH;

		stat.MSBF = if(config.bit_order == .lsb) .LSB_FIRST else .MSB_FIRST;
		stat.RXINV = if(config.rx_invert) .INVERTED else .NOT_INVERTED;
		regs.STAT.modify(stat);


		lpuart.enable(config.enable_send, config.enable_receive);

		return lpuart;
	}

	/// Resets the Uart interface and deinit the corresponding FlexComm interface.
	pub fn deinit(lpuart: LPUart) void {
		lpuart.reset();
		FlexComm.num(lpuart.get_n()).deinit();
	}

	/// Resets the Uart interface.
	pub fn reset(lpuart: LPUart) void {
		lpuart.get_regs().GLOBAL.modify_one("RST", .RESET);
		lpuart.get_regs().GLOBAL.modify_one("RST", .NO_EFFECT);
	}

	/// Disables the interface.
	/// Returns if the transmitter and the receiver were enabled (in this order).
	pub fn disable(lpuart: LPUart) struct { bool, bool } {
		const regs = lpuart.get_regs();
		var ctrl = regs.CTRL.read();
		const enabled = .{ ctrl.TE == .ENABLED, ctrl.RE == .ENABLED };

		ctrl.TE = .DISABLED;
		ctrl.RE = .DISABLED;

		regs.CTRL.write(ctrl);

		return enabled;
	}

	/// Enables the transmitter and/or the receiver depending on the parameters.
	pub fn enable(lpuart: LPUart, transmitter_enabled: bool, receiver_enabled: bool) void {
		const regs = lpuart.get_regs();

		var ctrl = regs.CTRL.read();
		ctrl.TE = if(transmitter_enabled) .ENABLED else .DISABLED;
		ctrl.RE = if(receiver_enabled) .ENABLED else .DISABLED;
		regs.CTRL.write(ctrl);
	}

	/// Sets the baudrate of the interface to the closest value possible to `baudrate`.
	/// A `baudrate` of 0 will disable the baudrate generator
	/// The final baudrate will be withing 3% of the desired one. If one cannot be found,
	/// this function errors.
	///
	/// Whether a baudrate is available depends on the clock of the interface.
	// TODO: remove `clk` parameter by fetching the clock
	// TODO: check if there is a risk of losing data since we disable then enable the receiver
	pub fn set_baudrate(lpuart: LPUart, baudrate: u32, clk: u32) error { BaudrateUnavailable }!void {

		const regs = lpuart.get_regs();
		var best_osr: u5 = 0;
		var best_sbr: u13 = 0;
		var best_diff = baudrate;

		if(baudrate == 0) {
			// both the receiver and transmitter must be disabled while changing the baudrate
			const te, const re = lpuart.disable();
			defer lpuart.enable(te, re);
            
			var baud = regs.BAUD.read();
			baud.SBR = 0;
			baud.OSR = .DEFAULT;
			return regs.BAUD.write(baud);
		}

		// Computes the best value for osr and sbr that satisfies
		// baudrate = clk / (osr * sbr) with a 3% tolerance (same value as MCUXpresso)
		//
		// the doc of the SBR field of the `BAUD` register says it is
		// baudrate = clk / ((OSR + 1) * SBR), but I think they meant
		// baudrate = clk / ((BAUD[OSR] + 1) * sbr)
		for(4..33) |osr| {
			// the SDK's driver does a slightly different computation (((2 * clk / (baudrate * osr)) + 1) / 2)
			const sbr: u13 = @intCast(std.math.clamp(clk / (baudrate * osr), 1, std.math.maxInt(u13)));
			const computed_baudrate = clk / (osr * sbr);
			const diff = if(computed_baudrate > baudrate) computed_baudrate - baudrate else baudrate - computed_baudrate;

			if(diff <= best_diff) {
				best_diff = diff;
				best_osr = @intCast(osr);
				best_sbr = sbr;
			}
		}
		if(best_diff > 3 * baudrate / 100) {
			return error.BaudrateUnavailable;
		}

		// both the receiver and transmitter must be disabled while changing the baudrate
		const te, const re = lpuart.disable();
		defer lpuart.enable(te, re);
        
		var baud = regs.BAUD.read();
		baud.SBR = best_sbr;
		baud.OSR = @enumFromInt(best_osr - 1);
		baud.BOTHEDGE = if(best_osr <= 7) .ENABLED else .DISABLED;
		regs.BAUD.write(baud);
	}

	/// Return the current, real baudrate of the interface (see `set_baudrate` for more details).
	pub fn get_actual_baudrate(lpuart: LPUart, clk: u32) f32 {
		const regs = lpuart.get_regs();
		const baud = regs.BAUD.read();

		return @as(f32, clk) / (baud.SBR * (@intFromEnum(baud.OSR) + 1));
	}

	fn get_n(lpuart: LPUart) u4 {
		return @intFromEnum(lpuart);
	}

	fn get_regs(lpuart: LPUart) LPUartTy {
		return LPUart.Registers[lpuart.get_n()];
	}

	// TODO: other modes than 8-bits
	// TODO: non blocking
	// TODO: max retries
	pub fn transmit(lpuart: LPUart, buf: []const u8) void {
		const regs = lpuart.get_regs();

		const data: *volatile u8  = @ptrCast(&regs.DATA);

		for(buf) |c| {
			while(regs.STAT.read().TDRE == .TXDATA) {}
			data.* = c;
		}

		while(regs.STAT.read().TC != .COMPLETE) {}
	}
};

fn delay_cycles(cycles: u32) void {
	for (0..cycles) |_| {
		asm volatile ("nop");
	}
}
