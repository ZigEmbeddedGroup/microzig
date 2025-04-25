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

// TODO: chip independent. currently specific to esp32c3.

pub fn num(n: u5) Pin {
    std.debug.assert(n < 22);
    return @as(Pin, @enumFromInt(n));
}

pub const Level = enum(u1) {
    low = 0,
    high = 1,
};

pub const DriveStrength = enum(u2) {
    @"5mA" = 0,
    @"10mA" = 1,
    @"20mA" = 2,
    @"40mA" = 3,
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
    i2cext0_scl = 53,
    i2cext0_sda = 54,
};

pub const OutputSignal = enum(u8) {
    // TODO: Other signals
    i2cext0_scl = 53,
    i2cext0_sda = 54,
    gpio = 128,
};

pub const Pin = enum(u5) {
    _,

    pub const Config = struct {
        input_enable: bool = false,
        output_enable: bool = false,
        open_drain: bool = false,
        pullup_enable: bool = false,
        pulldown_enable: bool = false,
        input_filter_enable: bool = false,
        output_invert: bool = false,
        drive_strength: DriveStrength = DriveStrength.@"5mA",
        output_signal: OutputSignal = .gpio,
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
            .OEN_SEL = @intFromBool(config.output_enable),
            .INV_SEL = @intFromBool(config.output_invert),
            .OEN_INV_SEL = 0,
            .padding = 0,
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
        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n, .padding = 0 });
    }

    pub fn reset(self: Pin) void {
        const n = @intFromEnum(self);
        IO_MUX.GPIO[n].write_raw(0x00);
        GPIO.FUNC_OUT_SEL_CFG[n].write_raw(0x00);
        GPIO.PIN[n].write_raw(0x00);
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n, .padding = 0 });
    }

    pub fn set_output_enable(self: Pin, enable: bool) void {
        // TODO: Some other implementations (only) set GPIO.ENABLE_W1TS?
        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].modify(.{ .OEN_SEL = @intFromBool(enable) });
    }

    pub fn set_input_enable(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        IO_MUX.GPIO[n].modify(.{ .FUN_IE = @intFromBool(enable) });
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
        const af: AlternateFunction = if (force_via_gpio_mux) .Function1 else .Function1;

        if (af == .Function1 and @intFromEnum(signal) >= 128) {
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
        const af: AlternateFunction = if (force_via_gpio_mux) .Function1 else .Function1;

        if (af == .Function1 and @intFromEnum(signal) > 128) {
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
        GPIO.PIN[@intFromEnum(self)].modify(.{ .PIN_PAD_DRIVER = @intFromBool(enable) });
    }

    pub fn set_pullup(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            // TODO: Was this a bug? Only setting it for sleep mode?
            .FUN_WPU = @intFromBool(enable),
            .MCU_WPU = @intFromBool(enable),
        });
    }

    pub fn set_pulldown(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            // TODO: Was this a bug? Only setting it for sleep mode?
            .FUN_WPD = @intFromBool(enable),
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
            .FUN_DRV = @intFromEnum(strength),
        });
    }

    pub fn set_input_filter(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FILTER_EN = @intFromBool(enable),
        });
    }

    // Configure the pin as an output GPIO with open drain enabled
    pub fn set_to_open_drain_output(self: Pin, enable: bool) void {
        const n = @intFromEnum(self);
        // Disable input & pull up/down resistors
        IO_MUX.GPIO[n].modify(.{
            .MCU_SEL = @intFromEnum(AlternateFunction.Function1),
            .FUN_IE = false,
            .FUN_WPU = false,
            .FUN_WPD = false,
            .FUN_DRV = @intFromEnum(DriveStrength.@"20mA"),
            .SLP_SEL = false,
        });

        // Enable open drain
        self.enable_open_drain(enable);

        // Configure as GPIO
        GPIO.FUNC_OUT_SEL_CFG[n].modify(.{
            .OUT_SEL = @intFromEnum(OutputSignal.GPIO),
        });

        // Enable output
        GPIO.ENABLE_W1TS.write(.{
            .bits = @as(u32, 1) << (n % 32),
        });
    }

    pub fn enable_open_drain(self: Pin, enable: bool) void {
        GPIO.PIN[@enumFromInt(self)].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(enable),
        });
    }

    pub fn write(self: Pin, level: Level) void {
        const n = @intFromEnum(self);
        // Assert that the pin is set to output enabled
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[n].read().OEN_SEL == 1);

        switch (level) {
            Level.low => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(u26, 1) << n }),
            Level.high => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(u26, 1) << n }),
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
            Level.low => self.write(Level.high),
            Level.high => self.write(Level.low),
        }
    }

    pub fn set_drive_strength(self: Pin, drive_strength: DriveStrength) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{ .FUN_DRV = @intFromEnum(drive_strength) });
    }
};
