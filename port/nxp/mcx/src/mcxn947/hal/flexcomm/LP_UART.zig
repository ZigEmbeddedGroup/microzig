const std = @import("std");
const microzig = @import("microzig");
const FlexComm = @import("../flexcomm.zig").FlexComm;

const chip = microzig.chip;
const peripherals = chip.peripherals;
const Io = std.Io;

/// Uart interface. Currently only support 8 bit mode.
// TODO: 9 and 10 bit mode
pub const LP_UART = enum(u4) {
    _,

    pub const RegTy = *volatile chip.types.peripherals.LPUART0;
    const Registers: [10]RegTy = .{
        peripherals.LPUART0,
        peripherals.LPUART1,
        peripherals.LPUART2,
        peripherals.LPUART3,
        peripherals.LPUART4,
        peripherals.LPUART5,
        peripherals.LPUART6,
        peripherals.LPUART7,
        peripherals.LPUART8,
        peripherals.LPUART9,
    };

    pub const Config = struct {
        data_mode: DataMode,
        stop_bits_count: enum { one, two },
        parity: enum(u2) { none = 0, even = 0b10, odd = 0b11 },
        baudrate: u32,
        enable_send: bool,
        enable_receive: bool,
        bit_order: enum { lsb, mbs },

        /// Whether received bits should be inverted (also applies to start and stop bits)
        rx_invert: bool,
        /// Whether transmitted bits should be inverted (also applies to start and stop bits)
        tx_invert: bool,

        pub const DataMode = enum {
            @"7bit",
            @"8bit",
            @"9bit",
            @"10bit",
        };

        pub const Default = Config{ .data_mode = .@"8bit", .stop_bits_count = .one, .parity = .none, .baudrate = 115200, .enable_send = true, .enable_receive = true, .bit_order = .lsb, .rx_invert = false, .tx_invert = false };
    };

    pub const ConfigError = error{UnsupportedBaudRate};

    /// Initializes the Uart controller.
    pub fn init(interface: u4, config: Config) ConfigError!LP_UART {
        FlexComm.num(interface).init(.UART);

        const uart: LP_UART = @enumFromInt(interface);
        const regs = uart.get_regs();
        uart.reset();
        _ = uart.disable();

        try uart.set_baudrate(config.baudrate);
        if (config.data_mode == .@"10bit") regs.BAUD.modify_one("M10", .ENABLED);
        if (config.stop_bits_count == .two) regs.BAUD.modify_one("SBNS", .TWO);

        var ctrl = std.mem.zeroes(@TypeOf(regs.CTRL).underlying_type);
        ctrl.M7 = if (config.data_mode == .@"7bit") .DATA7 else .NO_EFFECT;
        ctrl.PE = if (config.parity != .none) .ENABLED else .DISABLED;
        ctrl.PT = if (@intFromEnum(config.parity) & 1 == 0) .EVEN else .ODD;
        ctrl.M = if (config.data_mode == .@"9bit") .DATA9 else .DATA8;
        ctrl.TXINV = if (config.tx_invert) .INVERTED else .NOT_INVERTED;
        ctrl.IDLECFG = .IDLE_2; // TODO: make this configurable ?
        ctrl.ILT = .FROM_STOP; // same
        regs.CTRL.write(ctrl);

        // clear flags and set bit order
        var stat = std.mem.zeroes(@TypeOf(regs.STAT).underlying_type);
        // read and write on these bits are different
        // writing one cleare those flags
        stat.RXEDGIF = .EDGE;
        stat.IDLE = .IDLE;
        stat.OR = .OVERRUN;
        stat.NF = .NOISE;
        stat.FE = .ERROR;
        stat.PF = .PARITY;
        stat.LBKDIF = .DETECTED;
        stat.MA1F = .MATCH;
        stat.MA2F = .MATCH;

        stat.MSBF = if (config.bit_order == .lsb) .LSB_FIRST else .MSB_FIRST;
        stat.RXINV = if (config.rx_invert) .INVERTED else .NOT_INVERTED;
        regs.STAT.modify(stat);

        uart.set_enabled(config.enable_send, config.enable_receive);

        return uart;
    }

    /// Resets the Uart interface and deinit the corresponding FlexComm interface.
    pub fn deinit(uart: LP_UART) void {
        uart.reset();
        FlexComm.num(uart.get_n()).deinit();
    }

    /// Resets the Uart interface.
    pub fn reset(uart: LP_UART) void {
        uart.get_regs().GLOBAL.modify_one("RST", .RESET);
        uart.get_regs().GLOBAL.modify_one("RST", .NO_EFFECT);
    }

    /// Disables the interface.
    /// Returns if the transmitter and the receiver were enabled (in this order).
    pub fn disable(uart: LP_UART) struct { bool, bool } {
        const regs = uart.get_regs();
        var ctrl = regs.CTRL.read();
        const enabled = .{ ctrl.TE == .ENABLED, ctrl.RE == .ENABLED };

        ctrl.TE = .DISABLED;
        ctrl.RE = .DISABLED;

        regs.CTRL.write(ctrl);

        return enabled;
    }

    /// Enables the transmitter and/or the receiver depending on the parameters.
    pub fn set_enabled(uart: LP_UART, transmitter_enabled: bool, receiver_enabled: bool) void {
        const regs = uart.get_regs();

        var ctrl = regs.CTRL.read();
        ctrl.TE = if (transmitter_enabled) .ENABLED else .DISABLED;
        ctrl.RE = if (receiver_enabled) .ENABLED else .DISABLED;
        regs.CTRL.write(ctrl);
    }

    /// Sets the baudrate of the interface to the closest value possible to `baudrate`.
    /// A `baudrate` of 0 will disable the baudrate generator
    /// The final baudrate will be withing 3% of the desired one. If one cannot be found,
    /// this function errors.
    ///
    /// Whether a baudrate is available depends on the clock of the interface.
    // TODO: check if there is a risk of losing data since we disable then enable the receiver
    // TODO: tests with baudrate (see raspberry uart tests)
    pub fn set_baudrate(uart: LP_UART, baudrate: u32) ConfigError!void {
        const clk = uart.get_flexcomm().get_clock();
        const regs = uart.get_regs();
        var best_osr: u5 = 0;
        var best_sbr: u13 = 0;
        var best_diff = baudrate;

        if (baudrate == 0) {
            // both the receiver and transmitter must be disabled while changing the baudrate
            const te, const re = uart.disable();
            defer uart.set_enabled(te, re);

            var baud = regs.BAUD.read();
            baud.SBR = 0;
            baud.OSR = .DEFAULT;
            return regs.BAUD.write(baud);
        }

        // Computes the best value for osr and sbr that satisfies
        // baudrate = clk / (osr * sbr) with a 3% tolerance (same value as MCUXpresso)
        //
        // the doc of the SBR field of the `BAUD` register says it is
        // baudrate = clk / ((OSR + 1) * SBR), but I think they meant
        // baudrate = clk / ((BAUD[OSR] + 1) * sbr)
        for (4..33) |osr| {
            // the SDK's driver does a slightly different computation (((2 * clk / (baudrate * osr)) + 1) / 2)
            const sbr: u13 = @intCast(std.math.clamp(clk / (baudrate * osr), 1, std.math.maxInt(u13)));
            const computed_baudrate = clk / (osr * sbr);
            const diff = if (computed_baudrate > baudrate) computed_baudrate - baudrate else baudrate - computed_baudrate;

            if (diff <= best_diff) {
                best_diff = diff;
                best_osr = @intCast(osr);
                best_sbr = sbr;
            }
        }
        if (best_diff > 3 * baudrate / 100) {
            return error.UnsupportedBaudRate;
        }

        // both the receiver and transmitter must be disabled while changing the baudrate
        const te, const re = uart.disable();
        defer uart.set_enabled(te, re);

        var baud = regs.BAUD.read();
        baud.SBR = best_sbr;
        baud.OSR = @enumFromInt(best_osr - 1);
        baud.BOTHEDGE = if (best_osr <= 7) .ENABLED else .DISABLED;
        regs.BAUD.write(baud);
    }

    /// Return the current, real baudrate of the interface (see `set_baudrate` for more details).
    pub fn get_actual_baudrate(uart: LP_UART) f32 {
        const clk = uart.get_flexcomm().get_clock();
        const regs = uart.get_regs();
        const baud = regs.BAUD.read();

        var osr: u32 = @intFromEnum(baud.OSR);
        if (osr == 1 or osr == 2) unreachable; // reserved baudrates
        if (osr == 0) osr = 15;
        osr += 1;
        return @as(f32, clk) / (baud.SBR * osr);
    }

    fn get_n(uart: LP_UART) u4 {
        return @intFromEnum(uart);
    }

    pub fn get_regs(uart: LP_UART) RegTy {
        return LP_UART.Registers[uart.get_n()];
    }

    pub fn get_flexcomm(uart: LP_UART) FlexComm {
        return FlexComm.num(@intFromEnum(uart));
    }

    fn can_write(uart: LP_UART) bool {
        return uart.get_regs().STAT.read().TDRE == .NO_TXDATA;
    }

    pub fn can_read(uart: LP_UART) bool {
        return uart.get_regs().STAT.read().RDRF == .RXDATA;
    }

    fn is_tx_complete(uart: LP_UART) bool {
        return uart.get_regs().STAT.read().TC == .COMPLETE;
    }

    // TODO: error handling
    pub fn read(uart: LP_UART) u8 {
        const data: *volatile u8 = @ptrCast(&uart.get_regs().DATA);
        return data.*;
    }

    // TODO: other modes than 8-bits
    // TODO: non blocking
    // TODO: max retries
    // TODO: error handling
    pub fn transmit(uart: LP_UART, buf: []const u8) void {
        const regs = uart.get_regs();

        const data: *volatile u8 = @ptrCast(&regs.DATA);

        for (buf) |c| {
            while (!uart.can_write()) {}
            data.* = c;
        }

        while (!uart.is_tx_complete()) {}
    }

    pub fn writer(uart: LP_UART, buffer: []u8) Writer {
        return .init(uart, buffer);
    }

    pub const Writer = struct {
        interface: Io.Writer,
        uart: LP_UART,

        pub fn init(uart: LP_UART, buffer: []u8) Writer {
            return .{ .uart = uart, .interface = init_interface(buffer) };
        }

        fn init_interface(buffer: []u8) Io.Writer {
            return .{ .vtable = &.{ .drain = drain }, .buffer = buffer };
        }

        fn drain(io_w: *Io.Writer, data: []const []const u8, splat: usize) Io.Writer.Error!usize {
            const w: *Writer = @alignCast(@fieldParentPtr("interface", io_w));
            if (data.len == 0) return 0;

            w.uart.transmit(io_w.buffered());
            io_w.end = 0;

            var size: usize = 0;
            for (data[0 .. data.len - 1]) |buf| {
                w.uart.transmit(buf);
                size += buf.len;
            }
            for (0..splat) |_|
                w.uart.transmit(data[data.len - 1]);
            return size + splat * data[data.len - 1].len;
        }
    };

    pub fn reader(uart: LP_UART, buffer: []u8) Reader {
        return .init(uart, buffer);
    }

    pub const Reader = struct {
        interface: Io.Reader,
        uart: LP_UART,

        pub fn init(uart: LP_UART, buffer: []u8) Reader {
            return .{ .uart = uart, .interface = init_interface(buffer) };
        }

        fn init_interface(buffer: []u8) Io.Reader {
            return .{ .vtable = &.{ .stream = stream }, .buffer = buffer, .seek = 0, .end = 0 };
        }

        // TODO: config blocking / non blocking
        // TODO: configure timeout ?
        fn stream(io_r: *Io.Reader, w: *Io.Writer, limit: Io.Limit) Io.Reader.StreamError!usize {
            const r: *Reader = @alignCast(@fieldParentPtr("interface", io_r));
            const data = limit.slice(try w.writableSliceGreedy(1));
            for (data) |*byte| {
                while (!r.uart.can_read()) {}
                // TODO: read r8 and r9
                byte.* = r.uart.read();
            }
            w.advance(data.len);
            return data.len;
        }
    };
};
