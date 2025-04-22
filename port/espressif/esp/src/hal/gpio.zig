const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const IO_MUX = peripherals.IO_MUX;
const GPIO = peripherals.GPIO;

// TODO: chip independent. currently specific to esp32c3.

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

pub fn num(n: u5) Pin {
    std.debug.assert(n < 22);
    return @as(Pin, @enumFromInt(n));
}

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
        });

        GPIO.PIN[n].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(config.open_drain),
        });

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

        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << n });
    }

    pub fn reset(self: Pin) void {
        const n = @intFromEnum(self);
        IO_MUX.GPIO[n].write_raw(0x00);
        GPIO.FUNC_OUT_SEL_CFG[n].write_raw(0x00);
        GPIO.PIN[n].write_raw(0x00);
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << n });
    }

    pub fn set_output_enable(self: Pin, enable: bool) void {
        GPIO.FUNC_OUT_SEL_CFG[@intFromEnum(self)].modify(.{
            .OEN_SEL = @intFromBool(enable),
        });
    }

    pub fn set_open_drain(self: Pin, enable: bool) void {
        GPIO.PIN[@intFromEnum(self)].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(enable),
        });
    }

    pub fn set_pullup(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .MCU_WPU = @intFromBool(enable),
        });
    }

    pub fn set_pulldown(self: Pin, enable: bool) void {
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
            .FUN_DRV = @intFromEnum(strength),
        });
    }

    pub fn set_input_filter(self: Pin, enable: bool) void {
        IO_MUX.GPIO[@intFromEnum(self)].modify(.{
            .FILTER_EN = @intFromBool(enable),
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

        return @enumFromInt((GPIO.OUT.raw >> @intFromEnum(self) & 0x01));
    }

    pub fn read(self: Pin) Level {
        std.debug.assert(IO_MUX.GPIO[@intFromEnum(self)].read().FUN_IE == 1);

        return @enumFromInt(GPIO.IN.raw >> @intFromEnum(self) & 0x01);
    }

    pub fn toggle(self: Pin) void {
        switch (self.get_output_state()) {
            Level.low => self.write(Level.high),
            Level.high => self.write(Level.low),
        }
    }
};

pub const OutputSignal = enum(u8) {
    ledc_ls_sig_out0 = 45,
    gpio = 128,
};
