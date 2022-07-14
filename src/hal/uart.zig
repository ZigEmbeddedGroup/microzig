const std = @import("std");
const microzig = @import("microzig");
const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");

const assert = std.debug.assert;
const regs = microzig.chip.registers;

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
    tx_pin: u32,
    rx_pin: u32,
    baud_rate: u32,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
};

pub const UartRegs = extern struct {
    dr: u32,
    rsr: u32,
    reserved0: [4]u32,
    fr: @typeInfo(@TypeOf(regs.UART0.UARTFR)).Pointer.child,
    resertev1: [1]u32,
    ilpr: u32,
    ibrd: u32,
    fbrd: u32,
    lcr_h: @typeInfo(@TypeOf(regs.UART0.UARTLCR_H)).Pointer.child,
    cr: @typeInfo(@TypeOf(regs.UART0.UARTCR)).Pointer.child,
    ifls: u32,
    imsc: u32,
    ris: u32,
    mis: u32,
    icr: u32,
    dmacr: @typeInfo(@TypeOf(regs.UART0.UARTDMACR)).Pointer.child,
    periphid0: u32,
    periphid1: u32,
    periphid2: u32,
    periphid3: u32,
    cellid0: u32,
    cellid1: u32,
    cellid2: u32,
    cellid3: u32,

    padding: [4069]u32,
};

const uarts = @intToPtr(*volatile [2]UartRegs, regs.UART0.base_address);
comptime {
    assert(@sizeOf(UartRegs) == (regs.UART1.base_address - regs.UART0.base_address));
}

pub const UART = enum {
    uart0,
    uart1,

    const WriteError = error{};
    pub const Writer = std.io.Writer(UART, WriteError, write);

    pub fn writer(uart: UART) Writer {
        return .{ .context = uart };
    }

    fn getRegs(uart: UART) *volatile UartRegs {
        return &uarts[@enumToInt(uart)];
    }

    pub fn init(comptime id: u32, comptime config: Config) UART {
        const uart: UART = switch (id) {
            0 => .uart0,
            1 => .uart1,
            else => @compileError("there is only uart0 and uart1"),
        };

        assert(config.baud_rate > 0);

        uart.reset();

        const uart_regs = uart.getRegs();
        const peri_freq = config.clock_config.peri.?.output_freq;
        uart.setBaudRate(config.baud_rate, peri_freq);
        uart.setFormat(config.word_bits, config.stop_bits, config.parity);

        uart_regs.cr.modify(.{
            .UARTEN = 1,
            .TXE = 1,
            .RXE = 1,
        });

        uart_regs.lcr_h.modify(.{ .FEN = 1 });

        // - always enable DREQ signals -- no harm if dma isn't listening
        uart_regs.dmacr.modify(.{
            .TXDMAE = 1,
            .RXDMAE = 1,
        });

        // TODO comptime assertions
        gpio.setFunction(config.tx_pin, .uart);
        gpio.setFunction(config.rx_pin, .uart);

        return uart;
    }

    pub fn isReadable(uart: UART) bool {
        return (0 == uart.getRegs().fr.read().RXFE);
    }

    pub fn isWritable(uart: UART) bool {
        return (0 == uart.getRegs().fr.read().TXFF);
    }

    // TODO: implement tx fifo
    pub fn write(uart: UART, payload: []const u8) WriteError!usize {
        const uart_regs = uart.getRegs();
        for (payload) |byte| {
            while (!uart.isWritable()) {}

            uart_regs.dr = byte;
        }

        return payload.len;
    }

    pub fn readWord(uart: UART) u8 {
        const uart_regs = uart.getRegs();
        while (!uart.isReadable()) {}

        return @truncate(u8, uart_regs.dr);
    }

    pub fn reset(uart: UART) void {
        switch (uart) {
            .uart0 => {
                regs.RESETS.RESET.modify(.{ .uart0 = 1 });
                regs.RESETS.RESET.modify(.{ .uart0 = 0 });
                while (regs.RESETS.RESET_DONE.read().uart0 != 1) {}
            },
            .uart1 => {
                regs.RESETS.RESET.modify(.{ .uart1 = 1 });
                regs.RESETS.RESET.modify(.{ .uart1 = 0 });
                while (regs.RESETS.RESET_DONE.read().uart1 != 1) {}
            },
        }
    }

    pub fn setFormat(
        uart: UART,
        word_bits: WordBits,
        stop_bits: StopBits,
        parity: Parity,
    ) void {
        const uart_regs = uart.getRegs();
        uart_regs.lcr_h.modify(.{
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
            .PEN = if (parity != .none) @as(u1, 1) else @as(u1, 0),
            .EPS = switch (parity) {
                .even => @as(u1, 1),
                .odd => @as(u1, 0),
                else => @as(u1, 0),
            },
        });
    }

    fn setBaudRate(uart: UART, baud_rate: u32, peri_freq: u32) void {
        assert(baud_rate > 0);
        const uart_regs = uart.getRegs();
        const baud_rate_div = (8 * peri_freq / baud_rate);
        var baud_ibrd = baud_rate_div >> 7;

        const baud_fbrd = if (baud_ibrd == 0) baud_fbrd: {
            baud_ibrd = 1;
            break :baud_fbrd 0;
        } else if (baud_ibrd >= 65535) baud_fbrd: {
            baud_ibrd = 65535;
            break :baud_fbrd 0;
        } else ((baud_rate_div & 0x7f) + 1) / 2;

        uart_regs.ibrd = baud_ibrd;
        uart_regs.fbrd = baud_fbrd;

        // just want a write, don't want to change these values
        uart_regs.lcr_h.modify(.{});
    }
};
