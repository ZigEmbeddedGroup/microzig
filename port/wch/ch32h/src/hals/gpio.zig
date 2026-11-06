const microzig = @import("microzig");
const clocks = microzig.hal.clocks;
const Peripherals = microzig.hal.Peripherals;

const AFIO = microzig.chip.peripherals.AFIO;

pub const Pin = struct {
    gpio: Peripherals.GPIO,
    number: u4,

    pub const Config = struct {
        mode: Mode,
        speed: Speed,
        pull: Pull,
        alternate_function: ?u4 = null,
    };

    pub const Mode = union(enum) {
        input: Input,
        output: Output,

        pub const Input = enum(u2) {
            analog,
            floating,
            pull,
            reserved,
        };

        pub const Output = enum(u2) {
            general_purpose_push_pull,
            general_purpose_open_drain,
            alternate_function_push_pull,
            alternate_function_open_drain,
        };
    };

    pub const Speed = enum(u2) {
        max_10MHz,
        max_50MHz,
        max_100MHz,
        max_180MHz,
    };

    pub const Pull = enum {
        up,
        down,
        disabled,
    };

    pub fn enable(pin: Pin) void {
        clocks.enable(Peripherals.to_peripheral(pin.gpio));
    }

    pub fn apply(pin: Pin, comptime cfg: Config) void {
        pin.enable();
        pin.set_mode(cfg.mode);
        pin.set_speed(cfg.speed);
        pin.set_pull(cfg.pull);
        if (cfg.alternate_function) |af| pin.set_af(af);
    }

    pub inline fn set_af(pin: Pin, af: u4) void {
        clocks.enable(.AFIO);

        const af_mask = @as(u32, 0b1111) << pin.offset();

        const reg: *volatile u32 = switch (pin.gpio) {
            .GPIOA => if (pin.number >= 8) @ptrCast(&AFIO.GPIOA_AFHR) else @ptrCast(&AFIO.GPIOA_AFLR),
            .GPIOB => if (pin.number >= 8) @ptrCast(&AFIO.GPIOB_AFHR) else @ptrCast(&AFIO.GPIOB_AFLR),
            .GPIOC => if (pin.number >= 8) @ptrCast(&AFIO.GPIOC_AFHR) else @ptrCast(&AFIO.GPIOC_AFLR),
            .GPIOD => if (pin.number >= 8) @ptrCast(&AFIO.GPIOD_AFHR) else @ptrCast(&AFIO.GPIOD_AFLR),
            .GPIOE => if (pin.number >= 8) @ptrCast(&AFIO.GPIOE_AFHR) else @ptrCast(&AFIO.GPIOE_AFLR),
            .GPIOF => if (pin.number >= 8) @ptrCast(&AFIO.GPIOF_AFHR) else @ptrCast(&AFIO.GPIOF_AFLR),
        };

        reg.* = (reg.* & ~af_mask) | ((@as(u32, af) << pin.offset()) & af_mask);
    }

    inline fn mask(pin: Pin) u16 {
        return @as(u16, 1) << pin.number;
    }

    inline fn offset(pin: Pin) u5 {
        return @as(u5, pin.number & 0b111) * 4;
    }

    pub inline fn set_mode(pin: Pin, mode: Mode) void {
        const port = Peripherals.to_reg(pin.gpio);

        const cfg_bits = switch (mode) {
            .input => |input| (@as(u32, @backingInt(input)) << 2),
            .output => |output| (@as(u32, @backingInt(output)) << 2) | 1,
        };

        if (pin.number < 8) {
            port.CFGLR.raw &= ~(@as(u32, 0b1111) << pin.offset());
            port.CFGLR.raw |= cfg_bits << pin.offset();
        } else {
            port.CFGHR.raw &= ~(@as(u32, 0b1111) << pin.offset());
            port.CFGHR.raw |= cfg_bits << pin.offset();
        }
    }

    pub inline fn set_speed(pin: Pin, speed: Speed) void {
        const port = Peripherals.to_reg(pin.gpio);

        port.SPEED.raw &= ~(@as(u32, 0b11) << (@as(u5, pin.number) * 2));
        port.SPEED.raw |= @as(u32, @backingInt(speed)) << (@as(u5, pin.number) * 2);
    }

    pub inline fn set_pull(pin: Pin, pull: Pull) void {
        const port = Peripherals.to_reg(pin.gpio);

        switch (pull) {
            .up => port.OUTDR.raw |= pin.mask(),
            .down => port.OUTDR.raw &= ~pin.mask(),
            .disabled => {},
        }
    }

    pub inline fn read(pin: Pin) u1 {
        const port = Peripherals.to_reg(pin.gpio);
        return if ((port.INDR.raw & pin.mask()) == 0) 0 else 1;
    }

    pub inline fn put(pin: Pin, level: u1) void {
        const port = Peripherals.to_reg(pin.gpio);

        if (level == 1) {
            port.BSHR.raw = pin.mask();
        } else {
            port.BCR.raw = pin.mask();
        }
    }

    pub inline fn toggle(pin: Pin) void {
        const port = Peripherals.to_reg(pin.gpio);
        port.OUTDR.raw ^= pin.mask();
    }
};
