// Almost an exact clone of ATmega328p
const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const USART1 = peripherals.USART1;

pub const cpu = microzig.cpu;
const Port = enum(u8) {
    B = 1,
    C = 2,
    D = 3,
    E = 4,
    F = 5,
};

pub const clock = struct {
    pub const Domain = enum {
        cpu,
    };
};

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec.len != 3)
        @compileError(invalid_format_msg);
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    const pin = struct {
        pub const port: Port = std.meta.stringToEnum(Port, spec[1..2]) orelse @compileError(invalid_format_msg);
        pub const pin: u3 = std.fmt.parseInt(u3, spec[2..3], 10) catch @compileError(invalid_format_msg);
    };
    switch (pin.port) {
        .B => {},
        .C => if (pin.pin < 6) @compileError("Invalid pin: " ++ spec),
        .D => {},
        .E => if (pin.pin != 2 and pin.pin != 6) @compileError("Invalid pin: " ++ spec),
        .F => if (pin.pin == 2 or pin.pin == 3) @compileError("Invalid pin: " ++ spec),
    }
    return pin;
}

pub const gpio = struct {
    fn regs(comptime desc: type) type {
        return struct {
            // io address
            const pin_addr: u5 = 3 * @intFromEnum(desc.port) + 0x00;
            const dir_addr: u5 = 3 * @intFromEnum(desc.port) + 0x01;
            const port_addr: u5 = 3 * @intFromEnum(desc.port) + 0x02;

            // ram mapping
            const pin = @as(*volatile u8, @ptrFromInt(0x20 + @as(usize, pin_addr)));
            const dir = @as(*volatile u8, @ptrFromInt(0x20 + @as(usize, dir_addr)));
            const port = @as(*volatile u8, @ptrFromInt(0x20 + @as(usize, port_addr)));
        };
    }

    pub fn set_output(comptime pin: type) void {
        cpu.sbi(regs(pin).dir_addr, pin.pin);
    }

    pub fn set_input(comptime pin: type) void {
        cpu.cbi(regs(pin).dir_addr, pin.pin);
    }

    pub fn read(comptime pin: type) microzig.core.experimental.gpio.State {
        return if ((regs(pin).pin.* & (1 << pin.pin)) != 0)
            .high
        else
            .low;
    }

    pub fn write(comptime pin: type, state: microzig.core.experimental.gpio.State) void {
        switch (state) {
            .high => cpu.sbi(regs(pin).port_addr, pin.pin),
            .low => cpu.cbi(regs(pin).port_addr, pin.pin),
        }
    }

    pub fn toggle(comptime pin: type) void {
        cpu.sbi(regs(pin).pin_addr, pin.pin);
    }
};

pub const uart = struct {
    pub const DataBits = enum {
        five,
        six,
        seven,
        eight,
        nine,
    };

    pub const StopBits = enum {
        one,
        two,
    };

    pub const Parity = enum {
        odd,
        even,
    };
};

pub fn Uart(comptime index: usize, comptime pins: microzig.uart.Pins) type {
    if (index != 0) @compileError("Atmega32U4 only has a single uart!");
    if (pins.tx != null or pins.rx != null)
        @compileError("Atmega32U4 has fixed pins for uart!");

    return struct {
        const Self = @This();

        fn compute_divider(baud_rate: u32) !u12 {
            const pclk = microzig.clock.get().cpu;
            const divider = ((pclk + (8 * baud_rate)) / (16 * baud_rate)) - 1;

            return std.math.cast(u12, divider) orelse return error.UnsupportedBaudRate;
        }

        fn compute_baudrate(divider: u12) u32 {
            return microzig.clock.get().cpu / (16 * @as(u32, divider) + 1);
        }

        pub fn init(config: microzig.uart.Config) !Self {
            const ucsz: u3 = switch (config.data_bits) {
                .five => 0b000,
                .six => 0b001,
                .seven => 0b010,
                .eight => 0b011,
                .nine => return error.UnsupportedWordSize, // 0b111
            };

            const upm: u2 = if (config.parity) |parity| switch (parity) {
                .even => @as(u2, 0b10), // even
                .odd => @as(u2, 0b11), // odd
            } else 0b00; // parity disabled

            const usbs: u1 = switch (config.stop_bits) {
                .one => 0b0,
                .two => 0b1,
            };

            const umsel: u2 = 0b00; // Asynchronous USART

            // baud is computed like this:
            //             f(osc)
            // BAUD = ----------------
            //        16 * (UBRRn + 1)

            const ubrr_val = try compute_divider(config.baud_rate);

            USART1.UCSR1A.modify(.{
                .MPCM1 = 0,
                .U2X1 = 0,
            });
            USART1.UCSR1B.write(.{
                .TXB81 = 0, // we don't care about these btw
                .RXB81 = 0, // we don't care about these btw
                .UCSZ12 = @as(u1, @truncate((ucsz & 0x04) >> 2)),
                .TXEN1 = 1,
                .RXEN1 = 1,
                .UDRIE1 = 0, // no interrupts
                .TXCIE1 = 0, // no interrupts
                .RXCIE1 = 0, // no interrupts
            });
            USART1.UCSR1C.write(.{
                .UCPOL1 = 0, // async mode
                .UCSZ1 = @as(u2, @truncate((ucsz & 0x03) >> 0)),
                .USBS1 = usbs,
                .UPM1 = upm,
                .UMSEL1 = umsel,
            });

            USART1.UBRR1.modify(ubrr_val);

            return Self{};
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return (USART1.UCSR1A.read().UDRE1 == 1);
        }

        pub fn tx(self: Self, ch: u8) void {
            while (!self.can_write()) {} // Wait for Previous transmission
            USART1.UDR1.* = ch; // Load the data to be transmitted
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return (USART1.UCSR1A.read().RXC1 == 1);
        }

        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            return USART1.UDR1.*; // Read received data
        }
    };
}
