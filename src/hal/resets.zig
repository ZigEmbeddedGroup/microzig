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
    const raw_mask = @bitCast(u32, mask);

    RESETS.RESET.raw = raw_mask;
    RESETS.RESET.raw = 0;

    while ((RESETS.RESET_DONE.raw & raw_mask) != raw_mask) {}
}

pub fn reset_block(mask: Mask) void {
    hw.set_alias_raw(&RESETS.RESET).* = @bitCast(u32, mask);
}

pub fn unreset_block(mask: Mask) void {
    hw.clear_alias_raw(&RESETS.RESET).* = @bitCast(u32, mask);
}

pub fn unreset_block_wait(mask: Mask) void {
    const raw_mask = @bitCast(u32, mask);
    hw.clear_alias_raw(&RESETS.RESET).* = raw_mask;
    while (RESETS.RESET_DONE.raw & raw_mask != raw_mask) {}
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
