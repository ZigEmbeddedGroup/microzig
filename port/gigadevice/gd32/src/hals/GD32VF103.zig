const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const UART3 = peripherals.UART3;
const UART4 = peripherals.UART4;

pub const clock_frequencies = .{
    .cpu = 8_000_000, // 8 MHz
};

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'E')
        @compileError(invalid_format_msg);

    return struct {
        const pin_number: comptime_int = @import("std").fmt.parseInt(u2, spec[2..], 10) catch @compileError(invalid_format_msg);
        // 'A'...'E'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(peripherals, "GPIO" ++ gpio_port_name);
        const suffix = @import("std").fmt.comptimePrint("{d}", .{pin_number});
    };
}

fn set_reg_field(reg: anytype, comptime field_name: anytype, value: anytype) void {
    var temp = reg.read();
    @field(temp, field_name) = value;
    reg.write(temp);
}

pub const gpio = struct {
    pub fn set_output(comptime pin: type) void {
        _ = pin;
        // TODO: check if pin is already configured as output
    }
    pub fn set_input(comptime pin: type) void {
        _ = pin;
        // TODO: check if pin is already configured as input
    }

    pub fn read(comptime pin: type) microzig.gpio.State {
        _ = pin;
        // TODO: check if pin is configured as input
        return .low;
    }

    pub fn write(comptime pin: type, state: microzig.gpio.State) void {
        _ = pin;
        _ = state;
        // TODO: check if pin is configured as output
    }
};

pub const uart = struct {
    pub const DataBits = enum(u2) {
        five = 0,
        six = 1,
        seven = 2,
        eight = 3,
    };

    pub const StopBits = enum(u1) {
        one = 0,
        two = 1,
    };

    pub const Parity = enum(u2) {
        odd = 0,
        even = 1,
        mark = 2,
        space = 3,
    };
};

pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const UARTn = switch (index) {
            0 => UART3,
            1 => UART4,
            else => @compileError("GD32VF103 has 2 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: microzig.uart.Config) !Self {
            _ = config;
            return Self{};
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return false;
        }
        pub fn tx(self: Self, ch: u8) void {
            _ = ch;
            while (!self.can_write()) {} // Wait for Previous transmission
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return false;
        }
        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            return 1; // Read received data
        }
    };
}
