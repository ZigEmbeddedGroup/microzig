const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const IO_MUX = peripherals.IO_MUX;
const GPIO = peripherals.GPIO;

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
        input_enable: bool,
        output_enable: bool,
        open_drain: bool,
        pullup_enable: bool,
        pulldown_enable: bool,
        input_filter_enable: bool,
        output_invert: bool,
        drive_strength: DriveStrength,
    };

    pub const default_config = Config{
        .input_enable = false,
        .output_enable = false,
        .open_drain = false,
        .pullup_enable = false,
        .pulldown_enable = false,
        .input_filter_enable = false,
        .output_invert = false,
        .drive_strength = DriveStrength.@"5mA",
    };

    pub fn init(number: u5, config: Config) Pin {
        std.debug.assert(number < 21);

        IO_MUX.GPIO[number].modify(.{
            .SLP_SEL = 0,
            .FUN_WPD = @intFromBool(config.pulldown_enable),
            .FUN_WPU = @intFromBool(config.pullup_enable),
            .FUN_DRV = @intFromEnum(config.drive_strength),
            .FILTER_EN = @intFromBool(config.input_filter_enable),
            .FUN_IE = @intFromBool(config.input_enable),
            .MCU_SEL = 1,
        });

        GPIO.FUNC_OUT_SEL_CFG[number].write(.{
            .OUT_SEL = 0x80,
            .OEN_SEL = @intFromBool(config.output_enable),
            .INV_SEL = @intFromBool(config.output_invert),
            .OEN_INV_SEL = 0,
            .padding = 0,
        });

        GPIO.PIN[number].modify(.{
            .PIN_PAD_DRIVER = @intFromBool(config.open_drain),
        });

        GPIO.ENABLE_W1TS.write(.{ .ENABLE_W1TS = @as(u17, 1) << number, .padding = 0 });

        return Pin{
            .number = number,
        };
    }

    pub fn deinit(self: Pin) void {
        IO_MUX.GPIO[self.number].write_raw(0x00);
        GPIO.FUNC_OUT_SEL_CFG[self.number].write_raw(0x00);
        GPIO.PIN[self.number].write_raw(0x00);
        GPIO.ENABLE_W1TC.write(.{ .ENABLE_W1TC = @as(u17, 1) << self.number, .padding = 0 });
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
        std.debug.assert(GPIO.FUNC_OUT_SEL_CFG[self.number].read().OEN_SEL == 1);

        switch (level) {
            Level.low => GPIO.OUT_W1TC.write(.{ .OUT_W1TC = @as(u17, 1) << self.number, .padding = 0 }),
            Level.high => GPIO.OUT_W1TS.write(.{ .OUT_W1TS = @as(u17, 1) << self.number, .padding = 0 }),
        }
    }

    pub fn read(self: Pin) Level {
        std.debug.assert(IO_MUX.GPIO[self.number].FUN_IE == 1);

        return @enumFromInt(GPIO.IN.raw >> self.number & 0x01);
    }

    pub fn toggle(self: Pin) void {
        if ((GPIO.OUT.raw >> self.number & 0x01) == 0) {
            write(self, Level.high);
        } else {
            write(self, Level.low);
        }
    }
};
