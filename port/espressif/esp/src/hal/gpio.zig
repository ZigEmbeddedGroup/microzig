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
    // TODO: Other signals
    rmt0 = 51,
    rmt1 = 52,

    fspiclk = 63,
    fspiq = 64,
    fspid = 65,
    fspihd = 66,
    fspiwp = 67,
    fspics0 = 68,

    i2cext0_scl = 53,
    i2cext0_sda = 54,
};

pub const OutputSignal = enum(u8) {
    // TODO: Other signals
    ledc_ls_sig_out0 = 45,
    ledc_ls_sig_out1 = 46,
    ledc_ls_sig_out2 = 47,
    ledc_ls_sig_out3 = 48,
    ledc_ls_sig_out4 = 49,
    ledc_ls_sig_out5 = 50,

    rmt0 = 51,
    rmt1 = 52,

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

    gpio = 128,

    fn has_output_enable_signal(signal: OutputSignal) bool {
        return switch (signal) {
            .fspiclk,
            .fspiq,
            .fspid,
            .fspihd,
            .fspiwp,
            .fspics0,
            .fspics1,
            .fspics2,
            .fspics3,
            .fspics4,
            .fspics5,
            => true,
            else => false,
        };
    }
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

    pub fn init(self: Pin) void {
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

        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });

        IO_MUX.GPIO[n].write(.{
            .SLP_SEL = 0,
            .FUN_IE = 0,
            .MCU_SEL = 1,
        });

        GPIO.FUNC_OUT_SEL_CFG[n].write(.{
            .OUT_SEL = @intFromEnum(OutputSignal.gpio),
        });

        GPIO.PIN[n].modify(.{ .PIN_PAD_DRIVER = 0 });
    }

    pub const Config = struct {
        // TODO: sleep mode

        output_enable: bool = false,
        use_output_enable_signal: bool = false,
        output_signal: OutputSignal = .gpio,
        output_invert: bool = false,

        input_enable: bool = false,
        input_signal: InputSignal = .gpio,
        input_invert: bool = false,
        input_filter_enable: bool = false,

        open_drain: bool = false,
        pullup_enable: bool = false,
        pulldown_enable: bool = false,
        drive_strength: DriveStrength = .@"5mA",

        alternate_function: AlternateFunction = .function1,
        input_bypass_gpio_matrix: bool = false,

        pub const simple_gpio_input_output: Config = .{
            .output_enable = true,
            .input_enable = true,
        };

        pub fn connect_peripheral(input_signal: ?InputSignal, output_signal: ?OutputSignal) Config {
            return .{
                .input_enable = input_signal != null,
                .output_enable = output_signal != null,
                .input_signal = input_signal orelse .gpio,
                .output_signal = output_signal orelse .gpio,
            };
        }

        pub fn direct_input_and_output_via_io_mux(alternate_function: AlternateFunction) Config {
            return .{
                .alternate_function = alternate_function,
                .input_bypass_gpio_matrix = true,
            };
        }
    };

    pub fn apply(self: Pin, config: Config) void {
        const n = @intFromEnum(self);
        IO_MUX.GPIO[n].modify(.{
            .SLP_SEL = 0,
            .FUN_WPD = @intFromBool(config.pulldown_enable),
            .FUN_WPU = @intFromBool(config.pullup_enable),
            .FUN_DRV = @intFromEnum(config.drive_strength),
            .FILTER_EN = @intFromBool(config.input_filter_enable),
            .FUN_IE = @intFromBool(config.input_enable),
            .MCU_SEL = @intFromEnum(config.alternate_function),
        });

        GPIO.FUNC_OUT_SEL_CFG[n].write(.{
            .OUT_SEL = @intFromEnum(config.output_signal),
            .OEN_SEL = @intFromBool(!config.use_output_enable_signal),
            .INV_SEL = @intFromBool(config.output_invert),
            .OEN_INV_SEL = 0,
        });

        GPIO.FUNC_IN_SEL_CFG[n].write(.{
            .IN_SEL = @intFromEnum(config.input_signal),
            .IN_INV_SEL = @intFromBool(config.input_invert),
            .SEL = @intFromBool(!config.input_bypass_gpio_matrix),
        });

        GPIO.PIN[n].modify(.{ .PIN_PAD_DRIVER = @intFromBool(config.open_drain) });

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

        // Enable output
        if (config.output_enable) {
            GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
        } else {
            GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });
        }
    }

    pub fn set_output_enabled(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        if (enable) {
            GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
            GPIO.FUNC_OUT_SEL_CFG[n].write(.{
                .OEN_SEL = @intFromBool(enable),
            });
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

    pub fn write(self: Pin, level: u1) void {
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
        switch (self.get_output_state()) {
            0 => self.write(1),
            1 => self.write(0),
        }
    }
};
