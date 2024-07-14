const std = @import("std");
const EnumField = std.builtin.Type.EnumField;

const microzig = @import("microzig");
const RESETS = microzig.chip.peripherals.RESETS;

const hw = @import("hw.zig");

pub const Mask = packed struct(u32) {
    adc: bool = false,
    busctrl: bool = false,
    dma: bool = false,
    i2c0: bool = false,
    i2c1: bool = false,
    io_bank0: bool = false,
    io_qspi: bool = false,
    jtag: bool = false,
    pads_bank0: bool = false,
    pads_qspi: bool = false,
    pio0: bool = false,
    pio1: bool = false,
    pll_sys: bool = false,
    pll_usb: bool = false,
    pwm: bool = false,
    rtc: bool = false,
    spi0: bool = false,
    spi1: bool = false,
    syscfg: bool = false,
    sysinfo: bool = false,
    tbman: bool = false,
    timer: bool = false,
    uart0: bool = false,
    uart1: bool = false,
    usbctrl: bool = false,
    padding: u7 = 0,
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
    pub const init = Mask{
        .adc = true,
        .busctrl = true,
        .dma = true,
        .i2c0 = true,
        .i2c1 = true,
        .io_bank0 = true,
        .jtag = true,
        .pads_bank0 = true,
        .pio0 = true,
        .pio1 = true,
        .pwm = true,
        .rtc = true,
        .spi0 = true,
        .spi1 = true,
        .sysinfo = true,
        .tbman = true,
        .timer = true,
        .uart0 = true,
        .uart1 = true,
    };

    pub const all = Mask{
        .adc = true,
        .busctrl = true,
        .dma = true,
        .i2c0 = true,
        .i2c1 = true,
        .io_bank0 = true,
        .io_qspi = true,
        .jtag = true,
        .pads_bank0 = true,
        .pads_qspi = true,
        .pio0 = true,
        .pio1 = true,
        .pll_sys = true,
        .pll_usb = true,
        .pwm = true,
        .rtc = true,
        .spi0 = true,
        .spi1 = true,
        .syscfg = true,
        .sysinfo = true,
        .tbman = true,
        .timer = true,
        .uart0 = true,
        .uart1 = true,
        .usbctrl = true,
    };

    pub const clocked_by_sys_and_ref = Mask{
        .busctrl = true,
        .dma = true,
        .i2c0 = true,
        .i2c1 = true,
        .io_bank0 = true,
        .io_qspi = true,
        .jtag = true,
        .pads_bank0 = true,
        .pads_qspi = true,
        .pio0 = true,
        .pio1 = true,
        .pll_sys = true,
        .pll_usb = true,
        .pwm = true,
        .syscfg = true,
        .sysinfo = true,
        .tbman = true,
        .timer = true,
    };
};
