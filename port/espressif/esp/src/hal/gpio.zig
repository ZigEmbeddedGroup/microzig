//! GPIO and pin configuration
//!
//! The ESP32c3's GPIO matrix and IO mux allows input from any pin to be routed to any peripheral,
//! and any peripheral output to be routed to any pin.
//!
//! See section 5 of the Technical Reference Manual
//! https://www.espressif.com/sites/default/files/documentation/esp32-c3_technical_reference_manual_en.pdf
//!
const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const IO_MUX = peripherals.IO_MUX;
const GPIO = peripherals.GPIO;

pub const DriveStrength = enum {
    @"5mA",
    @"10mA",
    @"20mA",
    @"40mA",

    /// Get the appropriate value of DriveStrength based on the pin number.
    /// See section 5.15.2 (IO MUX Registers) of the Technical Reference Manual
    fn to_value(strength: DriveStrength, pin: Pin) u2 {
        return switch (@intFromEnum(pin)) {
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
};

/// Alternative pin functions
pub const AlternateFunction = enum(u2) {
    function0 = 0,
    function1 = 1,
    function2 = 2,
    function3 = 3,
};

/// Interrupt events
pub const Event = enum(u3) {
    rising_edge = 1,
    falling_edge = 2,
    any_edge = 3,
    low_level = 4,
    high_level = 5,
};

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

pub const Pull = enum {
    up,
    down,
    disabled,
};

pub const Mask = enum(u22) {
    _,
};

pub fn num(n: u5) Pin {
    std.debug.assert(n < 22);
    return @as(Pin, @enumFromInt(n));
}

pub const Pin = enum(u5) {
    _,

    pub const Config = struct {
        output_enable: bool = false,
        input_enable: bool = false,
        open_drain: bool = false,
        pull: Pull = .disabled,
        drive_strength: DriveStrength = .@"5mA",
        input_filter_enable: bool = false,

        pub const analog: Config = .{
            .output_enable = false,
            .input_enable = false,
            .pull = .disabled,
        };
    };

    fn assert_usb_disabled(self: Pin) void {
        const n = @intFromEnum(self);

        // NOTE: Assert that the USB_SERIAL_JTAG peripheral which uses pins GPIO18 and GPIO19
        //       is disabled and USB pullup/down resistors are disabled.
        if (n == 18 or n == 19) {
            const usb_conf0 = peripherals.USB_DEVICE.CONF0.read();
            std.debug.assert(usb_conf0.USB_PAD_ENABLE == 0 and
                usb_conf0.DP_PULLUP == 0 and
                usb_conf0.DP_PULLDOWN == 0 and
                usb_conf0.DM_PULLUP == 0 and
                usb_conf0.DM_PULLDOWN == 0);
        }
    }

    pub fn apply(self: Pin, config: Config) void {
        self.assert_usb_disabled();

        const n = @intFromEnum(self);

        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].modify(.{
            .OUT_SEL = @intFromEnum(OutputSignal.gpio),
        });

        IO_MUX.GPIO[n].modify(.{
            .SLP_SEL = 0,
            .FUN_WPD = @intFromBool(config.pull == .down),
            .FUN_WPU = @intFromBool(config.pull == .up),
            .FUN_DRV = @intFromEnum(config.drive_strength),
            .FUN_IE = @intFromBool(config.input_enable),
            .MCU_SEL = @intFromEnum(AlternateFunction.function1),
            .FILTER_EN = @intFromBool(config.input_filter_enable),
        });

        GPIO.PIN[n].modify(.{ .PIN_PAD_DRIVER = @intFromBool(config.open_drain) });

        if (config.output_enable) {
            GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
        } else {
            GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });
        }
    }

    pub const ConnectToOutputOptions = struct {
        signal: OutputSignal,
        invert: bool = false,
        output_enable_signal_controlled_by_peripheral: bool = false,
        invert_output_enable_signal: bool = false,
    };

    // TODO: bypass gpio matrix
    pub fn connect_peripheral_to_output(self: Pin, options: ConnectToOutputOptions) void {
        self.assert_usb_disabled();

        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].write(.{
            .OUT_SEL = @intFromEnum(options.signal),
            .OEN_SEL = @intFromBool(!options.output_enable_signal_controlled_by_peripheral),
            .INV_SEL = @intFromBool(options.invert),
            .OEN_INV_SEL = @intFromBool(options.invert_output_enable_signal),
        });
    }

    pub const ConnectToInputOptions = struct {
        signal: InputSignal,
        invert: bool = false,
    };

    // TODO: bypass gpio matrix
    pub fn connect_input_to_peripheral(self: Pin, options: ConnectToInputOptions) void {
        self.assert_usb_disabled();

        GPIO.FUNC_IN_SEL_CFG[@intFromEnum(options.signal)].write(.{
            .IN_SEL = @intFromEnum(self),
            .IN_INV_SEL = @intFromBool(options.invert),
            .SEL = 1,
        });
    }

    pub fn set_output_enabled(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        if (enable) {
            GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
        } else {
            GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });
        }
    }

    pub fn set_output_invert(self: Pin, invert: bool) void {
        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].write(.{
            .INV_SEL = @intFromBool(invert),
        });
    }

    pub fn set_input_enabled(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_IE = @intFromBool(enable),
        });
    }

    pub fn set_input_invert(self: Pin, invert: bool) void {
        GPIO.FUNC_IN_SEL_CFG[@intFromEnum(self)].write(.{
            .IN_INV_SEL = @intFromBool(invert),
        });
    }

    pub fn set_input_filter_enabled(self: Pin, enable: bool) void {
        GPIO.FUNC_IN_SEL_CFG[@intFromEnum(self)].write(.{
            .FILTER_EN = @intFromBool(enable),
        });
    }

    pub fn set_pull(self: Pin, pull: Pull) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_WPD = @intFromBool(pull == .down),
            .FUN_WPU = @intFromBool(pull == .up),
        });
    }

    pub fn set_drive_strength(self: Pin, drive_strength: DriveStrength) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_DRV = @intFromEnum(drive_strength),
        });
    }

    pub fn set_open_drain(self: Pin, open_drain: bool) void {
        GPIO.PIN[@intFromEnum(self)].modify(.{ .PIN_PAD_DRIVER = @intFromBool(open_drain) });
    }

    pub fn put(self: Pin, level: u1) void {
        const n = @intFromEnum(self);
        switch (level) {
            0 => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(u26, 1) << n }),
            1 => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(u26, 1) << n }),
        }
    }

    pub fn read(self: Pin) u1 {
        std.debug.assert(IO_MUX.GPIO[@intFromEnum(self)].read().FUN_IE == 1);

        return @intCast((GPIO.IN.raw >> @intFromEnum(self)) & 1);
    }

    pub fn toggle(self: Pin) void {
        switch (self.read()) {
            0 => self.put(1),
            1 => self.put(0),
        }
    }
};
