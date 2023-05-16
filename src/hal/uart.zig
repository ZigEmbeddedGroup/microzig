const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const UART0 = peripherals.UART0;
const UART1 = peripherals.UART1;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");
const dma = @import("dma.zig");

const assert = std.debug.assert;

const UartRegs = microzig.chip.types.peripherals.UART0;

pub const WordBits = enum {
    five,
    six,
    seven,
    eight,
};

pub const StopBits = enum {
    one,
    two,
};

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const Config = struct {
    clock_config: clocks.GlobalConfiguration,
    tx_pin: ?gpio.Pin = null,
    rx_pin: ?gpio.Pin = null,
    baud_rate: u32,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
};

pub fn num(n: u1) UART {
    return @intToEnum(UART, n);
}

pub const UART = enum(u1) {
    _,

    const WriteError = error{};
    const ReadError = error{};
    pub const Writer = std.io.Writer(UART, WriteError, write);
    pub const Reader = std.io.Reader(UART, ReadError, read);

    pub fn writer(uart: UART) Writer {
        return .{ .context = uart };
    }

    pub fn reader(uart: UART) Reader {
        return .{ .context = uart };
    }

    fn get_regs(uart: UART) *volatile UartRegs {
        return switch (@enumToInt(uart)) {
            0 => UART0,
            1 => UART1,
        };
    }

    pub fn apply(uart: UART, comptime config: Config) void {
        assert(config.baud_rate > 0);

        const uart_regs = uart.get_regs();
        const peri_freq = config.clock_config.peri.?.output_freq;
        uart.set_baudrate(config.baud_rate, peri_freq);
        uart.set_format(config.word_bits, config.stop_bits, config.parity);

        uart_regs.UARTCR.modify(.{
            .UARTEN = 1,
            .TXE = 1,
            .RXE = 1,
        });

        uart_regs.UARTLCR_H.modify(.{ .FEN = 1 });

        // - always enable DREQ signals -- no harm if dma isn't listening
        uart_regs.UARTDMACR.modify(.{
            .TXDMAE = 1,
            .RXDMAE = 1,
        });

        // TODO comptime assertions
        if (config.tx_pin) |tx_pin| tx_pin.set_function(.uart);
        if (config.rx_pin) |rx_pin| rx_pin.set_function(.uart);
    }

    pub fn is_readable(uart: UART) bool {
        return (0 == uart.get_regs().UARTFR.read().RXFE);
    }

    pub fn is_writeable(uart: UART) bool {
        return (0 == uart.get_regs().UARTFR.read().TXFF);
    }

    // TODO: implement tx fifo
    pub fn write(uart: UART, payload: []const u8) WriteError!usize {
        const uart_regs = uart.get_regs();
        for (payload) |byte| {
            while (!uart.is_writeable()) {}

            uart_regs.UARTDR.raw = byte;
        }

        return payload.len;
    }

    pub fn tx_fifo(uart: UART) *volatile u32 {
        const regs = uart.get_regs();
        return @ptrCast(*volatile u32, &regs.UARTDR);
    }

    pub fn dreq_tx(uart: UART) dma.Dreq {
        return switch (@enumToInt(uart)) {
            0 => .uart0_tx,
            1 => .uart1_tx,
        };
    }

    pub fn read(uart: UART, buffer: []u8) ReadError!usize {
        const uart_regs = uart.get_regs();
        for (buffer) |*byte| {
            while (!uart.is_readable()) {}

            // TODO: error checking
            byte.* = uart_regs.UARTDR.read().DATA;
        }
        return buffer.len;
    }

    pub fn read_word(uart: UART) u8 {
        const uart_regs = uart.get_regs();
        while (!uart.is_readable()) {}

        // TODO: error checking
        return uart_regs.UARTDR.read().DATA;
    }

    pub fn set_format(
        uart: UART,
        word_bits: WordBits,
        stop_bits: StopBits,
        parity: Parity,
    ) void {
        const uart_regs = uart.get_regs();
        uart_regs.UARTLCR_H.modify(.{
            .WLEN = switch (word_bits) {
                .eight => @as(u2, 0b11),
                .seven => @as(u2, 0b10),
                .six => @as(u2, 0b01),
                .five => @as(u2, 0b00),
            },
            .STP2 = switch (stop_bits) {
                .one => @as(u1, 0),
                .two => @as(u1, 1),
            },
            .PEN = switch (parity) {
                .none => @as(u1, 0),
                .even, .odd => @as(u1, 1),
            },
            .EPS = switch (parity) {
                .even => @as(u1, 1),
                .odd, .none => @as(u1, 0),
            },
        });
    }

    fn set_baudrate(uart: UART, baud_rate: u32, peri_freq: u32) void {
        assert(baud_rate > 0);
        const uart_regs = uart.get_regs();
        const baud_rate_div = (8 * peri_freq / baud_rate);
        var baud_ibrd = @intCast(u16, baud_rate_div >> 7);

        const baud_fbrd: u6 = if (baud_ibrd == 0) baud_fbrd: {
            baud_ibrd = 1;
            break :baud_fbrd 0;
        } else if (baud_ibrd >= 65535) baud_fbrd: {
            baud_ibrd = 65535;
            break :baud_fbrd 0;
        } else @intCast(u6, ((@truncate(u7, baud_rate_div)) + 1) / 2);

        uart_regs.UARTIBRD.write(.{ .BAUD_DIVINT = baud_ibrd, .padding = 0 });
        uart_regs.UARTFBRD.write(.{ .BAUD_DIVFRAC = baud_fbrd, .padding = 0 });

        // just want a write, don't want to change these values
        uart_regs.UARTLCR_H.modify(.{});
    }
};

var uart_logger: ?UART.Writer = null;

pub fn init_logger(uart: UART) void {
    uart_logger = uart.writer();
    uart_logger.?.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
}

pub fn log(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const level_prefix = comptime "[{}.{:0>6}] " ++ level.asText();
    const prefix = comptime level_prefix ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (uart_logger) |uart| {
        const current_time = time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;

        uart.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
    }
}
