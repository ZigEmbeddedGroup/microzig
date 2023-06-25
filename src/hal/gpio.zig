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

pub const Pull = enum {
    up,
    down,
};

pub fn num(n: u5) Pin {
    if (n > 29)
        @panic("the RP2040 only has GPIO 0-29");

    return @enumFromInt(Pin, n);
}

pub fn mask(m: u32) Mask {
    return @enumFromInt(Mask, m);
}

pub const Mask = enum(u30) {
    _,

    pub fn set_function(self: Mask, function: Function) void {
        const raw_mask = @intFromEnum(self);
        for (0..@bitSizeOf(Mask)) |i| {
            const bit = @intCast(u5, i);
            if (0 != raw_mask & (@as(u32, 1) << bit))
                num(bit).set_function(function);
        }
    }

    pub fn set_direction(self: Mask, direction: Direction) void {
        const raw_mask = @intFromEnum(self);
        switch (direction) {
            .out => SIO.GPIO_OE_SET.raw = raw_mask,
            .in => SIO.GPIO_OE_CLR.raw = raw_mask,
        }
    }

    pub fn set_pull(self: Mask, pull: ?Pull) void {
        const raw_mask = @intFromEnum(self);
        for (0..@bitSizeOf(Mask)) |i| {
            const bit = @intCast(u5, i);
            if (0 != raw_mask & (@as(u32, 1) << bit))
                num(bit).set_pull(pull);
        }
    }

    pub fn put(self: Mask, value: u32) void {
        SIO.GPIO_OUT_XOR.raw = (SIO.GPIO_OUT.raw ^ value) & @intFromEnum(self);
    }

    pub fn read(self: Mask) u32 {
        return SIO.GPIO_IN.raw & @intFromEnum(self);
    }
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
        return &regs[@intFromEnum(gpio)];
    }

    fn get_pads_reg(gpio: Pin) *volatile PadsReg {
        const regs = @ptrCast(*volatile [30]PadsReg, &PADS_BANK0.GPIO0);
        return &regs[@intFromEnum(gpio)];
    }

    pub fn mask(gpio: Pin) u32 {
        return @as(u32, 1) << @intFromEnum(gpio);
    }

    pub inline fn set_pull(gpio: Pin, pull: ?Pull) void {
        const pads_reg = gpio.get_pads_reg();

        if (pull == null) {
            pads_reg.modify(.{ .PUE = 0, .PDE = 0 });
        } else switch (pull.?) {
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

    pub inline fn set_input_enabled(pin: Pin, enabled: bool) void {
        const pads_reg = pin.get_pads_reg();
        pads_reg.modify(.{ .IE = @intFromBool(enabled) });
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
};
