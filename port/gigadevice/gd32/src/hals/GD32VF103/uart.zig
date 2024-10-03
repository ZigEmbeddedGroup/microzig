const micro = @import("microzig");
const peripherals = micro.chip.peripherals;
const UART3 = peripherals.UART3;
const UART4 = peripherals.UART4;

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

pub fn Uart(comptime index: usize, comptime pins: micro.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const UARTn = switch (index) {
            0 => UART3,
            1 => UART4,
            else => @compileError("GD32VF103 has 2 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
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
