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
        const port = cfg.port.to_mem();
        const number = cfg.number & 0b111;
        const offset = number << 2;

        // Configure mode.

        const cfg_bits = switch (cfg.mode) {
            .input => |input| (@as(u32, @backingInt(input)) << 2),
            .output => |output| (@as(u32, @backingInt(output)) << 2) | 1,
        };

        if (cfg.number < 8) {
            port.CFGLR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGLR.raw |= cfg_bits << offset;
        } else {
            port.CFGHR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGHR.raw |= cfg_bits << offset;
        }

        // port.SPEED.raw = 0xFF;

        // TODO: Configure speed & pull (SPEED & OUTDR)

        return .{
            .port = cfg.port,
            .number = cfg.number,
        };
    }

    pub inline fn write(pin: Pin, level: u1) void {
        const port = pin.port.to_mem();

        if (level == 1) {
            port.BSHR.raw = @as(u32, 1) << pin.number;
        } else {
            port.BCR.raw = @as(u32, 1) << pin.number;
        }
    }
};
