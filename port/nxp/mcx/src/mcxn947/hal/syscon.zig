const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.chip;


// from the reference Manual, definition of `slow_clk`:
// > Slow clock derived from system_clk divided by 4. slow_clk provides the bus clock for FMU, SPC, CMC, TDET,
// > CMP0, CMP1, VBAT, LPTRM0, LPTRM1, RTC, GPIO5, PORT5, and TSI.

// we use `AHBCLKCTRLSET` and `AHBCLKCTRLCLR` instead of `AHBCLKCTRL`
// as advised in the reference manual
//
// the `switch` in `can_enable_clock` and `can_reset` are not great for
// small assembly. It is probably possible to remove them (though it mean writing to reserved bits).

/// Enables the module's clock.
/// It is a no-op if `module.can_control_clock()` is false.
pub fn module_enable_clock(module: Module) void {
    if(!module.can_control_clock()) return;

    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLSET[module.cc()];
    reg.write_raw(@as(u32, 1) << module.offset());
}

/// Disables the module's clock.
/// It is a no-op if `module.can_control_clock()` is false.
pub fn module_disable_clock(module: Module) void {
    if(!module.can_control_clock()) return;

    const reg = &chip.peripherals.SYSCON0.AHBCLKCTRLCLR[module.cc()];
    reg.write_raw(@as(u32, 1) << module.offset());
}

// same as for `module_enable_clock`
/// Asserts the module is reset.
/// The module is reset until `module_reset_release` is called on it.
/// It is a no-op if `module.can_reset()` is false.
pub fn module_reset_assert(module: Module) void {
    if(!module.can_reset()) return;

    const reg = &chip.peripherals.SYSCON0.PRESETCTRLSET[module.cc()];    
    reg.write_raw(@as(u32, 1) << module.offset());
}

/// Release the module's reset.
/// It is a no-op if `module.can_reset()` is false.
pub fn module_reset_release(module: Module) void {
    if(!module.can_reset()) return;

    const reg = &chip.peripherals.SYSCON0.PRESETCTRLCLR[module.cc()];    
    reg.write_raw(@as(u32, 1) << module.offset());
}




// This enum can be automatically generated using `generate.zig`,
// but some fields have been manually added for conveniance (e.g. PORT5, GPIO5)
// TODO: some fields are probably missing, add them
// TODO: use u8
pub const Module = enum(u7) {
    //
    ROM          =  1 | 0 << 5,
    RAMB_CTRL    =  2 | 0 << 5,
    RAMC_CTRL    =  3 | 0 << 5,
    RAMD_CTRL    =  4 | 0 << 5,
    RAME_CTRL    =  5 | 0 << 5,
    RAMF_CTRL    =  6 | 0 << 5,
    RAMG_CTRL    =  7 | 0 << 5,
    RAMH_CTRL    =  8 | 0 << 5,
    FMU          =  9 | 0 << 5,
    FMC          = 10 | 0 << 5,
    FLEXSPI      = 11 | 0 << 5,
    MUX          = 12 | 0 << 5,
    PORT0        = 13 | 0 << 5,
    PORT1        = 14 | 0 << 5,
    PORT2        = 15 | 0 << 5,
    PORT3        = 16 | 0 << 5,
    PORT4        = 17 | 0 << 5,
    PORT5        = 18 | 0 << 5, // manually added
    GPIO0        = 19 | 0 << 5,
    GPIO1        = 20 | 0 << 5,
    GPIO2        = 21 | 0 << 5,
    GPIO3        = 22 | 0 << 5,
    GPIO4        = 23 | 0 << 5,
    GPIO5        = 24 | 0 << 5, // manually added
    PINT         = 25 | 0 << 5,
    DMA0         = 26 | 0 << 5,
    CRC          = 27 | 0 << 5,
    WWDT0        = 28 | 0 << 5,
    WWDT1        = 29 | 0 << 5,
    //
    MAILBOX      = 31 | 0 << 5,

    MRT          =  0 | 1 << 5,
    OSTIMER      =  1 | 1 << 5,
    SCT          =  2 | 1 << 5,
    ADC0         =  3 | 1 << 5,
    ADC1         =  4 | 1 << 5,
    DAC0         =  5 | 1 << 5,
    RTC          =  6 | 1 << 5,
    EVSIM0       =  8 | 1 << 5,
    EVSIM1       =  9 | 1 << 5,
    UTICK        = 10 | 1 << 5,
    FC0          = 11 | 1 << 5,
    FC1          = 12 | 1 << 5,
    FC2          = 13 | 1 << 5,
    FC3          = 14 | 1 << 5,
    FC4          = 15 | 1 << 5,
    FC5          = 16 | 1 << 5,
    FC6          = 17 | 1 << 5,
    FC7          = 18 | 1 << 5,
    FC8          = 19 | 1 << 5,
    FC9          = 20 | 1 << 5,
    MICFIL       = 21 | 1 << 5,
    TIMER2       = 22 | 1 << 5,
    //
    USB0_FS_DCD  = 24 | 1 << 5,
    USB0_FS      = 25 | 1 << 5,
    TIMER0       = 26 | 1 << 5,
    TIMER1       = 27 | 1 << 5,
    //
    PKC_RAM      = 29 | 1 << 5, // At time of writing, this field is present in the SDK and the SVD file but not the reference manual
    //
    SmartDMA     = 31 | 1 << 5,

    //
    DMA1         =  1 | 2 << 5,
    ENET         =  2 | 2 << 5,
    uSDHC        =  3 | 2 << 5,
    FLEXIO       =  4 | 2 << 5,
    SAI0         =  5 | 2 << 5,
    SAI1         =  6 | 2 << 5,
    TRO          =  7 | 2 << 5,
    FREQME       =  8 | 2 << 5,
    //
    //
    //
    //
    TRNG         = 13 | 2 << 5, // same as PKC_RAM
    FLEXCAN0     = 14 | 2 << 5,
    FLEXCAN1     = 15 | 2 << 5,
    USB_HS       = 16 | 2 << 5,
    USB_HS_PHY   = 17 | 2 << 5,
    ELS          = 18 | 2 << 5,
    PQ           = 19 | 2 << 5,
    PLU_LUT      = 20 | 2 << 5,
    TIMER3       = 21 | 2 << 5,
    TIMER4       = 22 | 2 << 5,
    PUF          = 23 | 2 << 5,
    PKC          = 24 | 2 << 5,
    //
    SCG          = 26 | 2 << 5,
    //
    //
    GDET         = 29 | 2 << 5, // same
    SM3          = 30 | 2 << 5, // same
    //

    I3C0         =  0 | 3 << 5,
    I3C1         =  1 | 3 << 5,
    SINC         =  2 | 3 << 5,
    COOLFLUX     =  3 | 3 << 5,
    QDC0         =  4 | 3 << 5,
    QDC1         =  5 | 3 << 5,
    PWM0         =  6 | 3 << 5,
    PWM1         =  7 | 3 << 5,
    EVTG         =  8 | 3 << 5,
    //
    //
    DAC1         = 11 | 3 << 5,
    DAC2         = 12 | 3 << 5,
    OPAMP0       = 13 | 3 << 5,
    OPAMP1       = 14 | 3 << 5,
    OPAMP2       = 15 | 3 << 5,
    //
    //
    CMP2         = 18 | 3 << 5,
    VREF         = 19 | 3 << 5,
    COOLFLUX_APB = 20 | 3 << 5,
    NPU          = 21 | 3 << 5,
    TSI          = 22 | 3 << 5,
    EWM          = 23 | 3 << 5,
    EIM          = 24 | 3 << 5,
    ERM          = 25 | 3 << 5,
    INTM         = 26 | 3 << 5,
    SEMA42       = 27 | 3 << 5,
    //
    //
    //
    //


    /// Returns the index of the control register that handles this module.
    ///
    /// This index is the same for `AHBCLKCTRLn` and `PRESETCTRLn` registers.
    fn cc(module: Module) u2 {
        return @intCast(@intFromEnum(module) >> 5);
    }

    /// Returns the offset of the module in the corresponding control register.
    ///
    /// This offset is the same for `AHBCLKCTRLn` and `PRESETCTRLn` registers.
    fn offset(module: Module) u5 {
        return @truncate(@intFromEnum(module));
    }

    /// Whether a module is reserved (in both `AHBCLKCTRLn` and `PRESETCTRLn` registers).
    /// Modules here have likely been manually added to the enum for convenience.
    fn is_reserved(module: Module) bool {
        return switch(module) {
            .PORT5, .GPIO5 => true,
            else => false
        };
    }

    /// Whether a module can be reset using `PRESETCTRLn` registers.
    fn can_reset(module: Module) bool {
        return switch(module) {
            .ROM,
            .RAMB_CTRL,
            .RAMC_CTRL,
            .RAMD_CTRL,
            .RAME_CTRL,
            .RAMF_CTRL,
            .RAMG_CTRL,
            .RAMH_CTRL,
            .FMC,
            .WWDT0,
            .WWDT1,
            .PKC_RAM,
            .ELS,
            .SCG,
            .GDET,
            .ERM,
            .INTM => false,
            else => !module.is_reserved()
        };
    }

    /// Whether a module's clock can be enabled / disabled using `AHBCLKCTRLn` registers.
    fn can_control_clock(module: Module) bool {
        return !module.is_reserved();
    }
};
