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

pub const Pin = struct {
    number: u5,

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
        IO_MUX.GPIO[self.number].modify(.{
            .SLP_SEL = 0,
            .FUN_WPD = @intFromBool(config.pulldown_enable),
            .FUN_WPU = @intFromBool(config.pullup_enable),
            .FUN_DRV = @intFromEnum(config.drive_strength),
            .FILTER_EN = @intFromBool(config.input_filter_enable),
            .FUN_IE = @intFromBool(config.input_enable),
            .MCU_SEL = 1,
        });

        GPIO.FUNC_OUT_SEL_CFG[self.number].write(.{
            .OUT_SEL = @intFromEnum(config.output_signal),
            .OEN_SEL = @intFromBool(config.output_enable),
            .INV_SEL = @intFromBool(config.output_invert),
            .OEN_INV_SEL = 0,
            .padding = 0,
        });

        GPIO.PIN[self.number].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(config.open_drain),
        });

        // NOTE: Assert that the USB_SERIAL_JTAG peripheral which uses pins GPIO18 and GPIO19
        //       is disabled and USB pullup/down resistors are disabled.
        if (self.number == 18 or self.number == 19) {
            const usb_conf0 = peripherals.USB_DEVICE.CONF0.read();
            std.debug.assert(usb_conf0.USB_PAD_ENABLE == 0 and
                usb_conf0.DP_PULLUP == 0 and
                usb_conf0.DP_PULLDOWN == 0 and
                usb_conf0.DM_PULLUP == 0 and
                usb_conf0.DM_PULLDOWN == 0);
        }

        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u26, 1) << self.number, .padding = 0 });
    }

    pub fn reset(self: Pin) void {
        IO_MUX.GPIO[self.number].write_raw(0x00);
        GPIO.FUNC_OUT_SEL_CFG[self.number].write_raw(0x00);
        GPIO.PIN[self.number].write_raw(0x00);
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u26, 1) << self.number, .padding = 0 });
    }

    pub fn set_output_enable(self: Pin, enable: bool) void {
        GPIO.FUNC_OUT_SEL_CFG[self.number].modify(.{
            .OEN_SEL = @intFromBool(enable),
        });
    }

    pub fn set_open_drain(self: Pin, enable: bool) void {
        GPIO.PIN[self.number].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(enable),
        });
    }

    pub fn set_pullup(self: Pin, enable: bool) void {
        IO_MUX.GPIO[self.number].modify(.{
            .MCU_WPU = @intFromBool(enable),
        });
    }

    pub fn set_pulldown(self: Pin, enable: bool) void {
        IO_MUX.GPIO[self.number].modify(.{
            .MCU_WPD = @intFromBool(enable),
        });
    }

    pub fn set_output_invert(self: Pin, enable: bool) void {
        GPIO.FUNC_OUT_SEL_CFG[self.number].modify(.{
            .OEN_INV_SEL = enable,
        });
    }

    pub fn set_output_drive_strength(self: Pin, strength: DriveStrength) void {
        IO_MUX.GPIO[self.number].modify(.{
            .FUN_DRV = @intFromEnum(strength),
        });
    }

    pub fn set_input_filter(self: Pin, enable: bool) void {
        IO_MUX.GPIO[self.number].modify(.{
            .FILTER_EN = @intFromBool(enable),
        });
    }

    pub fn write(self: Pin, level: Level) void {
        // Assert that the pin is set to output enabled
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[self.number].read().OEN_SEL == 1);

        switch (level) {
            Level.low => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(u26, 1) << self.number }),
            Level.high => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(u26, 1) << self.number }),
        }
    }

    pub fn get_output_state(self: Pin) Level {
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[self.number].read().OEN_SEL == 1);

        return @enumFromInt((GPIO.OUT.raw >> self.number & 0x01));
    }

    pub fn read(self: Pin) Level {
        std.debug.assert(IO_MUX.GPIO[self.number].read().FUN_IE == 1);

        return @enumFromInt(GPIO.IN.raw >> self.number & 0x01);
    }

    pub fn toggle(self: Pin) void {
        switch (get_output_state(self)) {
            Level.low => write(self, Level.high),
            Level.high => write(self, Level.low),
        }
    }
};

pub const OutputSignal = enum(u8) {
    ledc_ls_sig_out0 = 45,
    gpio = 128,
};

pub const instance = struct {
    pub const GPIO0: Pin = .{ .number = 0 };
    pub const GPIO1: Pin = .{ .number = 1 };
    pub const GPIO2: Pin = .{ .number = 2 };
    pub const GPIO3: Pin = .{ .number = 3 };
    pub const GPIO4: Pin = .{ .number = 4 };
    pub const GPIO5: Pin = .{ .number = 5 };
    pub const GPIO6: Pin = .{ .number = 6 };
    pub const GPIO7: Pin = .{ .number = 7 };
    pub const GPIO8: Pin = .{ .number = 8 };
    pub const GPIO9: Pin = .{ .number = 9 };
    pub const GPIO10: Pin = .{ .number = 10 };
    pub const GPIO11: Pin = .{ .number = 11 };
    pub const GPIO12: Pin = .{ .number = 12 };
    pub const GPIO13: Pin = .{ .number = 13 };
    pub const GPIO14: Pin = .{ .number = 14 };
    pub const GPIO15: Pin = .{ .number = 15 };
    pub const GPIO16: Pin = .{ .number = 16 };
    pub const GPIO17: Pin = .{ .number = 17 };
    pub const GPIO18: Pin = .{ .number = 18 };
    pub const GPIO19: Pin = .{ .number = 19 };
    pub const GPIO20: Pin = .{ .number = 20 };
    pub const GPIO21: Pin = .{ .number = 21 };

    pub fn num(instance_number: u5) Pin {
        std.debug.assert(instance_number < 22);
        return .{ .number = instance_number };
    }
};
