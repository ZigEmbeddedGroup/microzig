const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PADS_BANK0 = peripherals.PADS_BANK0;
const IO_BANK0 = peripherals.IO_BANK0;

const chip = @import("compatibility.zig").chip;

const resets = @import("resets.zig");

const log = std.log.scoped(.gpio);

pub const Function =
    switch (chip) {
    .RP2040 => enum(u5) {
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
        disabled = 0x1f,
    },
    .RP2350 => enum(u5) {
        hstx = 0,
        spi,
        uart,
        i2c,
        pwm,
        sio,
        pio0,
        pio1,
        pio2,
        gpck,
        usb,
        uart_secondary,
        disabled = 0x1f,
    },
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

pub const Override = enum(u2) {
    normal,
    invert,
    low,
    high,
};

pub const SlewRate = enum(u1) {
    slow,
    fast,
};

pub const DriveStrength = enum(u2) {
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
    disabled,
};

pub fn num(n: u6) Pin {
    switch (chip) {
        .RP2040 => {
            if (n > 29)
                @panic("the RP2040 only has GPIO 0-29");
        },
        .RP2350 => {
            if (n > 47)
                @panic("the RP2350 only has GPIO 0-47");
        },
    }

    return @as(Pin, @enumFromInt(n));
}

pub const mask = switch (chip) {
    .RP2040 => struct {
        pub fn mask(m: u30) Mask {
            return @as(Mask, @enumFromInt(m));
        }
    }.mask,
    .RP2350 => struct {
        pub fn mask(m: u48) Mask {
            return @as(Mask, @enumFromInt(m));
        }
    }.mask,
};

pub const Mask =
    switch (chip) {
    .RP2040 => enum(u30) {
        _,

        pub fn set_function(self: Mask, function: Function) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u5, @intCast(i));
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

        pub fn set_pull(self: Mask, pull: Pull) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u5, @intCast(i));
                if (0 != raw_mask & (@as(u32, 1) << bit))
                    num(bit).set_pull(pull);
            }
        }

        pub fn set_slew_rate(self: Mask, slew_rate: SlewRate) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u5, @intCast(i));
                if (0 != raw_mask & (@as(u32, 1) << bit))
                    num(bit).set_slew_rate(slew_rate);
            }
        }

        pub fn set_schmitt_trigger(self: Mask, enabled: Enabled) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u5, @intCast(i));
                if (0 != raw_mask & (@as(u32, 1) << bit))
                    num(bit).set_schmitt_trigger(enabled);
            }
        }

        pub fn put(self: Mask, value: u32) void {
            SIO.GPIO_OUT_XOR.raw = (SIO.GPIO_OUT.raw ^ value) & @intFromEnum(self);
        }

        pub fn read(self: Mask) u32 {
            return SIO.GPIO_IN.raw & @intFromEnum(self);
        }
    },
    .RP2350 => enum(u48) {
        _,

        fn lower_32_mask(self: Mask) u32 {
            return @truncate(@intFromEnum(self));
        }

        fn upper_16_mask(self: Mask) u16 {
            return @truncate(@intFromEnum(self) >> 32);
        }

        pub fn set_function(self: Mask, function: Function) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u6, @intCast(i));
                if (0 != raw_mask & (@as(u48, 1) << bit))
                    num(bit).set_function(function);
            }
        }

        pub fn set_direction(self: Mask, direction: Direction) void {
            const lower_mask = self.lower_32_mask();
            const upper_mask = self.upper_16_mask();
            switch (direction) {
                .out => {
                    SIO.GPIO_OE_SET.raw = lower_mask;
                    SIO.GPIO_HI_OE_SET.raw = upper_mask;
                },
                .in => {
                    SIO.GPIO_OE_CLR.raw = lower_mask;
                    SIO.GPIO_HI_OE_CLR.raw = lower_mask;
                },
            }
        }

        pub fn set_pull(self: Mask, pull: Pull) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u6, @intCast(i));
                if (0 != raw_mask & (@as(u48, 1) << bit))
                    num(bit).set_pull(pull);
            }
        }

        pub fn set_slew_rate(self: Mask, slew_rate: SlewRate) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u6, @intCast(i));
                if (0 != raw_mask & (@as(u48, 1) << bit))
                    num(bit).set_slew_rate(slew_rate);
            }
        }

        pub fn set_schmitt_trigger(self: Mask, enabled: Enabled) void {
            const raw_mask = @intFromEnum(self);
            for (0..@bitSizeOf(Mask)) |i| {
                const bit = @as(u6, @intCast(i));
                if (0 != raw_mask & (@as(u48, 1) << bit))
                    num(bit).set_schmitt_trigger(enabled);
            }
        }

        pub fn put(self: Mask, value: u48) void {
            const lower_mask = self.lower_32_mask();
            const lower_val: u32 = @truncate(value);
            const upper_mask = self.upper_16_mask();
            const upper_val: u16 = @truncate(value >> 32);
            SIO.GPIO_OUT_XOR.raw = (SIO.GPIO_OUT.raw ^ lower_val) & lower_mask;
            SIO.GPIO_HI_OUT_XOR.raw = (SIO.GPIO_HI_OUT.raw ^ upper_val) & upper_mask;
        }

        pub fn read(self: Mask) u48 {
            const lower_mask = self.lower_32_mask();
            const lower_val: u32 = SIO.GPIO_IN & lower_mask;
            const upper_mask = self.upper_16_mask();
            const upper_val: u16 = @truncate(SIO.GPIO_HI_IN.raw & upper_mask);
            return (@as(u48, upper_val) << 32) | @as(u48, lower_val);
        }
    },
};

pub const Pin = enum(u6) {
    _,

    pub const Regs =
        switch (chip) {
        .RP2040 => extern struct {
            status: @TypeOf(IO_BANK0.GPIO0_STATUS),
            ctrl: microzig.mmio.Mmio(packed struct(u32) {
                FUNCSEL: Function,
                reserved8: u3,
                OUTOVER: Override,
                reserved12: u2,
                OEOVER: Override,
                reserved16: u2,
                INOVER: Override,
                reserved28: u10,
                IRQOVER: Override,
                padding: u2,
            }),
        },
        .RP2350 => extern struct {
            status: @TypeOf(IO_BANK0.GPIO0_STATUS),
            ctrl: microzig.mmio.Mmio(packed struct(u32) {
                FUNCSEL: Function,
                reserved12: u7,
                OUTOVER: Override,
                OEOVER: Override,
                INOVER: Override,
                reserved28: u10,
                IRQOVER: Override,
                padding: u2,
            }),
        },
    };

    pub const RegsArray = switch (chip) {
        .RP2040 => *volatile [30]Regs,
        .RP2350 => *volatile [48]Regs,
    };

    pub const PadsReg = @TypeOf(PADS_BANK0.GPIO0);
    pub const PadsRegArray = switch (chip) {
        .RP2040 => *volatile [30]PadsReg,
        .RP2350 => *volatile [48]PadsReg,
    };

    fn get_regs(gpio: Pin) *volatile Regs {
        const regs = @as(RegsArray, @ptrCast(&IO_BANK0.GPIO0_STATUS));
        return &regs[@intFromEnum(gpio)];
    }

    fn get_pads_reg(gpio: Pin) *volatile PadsReg {
        const regs = @as(PadsRegArray, @ptrCast(&PADS_BANK0.GPIO0));
        return &regs[@intFromEnum(gpio)];
    }

    /// Only relevant for RP2350 which has 48 GPIOs
    fn is_upper(gpio: Pin) bool {
        return @intFromEnum(gpio) > 31;
    }

    pub fn mask(gpio: Pin) u32 {
        const bitshift_val: u5 = switch (chip) {
            .RP2040 => @intCast(@intFromEnum(gpio)),
            .RP2350 =>
            // There are seperate copies of registers for GPIO32->47 on RP2350,
            // so upper GPIOs should present as bits 0 -> 15
            if (gpio.is_upper()) @intCast(@intFromEnum(gpio) - 32) else @intCast(@intFromEnum(gpio)),
        };

        return @as(u32, 1) << bitshift_val;
    }

    pub inline fn set_pull(gpio: Pin, pull: Pull) void {
        const pads_reg = gpio.get_pads_reg();
        switch (pull) {
            .up => pads_reg.modify(.{ .PUE = 1, .PDE = 0 }),
            .down => pads_reg.modify(.{ .PUE = 0, .PDE = 1 }),
            .disabled => pads_reg.modify(.{ .PUE = 0, .PDE = 0 }),
        }
    }

    pub inline fn set_direction(gpio: Pin, direction: Direction) void {
        switch (chip) {
            .RP2040 => {
                switch (direction) {
                    .in => SIO.GPIO_OE_CLR.raw = gpio.mask(),
                    .out => SIO.GPIO_OE_SET.raw = gpio.mask(),
                }
            },
            .RP2350 => {
                if (gpio.is_upper()) {
                    switch (direction) {
                        .in => SIO.GPIO_HI_OE_CLR.raw = gpio.mask(),
                        .out => SIO.GPIO_HI_OE_SET.raw = gpio.mask(),
                    }
                } else {
                    switch (direction) {
                        .in => SIO.GPIO_OE_CLR.raw = gpio.mask(),
                        .out => SIO.GPIO_OE_SET.raw = gpio.mask(),
                    }
                }
            },
        }
    }

    /// Drive a single GPIO high/low
    pub inline fn put(gpio: Pin, value: u1) void {
        switch (chip) {
            .RP2040 => {
                switch (value) {
                    0 => SIO.GPIO_OUT_CLR.raw = gpio.mask(),
                    1 => SIO.GPIO_OUT_SET.raw = gpio.mask(),
                }
            },
            .RP2350 => {
                if (gpio.is_upper()) {
                    switch (value) {
                        0 => SIO.GPIO_HI_OUT_CLR.raw = gpio.mask(),
                        1 => SIO.GPIO_HI_OUT_SET.raw = gpio.mask(),
                    }
                } else {
                    switch (value) {
                        0 => SIO.GPIO_OUT_CLR.raw = gpio.mask(),
                        1 => SIO.GPIO_OUT_SET.raw = gpio.mask(),
                    }
                }
            },
        }
    }

    pub inline fn toggle(gpio: Pin) void {
        switch (chip) {
            .RP2040 => {
                SIO.GPIO_OUT_XOR.raw = gpio.mask();
            },
            .RP2350 => {
                if (gpio.is_upper()) {
                    SIO.GPIO_HI_OUT_XOR.raw = gpio.mask();
                } else {
                    SIO.GPIO_OUT_XOR.raw = gpio.mask();
                }
            },
        }
    }

    pub inline fn read(gpio: Pin) u1 {
        switch (chip) {
            .RP2040 => {
                return if ((SIO.GPIO_IN.raw & gpio.mask()) != 0)
                    1
                else
                    0;
            },
            .RP2350 => {
                if (gpio.is_upper()) {
                    return if ((SIO.GPIO_HI_IN.raw & gpio.mask()) != 0)
                        1
                    else
                        0;
                } else {
                    return if ((SIO.GPIO_IN.raw & gpio.mask()) != 0)
                        1
                    else
                        0;
                }
            },
        }
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
            .FUNCSEL = function,
            .OUTOVER = .normal,
            .INOVER = .normal,
            .IRQOVER = .normal,
            .OEOVER = .normal,
        });

        switch (chip) {
            .RP2040 => {},
            .RP2350 => {
                // RP2350 added pad isolation that must be removed to actually connect the GPIO
                pads_reg.modify(.{
                    .ISO = 0,
                });
            },
        }
    }

    pub fn set_slew_rate(gpio: Pin, slew_rate: SlewRate) void {
        const pads_reg = gpio.get_pads_reg();
        pads_reg.modify(.{
            .SLEWFAST = switch (slew_rate) {
                .slow => @as(u1, 0),
                .fast => @as(u1, 1),
            },
        });
    }

    pub fn set_schmitt_trigger(gpio: Pin, enabled: Enabled) void {
        const pads_reg = gpio.get_pads_reg();
        pads_reg.modify(.{
            .SCHMITT = switch (enabled) {
                .enabled => @as(u1, 1),
                .disabled => @as(u1, 0),
            },
        });
    }
};
