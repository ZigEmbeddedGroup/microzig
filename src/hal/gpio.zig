const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PADS_BANK0 = peripherals.PADS_BANK0;
const IO_BANK0 = peripherals.IO_BANK0;

const resets = @import("resets.zig");

const log = std.log.scoped(.gpio);

pub const Function = enum(u5) {
    xip = 0,
    spi,
    uart,
    i2c,
    pwm,
    sio,
    pio0,
    pio1,
    gpck,
    usb,
    null = 0x1f,
};

pub const Direction = enum(u1) {
    in,
    out,
};

pub const IrqLevel = enum(u2) {
    low,
    high,
    fall,
    rise,
};

pub const IrqCallback = fn (gpio: u32, events: u32) callconv(.C) void;

pub const Override = enum {
    normal,
    invert,
    low,
    high,
};

pub const SlewRate = enum {
    slow,
    fast,
};

pub const DriveStrength = enum {
    @"2mA",
    @"4mA",
    @"8mA",
    @"12mA",
};

pub const Enabled = enum {
    disabled,
    enabled,
};

pub const PullUpDown = enum {
    up,
    down,
};

pub fn num(n: u5) Pin {
    if (n > 29)
        @panic("the RP2040 only has GPIO 0-29");

    return @intToEnum(Pin, n);
}

pub fn mask(m: u32) Mask {
    _ = m;
    @panic("TODO");
}

pub const Mask = enum(u30) {
    _,
};

pub const Pin = enum(u5) {
    _,

    pub const Regs = struct {
        status: @TypeOf(IO_BANK0.GPIO0_STATUS),
        ctrl: microzig.mmio.Mmio(packed struct(u32) {
            FUNCSEL: packed union {
                raw: u5,
                value: Function,
            },
            reserved8: u3,
            OUTOVER: packed union {
                raw: u2,
                value: Override,
            },
            reserved12: u2,
            OEOVER: packed union {
                raw: u2,
                value: Override,
            },
            reserved16: u2,
            INOVER: packed union {
                raw: u2,
                value: Override,
            },
            reserved28: u10,
            IRQOVER: packed union {
                raw: u2,
                value: Override,
            },
            padding: u2,
        }),
    };

    pub const PadsReg = @TypeOf(PADS_BANK0.GPIO0);

    fn get_regs(gpio: Pin) *volatile Regs {
        const regs = @ptrCast(*volatile [30]Regs, &IO_BANK0.GPIO0_STATUS);
        return &regs[@enumToInt(gpio)];
    }

    fn get_pads_reg(gpio: Pin) *volatile PadsReg {
        const regs = @ptrCast(*volatile [30]PadsReg, &PADS_BANK0.GPIO0);
        return &regs[@enumToInt(gpio)];
    }

    pub fn mask(gpio: Pin) u32 {
        return @as(u32, 1) << @enumToInt(gpio);
    }

    pub inline fn set_pull(gpio: Pin, mode: ?PullUpDown) void {
        const pads_reg = gpio.get_pads_reg();

        if (mode == null) {
            pads_reg.modify(.{ .PUE = 0, .PDE = 0 });
        } else switch (mode.?) {
            .up => pads_reg.modify(.{ .PUE = 1, .PDE = 0 }),
            .down => pads_reg.modify(.{ .PUE = 0, .PDE = 1 }),
        }
    }

    pub inline fn set_direction(gpio: Pin, direction: Direction) void {
        switch (direction) {
            .in => SIO.GPIO_OE_CLR.raw = gpio.mask(),
            .out => SIO.GPIO_OE_SET.raw = gpio.mask(),
        }
    }

    /// Drive a single GPIO high/low
    pub inline fn put(gpio: Pin, value: u1) void {
        switch (value) {
            0 => SIO.GPIO_OUT_CLR.raw = gpio.mask(),
            1 => SIO.GPIO_OUT_SET.raw = gpio.mask(),
        }
    }

    pub inline fn toggle(gpio: Pin) void {
        SIO.GPIO_OUT_XOR.raw = gpio.mask();
    }

    pub inline fn read(gpio: Pin) u1 {
        return if ((SIO.GPIO_IN.raw & gpio.mask()) != 0)
            1
        else
            0;
    }

    pub inline fn set_function(gpio: Pin, function: Function) void {
        const pads_reg = gpio.get_pads_reg();
        pads_reg.modify(.{
            .IE = 1,
            .OD = 0,
        });

        const regs = gpio.get_regs();
        regs.ctrl.modify(.{
            .FUNCSEL = .{ .value = function },
            .OUTOVER = .{ .value = .normal },
            .INOVER = .{ .value = .normal },
            .IRQOVER = .{ .value = .normal },
            .OEOVER = .{ .value = .normal },

            .reserved8 = 0,
            .reserved12 = 0,
            .reserved16 = 0,
            .reserved28 = 0,
            .padding = 0,
        });
    }

    //pub fn set_drive_strength(gpio: Gpio, drive: DriveStrength) void {
    //    _ = drive;
    //    const pads_reg = gpio.get_pads_reg();
    //    pads_reg.modify(.{
    //        .DRIVE = .{
    //            .value = .@"12mA",
    //        },
    //    });
    //}
};

// setting both uplls enables a "bus keep" function, a weak pull to whatever
// is current high/low state of GPIO
//pub fn setPulls(gpio: u32, up: bool, down: bool) void {}
//
//pub fn pullUp(gpio: u32) void {}
//
//pub fn pullDown(gpio: u32) void {}
//pub fn disablePulls(gpio: u32) void {}
//pub fn setIrqOver(gpio: u32, value: u32) void {}
//pub fn setOutOver(gpio: u32, value: u32) void {}
//pub fn setInOver(gpio: u32, value: u32) void {}
//pub fn setOeOver(gpio: u32, value: u32) void {}
//pub fn setInputEnabled(gpio: u32, enabled: Enabled) void {}
//pub fn setinputHysteresisEnabled(gpio: u32, enabled: Enabled) void {}
//pub fn setSlewRate(gpio: u32, slew_rate: SlewRate) void {}

//pub fn setIrqEnabled(gpio: u32, events: IrqEvents) void {}
//pub fn acknowledgeIrq(gpio: u32, events: IrqEvents) void {}
