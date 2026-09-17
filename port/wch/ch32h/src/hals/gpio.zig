const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub const Pin = struct {
    port: Port,
    number: u4,

    pub const Config = struct {
        port: Port,
        number: u4,
        mode: Mode,
        speed: Speed,
        pull: Pull,
    };

    pub const Port = enum {
        a,
        b,
        c,
        d,
        e,
        f,

        pub inline fn to_mem(self: @This()) @TypeOf(peripherals.GPIOA) {
            return switch (self) {
                .a => peripherals.GPIOA,
                .b => peripherals.GPIOB,
                .c => peripherals.GPIOC,
                .d => peripherals.GPIOD,
                .e => peripherals.GPIOE,
                .f => peripherals.GPIOF,
            };
        }
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

    pub fn init(comptime cfg: Config) Pin {
        const pin: Pin = .{
            .port = cfg.port,
            .number = cfg.number,
        };

        pin.set_mode(cfg.mode);
        pin.set_speed(cfg.speed);
        pin.set_pull(cfg.pull);

        return pin;
    }

    inline fn mask(pin: Pin) u16 {
        return @as(u16, 1) << pin.number;
    }

    pub inline fn set_mode(pin: Pin, mode: Mode) void {
        const port = pin.port.to_mem();

        const offset = (pin.number & 0b111) * 4;
        const cfg_bits = switch (mode) {
            .input => |input| (@as(u32, @backingInt(input)) << 2),
            .output => |output| (@as(u32, @backingInt(output)) << 2) | 1,
        };

        if (pin.number < 8) {
            port.CFGLR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGLR.raw |= cfg_bits << offset;
        } else {
            port.CFGHR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGHR.raw |= cfg_bits << offset;
        }
    }

    pub inline fn set_speed(pin: Pin, speed: Speed) void {
        const port = pin.port.to_mem();

        port.SPEED.raw &= ~(@as(u32, 0b11) << (pin.number * 2));
        port.SPEED.raw |= @as(u32, @backingInt(speed)) << (pin.number * 2);
    }

    pub inline fn set_pull(pin: Pin, pull: Pull) void {
        const port = pin.port.to_mem();

        switch (pull) {
            .up => port.OUTDR.raw |= pin.mask(),
            .down => port.OUTDR.raw &= ~pin.mask(),
            .disabled => {},
        }
    }

    pub inline fn read(pin: Pin) u1 {
        const port = pin.port.to_mem();
        return if ((port.INDR.raw & pin.mask()) == 0) 0 else 1;
    }

    pub inline fn put(pin: Pin, level: u1) void {
        const port = pin.port.to_mem();

        if (level == 1) {
            port.BSHR.raw = pin.mask();
        } else {
            port.BCR.raw = pin.mask();
        }
    }

    pub inline fn toggle(pin: Pin) void {
        const port = pin.port.to_mem();
        port.OUTDR.raw ^= pin.mask();
    }
};
