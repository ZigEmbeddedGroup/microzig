//! GPIO matrix and IO mux registers of the esp32c3.
//!
//! See section 5 of the Technical Reference Manual
//! https://www.espressif.com/sites/default/files/documentation/esp32-c3_technical_reference_manual_en.pdf

const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const IO_MUX = peripherals.IO_MUX;
const GPIO = peripherals.GPIO;

/// Number of usable pads, the pins are numbered 0 to `pin_count - 1`.
pub const pin_count = 22;

/// Integer holding one bit per pad.
pub const PinMask = u22;

/// Width of the pad bitmasks in the GPIO registers.
const RegMask = u26;

pub const InputSignal = enum(u8) {
    spiq = 0,
    spid = 1,
    spihd = 2,
    spiwp = 3,

    u0rxd = 6,
    u0cts = 7,
    u0dsr = 8,
    u1rxd = 9,
    u1cts = 10,
    u1dsr = 11,

    i2s_mclk = 12,
    i2so_bck = 13,
    i2so_ws = 14,
    i2si_sd = 15,
    i2si_bck = 16,
    i2si_ws = 17,

    gpio_bt_priority = 18,
    gpio_bt_active = 19,

    cpu_gpio0 = 28,
    cpu_gpio1 = 29,
    cpu_gpio2 = 30,
    cpu_gpio3 = 31,
    cpu_gpio4 = 32,
    cpu_gpio5 = 33,
    cpu_gpio6 = 34,
    cpu_gpio7 = 35,

    ext_adc_start = 45,

    rmt_sig0 = 51,
    rmt_sig1 = 52,

    i2cext0_scl = 53,
    i2cext0_sda = 54,

    fspiclk = 63,
    fspiq = 64,
    fspid = 65,
    fspihd = 66,
    fspiwp = 67,
    fspics0 = 68,

    twai_rx = 74,

    sig_in_func_97 = 97,
    sig_in_func_98 = 98,
    sig_in_func_99 = 99,
    sig_in_func_100 = 100,

    pub const always_low: InputSignal = .cpu_gpio3;
    pub const always_high: InputSignal = .cpu_gpio2;
};

pub const OutputSignal = enum(u8) {
    spiq = 0,
    spid = 1,
    spihd = 2,
    spiwp = 3,
    spiclk = 4,
    spics0 = 5,

    u0txd = 6,
    u0rts = 7,
    u0dtr = 8,
    u1txd = 9,
    u1rts = 10,
    u1dtr = 11,

    i2s_mclk = 12,
    i2so_bck = 13,
    i2so_ws = 14,
    i2si_sd = 15,
    i2si_bck = 16,
    i2si_ws = 17,

    gpio_wlan_priority = 18,
    gpio_wlan_active = 19,

    cpu_gpio0 = 28,
    cpu_gpio1 = 29,
    cpu_gpio2 = 30,
    cpu_gpio3 = 31,
    cpu_gpio4 = 32,
    cpu_gpio5 = 33,
    cpu_gpio6 = 34,
    cpu_gpio7 = 35,

    usb_jtag_tck = 36,
    usb_jtag_tms = 37,
    usb_jtag_tdi = 38,
    usb_jtag_tdo = 39,

    ledc_ls_sig0 = 45,
    ledc_ls_sig1 = 46,
    ledc_ls_sig2 = 47,
    ledc_ls_sig3 = 48,
    ledc_ls_sig4 = 49,
    ledc_ls_sig5 = 50,

    rmt_sig0 = 51,
    rmt_sig1 = 52,

    i2cext0_scl = 53,
    i2cext0_sda = 54,

    fspiclk = 63,
    fspiq = 64,
    fspid = 65,
    fspihd = 66,
    fspiwp = 67,
    fspics0 = 68,
    fspics1 = 69,
    fspics2 = 70,
    fspics3 = 71,
    fspics4 = 72,
    fspics5 = 73,

    twai_tx = 74,
    twai_bus_off_on = 75,
    twai_clk = 76,

    ant_sel0 = 89,
    ant_sel1 = 90,
    ant_sel2 = 91,
    ant_sel3 = 92,
    ant_sel4 = 93,
    ant_sel5 = 94,
    ant_sel6 = 95,
    ant_sel7 = 96,

    sig_in_func_97 = 97,
    sig_in_func_98 = 98,
    sig_in_func_99 = 99,
    sig_in_func_100 = 100,

    clk_out1 = 123,
    clk_out2 = 124,
    clk_out3 = 125,

    spics1 = 126,

    usb_jtag_trst = 127,

    gpio = 128,
};

/// Get the appropriate register value of a drive strength for this pad.
/// See section 5.15.2 (IO MUX Registers) of the Technical Reference Manual
pub fn drive_strength_value(pin: u5, strength: enum { @"5mA", @"10mA", @"20mA", @"40mA" }) u2 {
    return switch (pin) {
        2, 3, 5, 18, 19 => switch (strength) {
            .@"5mA" => 0,
            .@"10mA" => 2,
            .@"20mA" => 1,
            .@"40mA" => 3,
        },
        else => switch (strength) {
            .@"5mA" => 0,
            .@"10mA" => 1,
            .@"20mA" => 2,
            .@"40mA" => 3,
        },
    };
}

/// Assert that the USB_SERIAL_JTAG peripheral, which uses pins GPIO18 and GPIO19, is disabled
/// and that the USB pullup/down resistors are disabled.
pub fn assert_usb_disabled(pin: u5) void {
    if (pin == 18 or pin == 19) {
        const usb_conf0 = peripherals.USB_DEVICE.CONF0.read();
        std.debug.assert(usb_conf0.USB_PAD_ENABLE == 0 and
            usb_conf0.DP_PULLUP == 0 and
            usb_conf0.DP_PULLDOWN == 0 and
            usb_conf0.DM_PULLUP == 0 and
            usb_conf0.DM_PULLDOWN == 0);
    }
}

pub fn set_mux(pin: u5, options: struct {
    pull_down: bool,
    pull_up: bool,
    drive_strength: u2,
    input_enable: bool,
    function: u3,
    input_filter_enable: bool,
}) void {
    IO_MUX.GPIO[pin].modify(.{
        .SLP_SEL = 0,
        .FUN_WPD = @intFromBool(options.pull_down),
        .FUN_WPU = @intFromBool(options.pull_up),
        .FUN_DRV = options.drive_strength,
        .FUN_IE = @intFromBool(options.input_enable),
        .MCU_SEL = options.function,
        .FILTER_EN = @intFromBool(options.input_filter_enable),
    });
}

pub fn set_pull(pin: u5, pull_down: bool, pull_up: bool) void {
    IO_MUX.GPIO[pin].modify(.{
        .FUN_WPD = @intFromBool(pull_down),
        .FUN_WPU = @intFromBool(pull_up),
    });
}

pub fn set_drive_strength(pin: u5, value: u2) void {
    IO_MUX.GPIO[pin].modify(.{ .FUN_DRV = value });
}

pub fn set_input_enabled(pin: u5, enable: bool) void {
    IO_MUX.GPIO[pin].modify(.{ .FUN_IE = @intFromBool(enable) });
}

pub fn get_input_enabled(pin: u5) bool {
    return IO_MUX.GPIO[pin].read().FUN_IE == 1;
}

pub fn set_input_filter_enabled(pin: u5, enable: bool) void {
    IO_MUX.GPIO[pin].modify(.{ .FILTER_EN = @intFromBool(enable) });
}

pub fn set_open_drain(pin: u5, open_drain: bool) void {
    GPIO.PIN[pin].modify(.{ .PIN_PAD_DRIVER = @intFromBool(open_drain) });
}

pub fn set_output_signal(pin: u5, options: struct {
    signal: u8,
    invert: bool = false,
    output_enable_signal_controlled_by_peripheral: bool = false,
    invert_output_enable_signal: bool = false,
}) void {
    GPIO.FUNC_OUT_SEL_CFG[pin].write(.{
        .OUT_SEL = options.signal,
        .OEN_SEL = @intFromBool(!options.output_enable_signal_controlled_by_peripheral),
        .INV_SEL = @intFromBool(options.invert),
        .OEN_INV_SEL = @intFromBool(options.invert_output_enable_signal),
    });
}

pub fn set_output_invert(pin: u5, invert: bool) void {
    GPIO.FUNC_OUT_SEL_CFG[pin].modify(.{ .INV_SEL = @intFromBool(invert) });
}

pub fn set_input_signal(signal: u8, pin: u5, invert: bool) void {
    GPIO.FUNC_IN_SEL_CFG[signal].write(.{
        .IN_SEL = pin,
        .IN_INV_SEL = @intFromBool(invert),
        .SEL = 1,
    });
}

pub fn set_input_signal_invert(signal: u8, invert: bool) void {
    GPIO.FUNC_IN_SEL_CFG[signal].modify(.{ .IN_INV_SEL = @intFromBool(invert) });
}

pub fn set_output_enabled(pin: u5, enable: bool) void {
    if (enable) {
        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(RegMask, 1) << pin });
    } else {
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(RegMask, 1) << pin });
    }
}

pub fn put(pin: u5, level: u1) void {
    switch (level) {
        0 => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(RegMask, 1) << pin }),
        1 => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(RegMask, 1) << pin }),
    }
}

pub fn read(pin: u5) u1 {
    return @intCast((GPIO.IN.raw >> pin) & 1);
}
