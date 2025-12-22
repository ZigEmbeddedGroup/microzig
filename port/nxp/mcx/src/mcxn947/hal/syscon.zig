const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.chip;


// from the reference Manuel, definition of `slow_clk`:
// > Slow clock derived from system_clk divided by 4. slow_clk provides the bus clock for FMU, SPC, CMC, TDET,
// > CMP0, CMP1, VBAT, LPTRM0, LPTRM1, RTC, GPIO5, PORT5, and TSI.

// we use `AHBCLKCTRLSET` and `AHBCLKCTRLCLR` instead of `AHBCLKCTRL`
// as advised in the reference manual
pub fn module_enable_clock(module: Module) void {
    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLSET[module.cc()];

    reg.write_raw(@as(u32, 1) << module.offset());
}
pub fn module_disable_clock(module: Module) void {
    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLCLR[module.cc()];

    reg.write_raw(@as(u32, 1) << module.offset());
}

// same as for `module_enable_clock`
pub fn peripheral_reset_assert(peripheral: Peripheral) void {
    const reg = &chip.peripherals.SYSCON0.PRESETCTRLSET[peripheral.cc()];
    
    reg.write_raw(@as(u32, 1) << peripheral.offset());
}

pub fn peripheral_reset_release(peripheral: Peripheral) void {
    const reg = &chip.peripherals.SYSCON0.PRESETCTRLCLR[peripheral.cc()];
    
    reg.write_raw(@as(u32, 1) << peripheral.offset());
}

pub const Peripheral = enum(u7) {
    FMU,
    FLEXSPI,
    MUX,
    PORT0,
    PORT1,
    PORT2,
    PORT3,
    PORT4,
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    GPIO4,
    PINT,
    DMA0,
    CRC,
    MAILBOX,

	MRT = 1 << 5,
	OSTIMER,
	SCT,
	ADC0,
	ADC1,
	DAC0,
	RTC,
	EVSIM0,
	EVSIM1,
	UTICK,
	FC0,
	FC1,
	FC2,
	FC3,
	FC4,
	FC5,
	FC6,
	FC7,
	FC8,
	FC9,
	MICFIL,
	TIMER2,
	USB0_FS_DCD,
	USB0_FS,
	TIMER0,
	TIMER1,
	SmartDMA,

    pub fn cc(self: Peripheral) u2 {
		return @intCast(@intFromEnum(self) >> 5);
        // return switch(@intFromEnum(self)) {
        //     @intFromEnum(Peripheral.FMU)...@intFromEnum(Peripheral.MAILBOX) => 0,
        //     @intFromEnum(Peripheral.MRT)...@intFromEnum(Peripheral.SmartDMA) => 1,
        //     else => unreachable
        // };
    }

	// TODO: optimize that if necessary
    pub fn offset(self: Peripheral) u5 {
        return switch(self) {
            inline else => |module| @intCast(get_field_offset(module.control_register_ty(), @tagName(module) ++ "_RST"))
        };
    }

    fn control_register_ty(self: Peripheral) type {
        return switch(self.cc()) {
            0 => @TypeOf(chip.peripherals.SYSCON0.PRESETCTRL0),
            1 => @TypeOf(chip.peripherals.SYSCON0.PRESETCTRL1),
            2 => @TypeOf(chip.peripherals.SYSCON0.PRESETCTRL2),
            3 => @TypeOf(chip.peripherals.SYSCON0.PRESETCTRL3),
        }.underlying_type;
    }
};

// maybe use Clock instead of Module ?
// TODO: generate that at comptime using @Enum ? (rip readability)
pub const Module = enum(u8) {
    // from AHBCLKCTRL0
	ROM 		=  1 | 0 << 5,
	RAMB_CTRL 	=  2 | 0 << 5,
	RAMC_CTRL 	=  3 | 0 << 5,
	RAMD_CTRL 	=  4 | 0 << 5,
	RAME_CTRL 	=  5 | 0 << 5,
	RAMF_CTRL 	=  6 | 0 << 5,
	RAMG_CTRL 	=  7 | 0 << 5,
	RAMH_CTRL 	=  8 | 0 << 5,
	FMU 		=  9 | 0 << 5,
	FMC 		= 10 | 0 << 5,
	FLEXSPI 	= 11 | 0 << 5,
	MUX 		= 12 | 0 << 5,
	PORT0 		= 13 | 0 << 5,
	PORT1 		= 14 | 0 << 5,
	PORT2 		= 15 | 0 << 5,
	PORT3 		= 16 | 0 << 5,
	PORT4 		= 17 | 0 << 5,
	GPIO0 		= 19 | 0 << 5,
	GPIO1 		= 20 | 0 << 5,
	GPIO2 		= 21 | 0 << 5,
	GPIO3 		= 22 | 0 << 5,
	GPIO4 		= 23 | 0 << 5,
	PINT 		= 25 | 0 << 5,
	DMA0 		= 26 | 0 << 5,
	CRC 		= 27 | 0 << 5,
	WWDT0 		= 28 | 0 << 5,
	WWDT1 		= 29 | 0 << 5,
	MAILBOX 	= 31 | 0 << 5,

	MRT 		=  0 | 1 << 5,
	OSTIMER 	=  1 | 1 << 5,
	SCT 		=  2 | 1 << 5,
	ADC0 		=  3 | 1 << 5,
	ADC1 		=  4 | 1 << 5,
	DAC0 		=  5 | 1 << 5,
	RTC 		=  6 | 1 << 5,
	EVSIM0 		=  8 | 1 << 5,
	EVSIM1 		=  9 | 1 << 5,
	UTICK 		= 10 | 1 << 5,
	FC0 		= 11 | 1 << 5,
	FC1 		= 12 | 1 << 5,
	FC2 		= 13 | 1 << 5,
	FC3 		= 14 | 1 << 5,
	FC4 		= 15 | 1 << 5,
	FC5 		= 16 | 1 << 5,
	FC6 		= 17 | 1 << 5,
	FC7 		= 18 | 1 << 5,
	FC8 		= 19 | 1 << 5,
	FC9 		= 20 | 1 << 5,
	MICFIL 		= 21 | 1 << 5,
	TIMER2 		= 22 | 1 << 5,
	USB0_FS_DCD = 24 | 1 << 5,
	USB0_FS 	= 25 | 1 << 5,
	TIMER0 		= 26 | 1 << 5,
	TIMER1 		= 27 | 1 << 5,
	SmartDMA 	= 31 | 1 << 5,

    // TODO: AHBCLKCTRL2-3

    // TODO: rename
    /// Assigns a peripheral with the number of the register that handle them
	// uses u3 because zig sucks at optimizing u7
    pub fn cc(self: Module) u3 {
		return @intCast(@intFromEnum(self) >> 5);
        // return switch(@intFromEnum(self)) {
        //     @intFromEnum(Module.ROM)...@intFromEnum(Module.MAILBOX) => 0,
        //     @intFromEnum(Module.MRT)...@intFromEnum(Module.SmartDMA) => 1,
        //     else => unreachable
        // };
    }

    pub fn offset(self: Module) u5 {
		return @truncate(@intFromEnum(self));
        // return switch(self) {
        //     inline else => |module| @intCast(get_field_offset(module.control_register_ty(), @tagName(module)))
        // };
    }

    fn control_register_ty(self: Module) type {
        return switch(self.cc()) {
            0 => @TypeOf(chip.peripherals.SYSCON0.AHBCLKCTRL0),
            1 => @TypeOf(chip.peripherals.SYSCON0.AHBCLKCTRL1),
            2 => @TypeOf(chip.peripherals.SYSCON0.AHBCLKCTRL2),
            3 => @TypeOf(chip.peripherals.SYSCON0.AHBCLKCTRL3),
        }.underlying_type;
    }
};

/// For a given packed structure `T`, this function returns
/// the bit index its the field named `field_name`.
fn get_field_offset(comptime T: type, comptime field_name: []const u8) u8 {
    std.debug.assert(@typeInfo(T) == .@"struct");
    std.debug.assert(std.meta.containerLayout(T) == .@"packed");
    std.debug.assert(std.meta.fieldIndex(T, field_name) != null);

    var offset: u8 = 0;
    inline for(std.meta.fields(T)) |field| {
        if(std.mem.eql(u8, field.name, field_name)) return offset;
        offset += @bitSizeOf(field.type);
    }
    unreachable;
}
