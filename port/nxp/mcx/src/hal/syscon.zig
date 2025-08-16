const microzig = @import("microzig");

const chip = microzig.chip;

pub inline fn unlock_clock_configuration() void {
    chip.peripherals.SYSCON.CLKUNLOCK.write(.{ .UNLOCK = .ENABLE });
}

pub inline fn freeze_clock_configuration() void {
    chip.peripherals.SYSCON.CLKUNLOCK.write(.{ .UNLOCK = .FREEZE });
}

pub fn enable_clock(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_CC0_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC0_SET)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_CC1_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC1_SET)) | peripheral.mask(),
        ),
    }
}

pub fn disable_clock(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_CC0_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC0_CLR)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_CC1_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_CC1_CLR)) | peripheral.mask(),
        ),
    }
}

pub fn reset_release(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_RST0_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST0_SET)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_RST1_SET.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST1_SET)) | peripheral.mask(),
        ),
    }
}

pub fn reset_assert(comptime peripheral: Peripheral) void {
    unlock_clock_configuration();
    defer freeze_clock_configuration();

    switch (peripheral.cc()) {
        0 => chip.peripherals.MRCC0.MRCC_GLB_RST0_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST0_CLR)) | peripheral.mask(),
        ),
        1 => chip.peripherals.MRCC0.MRCC_GLB_RST1_CLR.write_raw(
            @as(u32, @bitCast(chip.peripherals.MRCC0.MRCC_GLB_RST1_CLR)) | peripheral.mask(),
        ),
    }
}

pub const Peripheral = enum {
    // MRCC_GLB_CC0, MRCC_GLB_ACC0, MRCC_GLB_RST0
    INPUTMUX0,
    I3C0,
    CTIMER0,
    CTIMER1,
    CTIMER2,
    FREQME,
    UTICK0,
    WWDT0,
    DMA,
    AOI0,
    CRC,
    EIM,
    ERM,
    LPI2C0,
    LPSPI0,
    LPSPI1,
    LPUART0,
    LPUART1,
    LPUART2,
    USB0,
    QDC0,
    FLEXPWM0,
    OSTIMER0,
    ADC0,
    CMP0,
    CMP1,
    PORT0,
    PORT1,
    PORT2,

    // MRCC_GLB_CC1, MRCC_GLB_ACC1, MRCC_GLB_RST1
    PORT3,
    MTR,
    TCU,
    EZRAMC_RAMA,
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    ROMCP,

    // FlexPWM SM[0|1|2]

    fn cc(comptime peripheral: Peripheral) u1 {
        return switch (peripheral) {
            .INPUTMUX0 => 0,
            .I3C0 => 0,
            .CTIMER0 => 0,
            .CTIMER1 => 0,
            .CTIMER2 => 0,
            .FREQME => 0,
            .UTICK0 => 0,
            .WWDT0 => 0,
            .DMA => 0,
            .AOI0 => 0,
            .CRC => 0,
            .EIM => 0,
            .ERM => 0,
            .LPI2C0 => 0,
            .LPSPI0 => 0,
            .LPSPI1 => 0,
            .LPUART0 => 0,
            .LPUART1 => 0,
            .LPUART2 => 0,
            .USB0 => 0,
            .QDC0 => 0,
            .FLEXPWM0 => 0,
            .OSTIMER0 => 0,
            .ADC0 => 0,
            .CMP0 => 0,
            .CMP1 => 0,
            .PORT0 => 0,
            .PORT1 => 0,
            .PORT2 => 0,

            .PORT3 => 1,
            .MTR => 1,
            .TCU => 1,
            .EZRAMC_RAMA => 1,
            .GPIO0 => 1,
            .GPIO1 => 1,
            .GPIO2 => 1,
            .GPIO3 => 1,
            .ROMCP => 1,
        };
    }

    fn mask(comptime peripheral: Peripheral) u32 {
        return switch (peripheral) {
            .INPUTMUX0 => 0,
            .I3C0 => 1,
            .CTIMER0 => 1 << 2,
            .CTIMER1 => 1 << 3,
            .CTIMER2 => 1 << 4,
            .FREQME => 1 << 5,
            .UTICK0 => 1 << 6,
            .WWDT0 => 1 << 7,
            .DMA => 1 << 8,
            .AOI0 => 1 << 9,
            .CRC => 1 << 10,
            .EIM => 1 << 11,
            .ERM => 1 << 12,
            .LPI2C0 => 1 << 16,
            .LPSPI0 => 1 << 17,
            .LPSPI1 => 1 << 18,
            .LPUART0 => 1 << 19,
            .LPUART1 => 1 << 20,
            .LPUART2 => 1 << 21,
            .USB0 => 1 << 22,
            .QDC0 => 1 << 23,
            .FLEXPWM0 => 1 << 24,
            .OSTIMER0 => 1 << 25,
            .ADC0 => 1 << 26,
            .CMP0 => 1 << 27,
            .CMP1 => 1 << 28,
            .PORT0 => 1 << 29,
            .PORT1 => 1 << 30,
            .PORT2 => 1 << 31,

            .PORT3 => 0,
            .MTR => 2,
            .TCU => 1 << 3,
            .EZRAMC_RAMA => 1 << 4,
            .GPIO0 => 1 << 5,
            .GPIO1 => 1 << 6,
            .GPIO2 => 1 << 7,
            .GPIO3 => 1 << 8,
            .ROMCP => 1 << 9,
        };
    }
};
