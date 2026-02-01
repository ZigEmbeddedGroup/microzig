const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PADS_BANK0 = peripherals.PADS_BANK0;
const IO_BANK0 = peripherals.IO_BANK0;
const hw = @import("hw.zig");

const chip = @import("compatibility.zig").chip;

const resets = @import("resets.zig");
const NUM_BANK0_GPIOS = switch (chip) {
    .RP2040 => 30,
    .RP2350 => 48,
};


pub const Direction = enum(u1) {
    in,
    out,
};

pub const SlewRate = enum(u1) {
    slow,
    fast,
};

pub const Function = microzig.chip.types.peripherals.IO_BANK0.Function;
pub const Override = microzig.chip.types.peripherals.IO_BANK0.Override;
pub const DriveStrength = microzig.chip.types.peripherals.PADS_BANK0.DriveStrength;

pub const Pull = enum {
    up,
    down,
    disabled,
};

pub fn num(n: u9) Pin {
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

    return @enumFromInt(n);
}

pub const mask = switch (chip) {
    .RP2040 => struct {
        pub fn mask(m: u30) Mask {
            return @enumFromInt(m);
        }
    }.mask,
    .RP2350 => struct {
        pub fn mask(m: u48) Mask {
            return @enumFromInt(m);
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

            pub fn set_schmitt_trigger_enabled(self: Mask, enabled: bool) void {
                const raw_mask = @intFromEnum(self);
                for (0..@bitSizeOf(Mask)) |i| {
                    const bit = @as(u5, @intCast(i));
                    if (0 != raw_mask & (@as(u32, 1) << bit))
                        num(bit).set_schmitt_trigger_enabled(enabled);
                }
            }

            pub fn set_drive_strength(self: Mask, drive_strength: DriveStrength) void {
                const raw_mask = @intFromEnum(self);
                for (0..@bitSizeOf(Mask)) |i| {
                    const bit = @as(u5, @intCast(i));
                    if (0 != raw_mask & (@as(u32, 1) << bit))
                        num(bit).set_drive_strength(drive_strength);
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

            pub fn set_schmitt_trigger_enabled(self: Mask, enabled: bool) void {
                const raw_mask = @intFromEnum(self);
                for (0..@bitSizeOf(Mask)) |i| {
                    const bit = @as(u6, @intCast(i));
                    if (0 != raw_mask & (@as(u48, 1) << bit))
                        num(bit).set_schmitt_trigger_enabled(enabled);
                }
            }

            pub fn set_drive_strength(self: Mask, drive_strength: DriveStrength) void {
                const raw_mask = @intFromEnum(self);
                for (0..@bitSizeOf(Mask)) |i| {
                    const bit = @as(u6, @intCast(i));
                    if (0 != raw_mask & (@as(u48, 1) << bit))
                        num(bit).set_drive_strength(drive_strength);
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
                const lower_val: u32 = SIO.GPIO_IN.raw & lower_mask;
                const upper_mask = self.upper_16_mask();
                const upper_val: u16 = @truncate(SIO.GPIO_HI_IN.raw & upper_mask);
                return (@as(u48, upper_val) << 32) | @as(u48, lower_val);
            }
        },
    };

pub const Pin = enum(u6) {
    _,

    pub const Regs = struct {
        status: @TypeOf(IO_BANK0.GPIO0_STATUS),
        ctrl: @TypeOf(IO_BANK0.GPIO0_CTRL),
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

    pub inline fn get_regs(gpio: Pin) *volatile Regs {
        const regs = @as(RegsArray, @ptrCast(&IO_BANK0.GPIO0_STATUS));
        return &regs[@intFromEnum(gpio)];
    }

    pub inline fn get_pads_reg(gpio: Pin) *volatile PadsReg {
        const regs = @as(PadsRegArray, @ptrCast(&PADS_BANK0.GPIO0));
        return &regs[@intFromEnum(gpio)];
    }

    /// Only relevant for RP2350 which has 48 GPIOs
    pub inline fn is_upper(gpio: Pin) bool {
        return @intFromEnum(gpio) > 31;
    }

    pub inline fn mask(gpio: Pin) u32 {
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

    pub inline fn set_output_disabled(pin: Pin, disabled: bool) void {
        const pads_reg = pin.get_pads_reg();
        pads_reg.modify(.{ .OD = @intFromBool(disabled) });
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

    pub fn set_schmitt_trigger_enabled(gpio: Pin, enabled: bool) void {
        const pads_reg = gpio.get_pads_reg();
        pads_reg.modify(.{
            .SCHMITT = @intFromBool(enabled),
        });
    }

    pub fn set_drive_strength(gpio: Pin, drive_strength: DriveStrength) void {
        const pads_reg = gpio.get_pads_reg();
        pads_reg.modify(.{ .DRIVE = drive_strength });
    }

    /// Set or clear IRQ event enable for the input events
    /// if enable=true irqs will be enabled for the events indicated
    /// if enable=false irqs will be cleared for the events indicated
    /// events not set in IrqEvents will not be changed
    pub fn set_irq_enabled(gpio: Pin, events: IrqEvents, enable: bool) void {
        // most of this is adapted from the pico-sdk implementation.
        // Get correct register set (based on calling core)
        const core_num = microzig.hal.get_cpu_id();
        const irq_inte_base: [*]volatile u32 = switch (core_num) {
            0 => @ptrCast(&IO_BANK0.PROC0_INTE0),
            else => @ptrCast(&IO_BANK0.PROC1_INTE0),
        };

        // Clear stale events which might cause immediate spurious handler entry
        acknowledge_irq(gpio, events);

        // Enable or disable interrupts for events on this pin
        const pin_num = @intFromEnum(gpio);
        // Divide pin_num by 8 - 8 GPIOs per register.
        const en_reg: *volatile u32 = &irq_inte_base[pin_num >> 3];
        if (enable) {
            const inte0_set = hw.set_alias_raw(en_reg);
            inte0_set.* = events.get_mask(gpio);
        } else {
            const inte0_clear = hw.clear_alias_raw(en_reg);
            inte0_clear.* = events.get_mask(gpio);
        }
    }
    /// Acknowledge rise/fall IRQ events - should be called during IRQ callback to avoid re-entry
    pub fn acknowledge_irq(gpio: Pin, events: IrqEvents) void {
        const base_intr: [*]volatile u32 = @ptrCast(&IO_BANK0.INTR0);
        const pin_num = @intFromEnum(gpio);
        base_intr[pin_num >> 3] = events.get_mask(gpio);
    }
};

/// Helper intended to help identify the event(s) which triggered the interrupt.
/// If there is only one event enabled or if it doesn't matter which
/// event triggered the interrupt this search should not be needed.
/// Though rise/fall events would still need to be cleared (see `acknowledge_irq`)
/// Default values will ensure a full search, it's not recommended to alter them.
pub const IrqEventIter = struct {
    _base_gpio_num: u9 = 0,
    _allevents: u32 = 0,
    _gpio_num: u9 = 0,
    _events_b: u4 = 0,
    /// return the next IRQ event that triggered.
    /// Attempts to inline to minimize execution overhead during IRQ
    /// Acknowledge rise/fall events which have been triggered - calling acknowledge_irq.
    pub inline fn next(self: *IrqEventIter) ?IrqTrigger {
        const core_num = microzig.hal.get_cpu_id();
        const ints_base: [*]volatile u32 = switch (core_num) {
            0 => @ptrCast(&IO_BANK0.PROC0_INTS0),
            else => @ptrCast(&IO_BANK0.PROC1_INTS0),
        };
        // iterate through all INTS (interrupt status) registers
        while (self._base_gpio_num < NUM_BANK0_GPIOS) : (self._base_gpio_num += 8) {
            self._allevents = ints_base[self._base_gpio_num >> 3];
            self._gpio_num = self._base_gpio_num;
            // Loop through each of the 8 GPIO represented in an INTS register (4 bits at a time)
            while (self._allevents != 0) : (self._gpio_num += 1) {
                self._events_b = @truncate(self._allevents & 0xF);
                self._allevents = self._allevents >> 4;
                if (self._events_b != 0) {
                    num(self._gpio_num).acknowledge_irq(@bitCast(self._events_b));
                    return .{
                        .pin = num(self._gpio_num),
                        .events = @bitCast(self._events_b),
                    };
                }
            }
        }
        return null;
    }
};

/// Return type of the IrqEventIterator represents both the Pin and IrqEvents
pub const IrqTrigger = struct {
    pin: Pin,
    events: IrqEvents,
};

/// Event flags for gpio IRQ events
pub const IrqEvents = packed struct(u4) {
    low: u1 = 0,
    high: u1 = 0,
    fall: u1 = 0,
    rise: u1 = 0,
    /// Returns an appropriately shifted mask of the events represented
    /// This is generally only needed for low level - direct register - access
    pub fn get_mask(events: IrqEvents, pin: Pin) u32 {
        const pin_num = @intFromEnum(pin);
        const shift: u5 = @intCast(4 * (pin_num % 8)); // cannot overflow - max of 7
        const events_b: u4 = @bitCast(events);
        return @as(u32, @intCast(events_b)) << shift;
    }
};
