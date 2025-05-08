const std = @import("std");
const EnumField = std.builtin.Type.EnumField;

const microzig = @import("microzig");
const RESETS = microzig.chip.peripherals.RESETS;
const chip = @import("compatibility.zig").chip;
const hw = @import("hw.zig");

pub const Mask =
    switch (chip) {
    .RP2040 => packed struct(u32) {
        adc: bool = true,
        busctrl: bool = true,
        dma: bool = true,
        i2c0: bool = true,
        i2c1: bool = true,
        io_bank0: bool = true,
        io_qspi: bool = true,
        jtag: bool = true,
        pads_bank0: bool = true,
        pads_qspi: bool = true,
        pio0: bool = true,
        pio1: bool = true,
        pll_sys: bool = true,
        pll_usb: bool = true,
        pwm: bool = true,
        rtc: bool = true,
        spi0: bool = true,
        spi1: bool = true,
        syscfg: bool = true,
        sysinfo: bool = true,
        tbman: bool = true,
        timer: bool = true,
        uart0: bool = true,
        uart1: bool = true,
        usbctrl: bool = true,
        padding: u7 = 0,
    },
    .RP2350, .RP2350_QFN80 => packed struct(u32) {
        adc: bool = true,
        busctrl: bool = true,
        dma: bool = true,
        hstx: bool = true,
        i2c0: bool = true,
        i2c1: bool = true,
        io_bank0: bool = true,
        io_qspi: bool = true,
        jtag: bool = true,
        pads_bank0: bool = true,
        pads_qspi: bool = true,
        pio0: bool = true,
        pio1: bool = true,
        pio2: bool = true,
        pll_sys: bool = true,
        pll_usb: bool = true,
        pwm: bool = true,
        sha256: bool = true,
        spi0: bool = true,
        spi1: bool = true,
        syscfg: bool = true,
        sysinfo: bool = true,
        tbman: bool = true,
        timer0: bool = true,
        timer1: bool = true,
        trng: bool = true,
        uart0: bool = true,
        uart1: bool = true,
        usbctrl: bool = true,
        padding: u3 = 0,
    },
};

pub fn reset(mask: Mask) void {
    const raw_mask: u32 = @bitCast(mask);

    RESETS.RESET.write_raw(raw_mask);
    RESETS.RESET.write_raw(0);

    wait_for_reset_done(mask);
}

pub inline fn reset_block(mask: Mask) void {
    hw.set_alias(RESETS).RESET.write_raw(@bitCast(mask));
}

pub inline fn unreset_block(mask: Mask) void {
    hw.clear_alias(RESETS).RESET.write_raw(@bitCast(mask));
}

pub fn unreset_block_wait(mask: Mask) void {
    const raw_mask: u32 = @bitCast(mask);

    hw.clear_alias(RESETS).RESET.write_raw(raw_mask);

    wait_for_reset_done(mask);
}

inline fn wait_for_reset_done(mask: Mask) void {
    const raw_mask: u32 = @bitCast(mask);

    // have to bitcast after a read() instead of `RESETS.RESET_DONE.raw` due to
    // some optimization bug. While loops will not be optimzed away if the
    // condition has side effects like dereferencing a volatile pointer.
    // It seems that volatile is not propagating correctly.
    while (@as(u32, @bitCast(RESETS.RESET_DONE.read())) & raw_mask != raw_mask) {}
}

pub const masks = struct {
    /// Mask of peripherals that should be reset at initialization.
    ///
    /// Used with reset_block(), so "true" in this context means "reset this peripheral"
    pub const init = val: {
        var tmp: Mask = .{};

        tmp.io_qspi = false;
        tmp.pads_qspi = false;
        tmp.pll_usb = false;
        tmp.usbctrl = false;
        tmp.syscfg = false;
        tmp.pll_sys = false;

        break :val tmp;
    };

    /// Mask of all peripherals
    ///
    /// Used with unreset_block(), so "true" in this context means "bring this peripheral out of reset"
    pub const all = Mask{};

    /// Mask of peripherals that are only dependent on sys and ref clocks, meaning
    /// no clock configuration is required for normal operation.
    ///
    /// Used with unreset_block(), so "true" in this context means "bring this peripheral out of reset"
    pub const clocked_by_sys_and_ref = val: {
        var tmp: Mask = .{};

        tmp.adc = false;
        tmp.spi0 = false;
        tmp.spi1 = false;
        tmp.uart0 = false;
        tmp.uart1 = false;
        tmp.usbctrl = false;
        switch (chip) {
            .RP2040 => {
                tmp.rtc = false;
            },
            .RP2350, .RP2350_QFN80 => {
                tmp.hstx = false;
            },
        }
        break :val tmp;
    };
};
