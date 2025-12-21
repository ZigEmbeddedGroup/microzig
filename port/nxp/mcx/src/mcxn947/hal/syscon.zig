const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.chip;


// from the reference Manuel, definition of `slow_clk`:
// > Slow clock derived from system_clk divided by 4. slow_clk provides the bus clock for FMU, SPC, CMC, TDET,
// > CMP0, CMP1, VBAT, LPTRM0, LPTRM1, RTC, GPIO5, PORT5, and TSI.

// we use `AHBCLKCTRLSET` and `AHBCLKCTRLCLR` instead of `AHBCLKCTRL`
// as advised in the reference manual
pub fn module_enable_clock(comptime module: Module) void {
    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLSET[module.cc()];

    reg.write_raw(@as(u32, 1) << module.offset());
}
pub fn module_disable_clock(comptime module: Module) void {
    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLCLR[module.cc()];

    reg.write_raw(@as(u32, 1) << module.offset());
}

// same as for `module_enable_clock`
pub fn peripheral_reset_assert(comptime peripheral: Peripheral) void {
    const reg = &chip.peripherals.SYSCON0.PRESETCTRLSET[peripheral.cc()];
    
    reg.write_raw(@as(u32, 1) << peripheral.offset());
}

pub fn peripheral_reset_release(comptime peripheral: Peripheral) void {
    const reg = &chip.peripherals.SYSCON0.PRESETCTRLCLR[peripheral.cc()];
    
    reg.write_raw(@as(u32, 1) << peripheral.offset());
}

pub const Peripheral = enum {
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

    pub fn cc(self: Peripheral) u2 {
        return switch(@intFromEnum(self)) {
            @intFromEnum(Peripheral.FMU)...@intFromEnum(Peripheral.MAILBOX) => 0,
            else => unreachable
        };
    }

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
const Module = enum {
    // from AHBCLKCTRL0
    ROM,
    RAMB_CTRL,
    RAMC_CTRL,
    RAMD_CTRL,
    RAME_CTRL,
    RAMF_CTRL,
    RAMG_CTRL,
    RAMH_CTRL,
    FMU,
    FMC,
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
    WWDT0,
    WWDT1,
    MAILBOX,

    // TODO: AHBCLKCTRL1-3

    // TODO: rename
    /// Assigns a peripheral with the number of the register that handle them
    pub fn cc(self: Module) u2 {
        return switch(@intFromEnum(self)) {
            @intFromEnum(Module.ROM)...@intFromEnum(Module.MAILBOX) => 0,
            else => unreachable
        };
    }

    pub fn offset(self: Module) u5 {
        return switch(self) {
            inline else => |module| @intCast(get_field_offset(module.control_register_ty(), @tagName(module)))
        };
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
