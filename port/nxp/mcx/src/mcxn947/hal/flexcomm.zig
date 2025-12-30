const std = @import("std");
const microzig = @import("microzig");
const syscon = microzig.hal.syscon;
const chip = microzig.chip;
const peripherals = chip.peripherals;

const assert = @import("std").debug.assert;

pub const LPUart = @import("flexcomm/LPUart.zig").LPUart;
pub const LPI2c = @import("flexcomm/LPI2c.zig").LPI2c;

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

	pub const Clock = enum(u3) {
		none 		  = 0,
		PLL 		  = 1,
		FRO_12MHz 	  = 2,
		fro_hf_div 	  = 3,
		clk_1m 		  = 4,
		usb_pll 	  = 5,
		lp_oscillator = 6,
		_ // also no clock
	};
	pub fn set_clock(flexcomm: FlexComm, clock: Clock, divider: u16) void {
		assert(divider > 0 and divider <= 256);
		const n = flexcomm.get_n();
		chip.peripherals.SYSCON0.FLEXCOMMCLKDIV[n].write(.{
			.DIV = @intCast(divider - 1),
			.RESET = .RELEASED,
			.HALT = .RUN,
			.UNSTAB = .STABLE // read-only field
		});
		chip.peripherals.SYSCON0.FCCLKSEL[n].modify_one("SEL", @enumFromInt(@intFromEnum(clock)));
	}

	fn get_n(flexcomm: FlexComm) u4 {
		return @intFromEnum(flexcomm);
	}

	fn get_regs(flexcomm: FlexComm) FlexCommTy {
		// We can't do `base + n * offset` to get the register since the offset
		// is not constant for flexcomm registers
		return FlexComm.Registers[flexcomm.get_n()];
	}
};

