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

pub fn num(n: u5) Pin {
    std.debug.assert(n < 22);
    return @as(Pin, @enumFromInt(n));
}

pub const Level = enum(u1) {
    low = 0,
    high = 1,
};

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

    fn direct_output_via_io_mux(signal: OutputSignal) bool {
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

pub const Pin = enum(u5) {
    _,

    pub const Config = struct {
        output_signal: OutputSignal = .gpio,
        output_invert: bool = false,

        input_enable: bool = false,
        input_invert: bool = false,
        input_filter_enable: bool = false,

        open_drain: bool = false,
        pullup_enable: bool = false,
        pulldown_enable: bool = false,
        drive_strength: DriveStrength = .@"5mA",
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
            .MCU_SEL = 1,
        });

        GPIO.FUNC_OUT_SEL_CFG[n].write(.{
            .OUT_SEL = @intFromEnum(config.output_signal),
            .OEN_SEL = @intFromBool(config.output_signal.has_output_enable_signal()),
            .INV_SEL = @intFromBool(config.output_invert),
            .OEN_INV_SEL = 0,
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
        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
    }

    pub fn reset(self: Pin) void {
        const n = @intFromEnum(self);
        IO_MUX.GPIO[n].write_raw(0x00);
        GPIO.FUNC_OUT_SEL_CFG[n].write_raw(0x00);
        GPIO.PIN[n].write_raw(0x00);
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });
    }

    // pub fn set_output_enable(self: Pin, enable: bool) void {
    //     // TODO: Some other implementations (only) set GPIO.ENABLE_W1TS?
    //     GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].modify(.{ .OEN_SEL = @intFromBool(enable) });
    // }

    pub fn set_input_enable(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{ .FUN_IE = @intFromBool(enable) });
    }

    /// Connect input to peripheral.
    pub fn connect_input_to_peripheral(self: Pin, signal: InputSignal) void {
        self.connect_input_to_peripheral_with_options(signal, false, false);
    }

    /// Connect input to peripheral. `invert` inverts the input signal and `force_via_gpio_mux`
    /// forces the signal to be routed through the gpio mux, even if it could be routed directly
    /// through the io mux.
    fn connect_input_to_peripheral_with_options(
        self: Pin,
        signal: InputSignal,
        invert: bool,
        force_via_gpio_mux: bool,
    ) void {
        // TODO: In else case, match function to alt function?
        const af: AlternateFunction = if (force_via_gpio_mux) .function1 else .function1;

        if (af == .function1 and @intFromEnum(signal) >= 128) {
            @panic("Cannot connect GPIO to this peripheral");
        }

        self.set_alternate_function(af);

        if (@intFromEnum(signal) < 128) {
            GPIO.FUNC_IN_SEL_CFG[@intFromEnum(signal)].write(.{
                .SEL = 1,
                .IN_INV_SEL = @intFromBool(invert),
                .IN_SEL = @intFromEnum(self),
            });
        }
    }

    pub fn connect_peripheral_to_output(self: Pin, signal: OutputSignal) void {
        self.connect_peripheral_to_output_with_options(signal, false, false, false, false);
    }

    /// Connect peripheral to output. `invert` inverts the output signal
    pub fn connect_peripheral_to_output_with_options(
        self: Pin,
        signal: OutputSignal,
        invert: bool,
        invert_enable: bool,
        enable_from_gpio: bool,
        force_via_gpio_mux: bool,
    ) void {
        // TODO: In else case, match function to alt function?
        const af: AlternateFunction = if (force_via_gpio_mux) .function1 else .function1;

        if (af == .function1 and @intFromEnum(signal) > 128) {
            @panic("Cannot connect this peripheral to GPIO");
        }

        self.set_alternate_function(af);

        const clamped_signal: u8 = if (@intFromEnum(signal) <= 128)
            @intFromEnum(signal)
        else
            128;

        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].write(.{
            .OUT_SEL = clamped_signal,
            .INV_SEL = @intFromBool(invert),
            .OEN_SEL = @intFromBool(enable_from_gpio),
            .OEN_INV_SEL = @intFromBool(invert_enable),
        });
    }

    pub fn set_alternate_function(self: Pin, alternate: AlternateFunction) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{ .MCU_SEL = @intFromEnum(alternate) });
    }

    pub fn set_open_drain(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        // Set open-drain
        GPIO.PIN[n].modify(.{ .PIN_PAD_DRIVER = @intFromBool(enable) });

        GPIO.FUNC_OUT_SEL_CFG[n].modify(.{
            .OUT_SEL = @intFromEnum(OutputSignal.gpio),
        });

        // Disable inputs, pullup/down, and sleep mode
        IO_MUX.GPIO[n].modify(.{
            .FUN_IE = 0,
            .FUN_WPD = 0,
            .FUN_WPU = 0,
            .FUN_DRV = DriveStrength.to_value(.@"20mA", self),
            .SLP_SEL = 0,
        });
    }

    pub fn set_pullup(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_WPU = @intFromBool(enable),
        });
    }

    pub fn set_pullup_sleep(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .MCU_WPU = @intFromBool(enable),
        });
    }

    pub fn set_pulldown(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_WPD = @intFromBool(enable),
        });
    }

    pub fn set_pulldown_sleep(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .MCU_WPD = @intFromBool(enable),
        });
    }

    pub fn set_output_invert(self: Pin, enable: bool) void {
        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].modify(.{
            .OEN_INV_SEL = enable,
        });
    }

    pub fn set_output_drive_strength(self: Pin, strength: DriveStrength) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FUN_DRV = strength.to_value(self),
        });
    }

    pub fn set_input_filter(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FILTER_EN = @intFromBool(enable),
        });
    }

    // Configure the pin as an output GPIO with open drain enabled
    pub fn set_open_drain_output(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        // Disable input & pull up/down resistors
        IO_MUX.GPIO[n].modify(.{
            .MCU_SEL = @intFromEnum(AlternateFunction.function1),
            .FUN_IE = 0,
            .FUN_WPU = 0,
            .FUN_WPD = 0,
            .FUN_DRV = @intFromEnum(DriveStrength.@"20mA"),
            .SLP_SEL = 0,
        });

        // Enable open drain
        self.enable_open_drain(enable);

        // Configure as GPIO
        GPIO.FUNC_OUT_SEL_CFG[n].modify(.{
            .OUT_SEL = @intFromEnum(OutputSignal.gpio),
        });

        // Enable output
        GPIO.ENABLE_W1TS.write_raw(@as(u32, 1) << n);
    }

    pub fn enable_open_drain(self: Pin, enable: bool) void {
        GPIO.PIN[@intFromEnum(self)].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(enable),
        });
    }

    pub fn write(self: Pin, level: Level) void {
        const n = @intFromEnum(self);
        // Assert that the pin is set to output enabled
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[n].read().OEN_SEL == 1);

        switch (level) {
            .low => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(u26, 1) << n }),
            .high => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(u26, 1) << n }),
        }
    }

    pub fn get_output_state(self: Pin) Level {
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].read().OEN_SEL == 1);

        return @enumFromInt(GPIO.OUT.raw >> @intFromEnum(self) & 1);
    }

    pub fn read(self: Pin) Level {
        std.debug.assert(IO_MUX.GPIO[@intFromEnum(self)].read().FUN_IE == 1);

        return @enumFromInt(GPIO.IN.raw >> @intFromEnum(self) & 1);
    }

    pub fn toggle(self: Pin) void {
        switch (self.get_output_state()) {
            .low => self.write(.high),
            .high => self.write(.low),
        }
    }

    pub fn set_drive_strength(self: Pin, strength: DriveStrength) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{ .FUN_DRV = strength.to_value(self) });
    }
};
