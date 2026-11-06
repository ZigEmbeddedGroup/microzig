const std = @import("std");
const microzig = @import("microzig");

const cpu = microzig.cpu;
const afio = microzig.hal.afio;
const clocks = microzig.hal.clocks;
const dma = microzig.hal.dma;
const gpio = microzig.hal.gpio;
const Peripherals = microzig.hal.Peripherals;

pub const TransmitError = error{Timeout};
pub const ReceiveError = error{
    OverrunError,
    FramingError,
    ParityError,
    NoiseError,
    Timeout,
};

const Function = enum { tx, rx, ck, cts, rts };

const Group = afio.Group(Peripherals.USART, Function);

/// Pin alternate-function mapping, see `CH32H417DS0.pdf` Table 2-2-9.
/// Any combination not listed here is rejected by `af_for` at compile time.
const af_table = [_]Group{
    // USART1
    .{ .instance = .USART1, .function = .tx, .pins = &.{
        afio.pin(.GPIOA, 9, 7), afio.pin(.GPIOB, 6, 7), afio.pin(.GPIOB, 14, 4), afio.pin(.GPIOD, 13, 14),
    } },
    .{ .instance = .USART1, .function = .rx, .pins = &.{
        afio.pin(.GPIOA, 10, 7), afio.pin(.GPIOB, 7, 7), afio.pin(.GPIOB, 15, 4), afio.pin(.GPIOD, 12, 14),
    } },
    .{ .instance = .USART1, .function = .ck, .pins = &.{
        afio.pin(.GPIOA, 8, 7), afio.pin(.GPIOD, 11, 14),
    } },
    .{ .instance = .USART1, .function = .rts, .pins = &.{
        afio.pin(.GPIOA, 12, 7), afio.pin(.GPIOD, 14, 14),
    } },
    .{ .instance = .USART1, .function = .cts, .pins = &.{
        afio.pin(.GPIOA, 11, 7), afio.pin(.GPIOD, 15, 14),
    } },

    // USART2
    .{ .instance = .USART2, .function = .tx, .pins = &.{
        afio.pin(.GPIOA, 2, 7), afio.pin(.GPIOD, 5, 7),
    } },
    .{ .instance = .USART2, .function = .rx, .pins = &.{
        afio.pin(.GPIOA, 3, 7), afio.pin(.GPIOD, 6, 7),
    } },
    .{ .instance = .USART2, .function = .ck, .pins = &.{
        afio.pin(.GPIOA, 4, 7), afio.pin(.GPIOD, 7, 7),
    } },
    .{ .instance = .USART2, .function = .rts, .pins = &.{
        afio.pin(.GPIOA, 1, 7), afio.pin(.GPIOD, 4, 7),
    } },
    .{ .instance = .USART2, .function = .cts, .pins = &.{
        afio.pin(.GPIOA, 0, 7), afio.pin(.GPIOD, 3, 7),
    } },

    // USART3
    .{ .instance = .USART3, .function = .tx, .pins = &.{
        afio.pin(.GPIOB, 10, 7), afio.pin(.GPIOC, 10, 7), afio.pin(.GPIOD, 8, 7), afio.pin(.GPIOA, 13, 4),
    } },
    .{ .instance = .USART3, .function = .rx, .pins = &.{
        afio.pin(.GPIOB, 11, 7), afio.pin(.GPIOC, 11, 7), afio.pin(.GPIOD, 9, 7), afio.pin(.GPIOA, 14, 4),
    } },
    .{ .instance = .USART3, .function = .ck, .pins = &.{
        afio.pin(.GPIOB, 12, 7), afio.pin(.GPIOC, 12, 7), afio.pin(.GPIOD, 10, 7), afio.pin(.GPIOA, 11, 4),
    } },
    .{ .instance = .USART3, .function = .rts, .pins = &.{
        afio.pin(.GPIOB, 14, 7), afio.pin(.GPIOD, 12, 7), afio.pin(.GPIOA, 12, 4),
    } },
    .{ .instance = .USART3, .function = .cts, .pins = &.{
        afio.pin(.GPIOB, 13, 7), afio.pin(.GPIOD, 11, 7), afio.pin(.GPIOA, 15, 4),
    } },

    // USART4
    .{ .instance = .USART4, .function = .tx, .pins = &.{
        afio.pin(.GPIOF, 4, 7), afio.pin(.GPIOC, 6, 7),
    } },
    .{ .instance = .USART4, .function = .rx, .pins = &.{
        afio.pin(.GPIOF, 3, 7), afio.pin(.GPIOC, 7, 7),
    } },
    .{ .instance = .USART4, .function = .ck, .pins = &.{
        afio.pin(.GPIOF, 1, 7), afio.pin(.GPIOC, 8, 7),
    } },
    .{ .instance = .USART4, .function = .rts, .pins = &.{
        afio.pin(.GPIOF, 2, 7), afio.pin(.GPIOE, 0, 7),
    } },
    .{ .instance = .USART4, .function = .cts, .pins = &.{
        afio.pin(.GPIOF, 0, 7), afio.pin(.GPIOE, 1, 7),
    } },

    // USART5
    .{ .instance = .USART5, .function = .tx, .pins = &.{
        afio.pin(.GPIOE, 3, 11), afio.pin(.GPIOE, 0, 4),
    } },
    .{ .instance = .USART5, .function = .rx, .pins = &.{
        afio.pin(.GPIOE, 2, 4), afio.pin(.GPIOF, 5, 4),
    } },
    .{ .instance = .USART5, .function = .ck, .pins = &.{
        afio.pin(.GPIOE, 15, 11), afio.pin(.GPIOD, 6, 11),
    } },
    .{ .instance = .USART5, .function = .rts, .pins = &.{
        afio.pin(.GPIOD, 7, 4),
    } },
    .{ .instance = .USART5, .function = .cts, .pins = &.{
        afio.pin(.GPIOE, 1, 4),
    } },

    // USART6
    .{ .instance = .USART6, .function = .tx, .pins = &.{
        afio.pin(.GPIOA, 0, 8), afio.pin(.GPIOA, 12, 6), afio.pin(.GPIOB, 9, 8), afio.pin(.GPIOC, 10, 8), afio.pin(.GPIOD, 1, 8),
    } },
    .{ .instance = .USART6, .function = .rx, .pins = &.{
        afio.pin(.GPIOA, 1, 8), afio.pin(.GPIOA, 11, 6), afio.pin(.GPIOB, 8, 8), afio.pin(.GPIOC, 11, 8), afio.pin(.GPIOD, 0, 8),
    } },
    .{ .instance = .USART6, .function = .ck, .pins = &.{
        afio.pin(.GPIOA, 2, 3), afio.pin(.GPIOA, 10, 6), afio.pin(.GPIOB, 10, 9), afio.pin(.GPIOE, 2, 8), afio.pin(.GPIOD, 3, 8),
    } },
    .{ .instance = .USART6, .function = .rts, .pins = &.{
        afio.pin(.GPIOA, 15, 8), afio.pin(.GPIOB, 14, 8),
    } },
    .{ .instance = .USART6, .function = .cts, .pins = &.{
        afio.pin(.GPIOB, 0, 8), afio.pin(.GPIOB, 15, 8),
    } },

    // USART7
    .{ .instance = .USART7, .function = .tx, .pins = &.{
        afio.pin(.GPIOB, 6, 14), afio.pin(.GPIOB, 13, 14), afio.pin(.GPIOC, 12, 8),
    } },
    .{ .instance = .USART7, .function = .rx, .pins = &.{
        afio.pin(.GPIOB, 5, 14), afio.pin(.GPIOB, 12, 14), afio.pin(.GPIOD, 2, 8),
    } },
    .{ .instance = .USART7, .function = .ck, .pins = &.{
        afio.pin(.GPIOB, 4, 14), afio.pin(.GPIOB, 14, 13), afio.pin(.GPIOD, 4, 8),
    } },
    .{ .instance = .USART7, .function = .rts, .pins = &.{
        afio.pin(.GPIOC, 8, 8),
    } },
    .{ .instance = .USART7, .function = .cts, .pins = &.{
        afio.pin(.GPIOC, 9, 8),
    } },

    // USART8
    .{ .instance = .USART8, .function = .tx, .pins = &.{
        afio.pin(.GPIOA, 15, 11), afio.pin(.GPIOB, 4, 11), afio.pin(.GPIOE, 8, 7), afio.pin(.GPIOF, 7, 7),
    } },
    .{ .instance = .USART8, .function = .rx, .pins = &.{
        afio.pin(.GPIOA, 8, 11), afio.pin(.GPIOB, 3, 11), afio.pin(.GPIOE, 7, 7), afio.pin(.GPIOF, 6, 7),
    } },
    .{ .instance = .USART8, .function = .ck, .pins = &.{
        afio.pin(.GPIOA, 14, 11), afio.pin(.GPIOB, 7, 10), afio.pin(.GPIOE, 6, 8), afio.pin(.GPIOF, 10, 7),
    } },
    .{ .instance = .USART8, .function = .rts, .pins = &.{
        afio.pin(.GPIOE, 9, 11), afio.pin(.GPIOF, 8, 7),
    } },
    .{ .instance = .USART8, .function = .cts, .pins = &.{
        afio.pin(.GPIOE, 10, 11), afio.pin(.GPIOF, 9, 7),
    } },
};

fn af_for(comptime instance: Peripherals.USART, comptime pin: gpio.Pin, comptime function: Function) u4 {
    return afio.af_for(&af_table, instance, pin, function);
}

pub const Usart = struct {
    instance: Peripherals.USART,

    // TODO: should I use @"5" or five?
    pub const WordBits = enum { five, six, seven, eight, nine };
    pub const StopBits = enum { one, half, two, one_and_half };
    pub const Parity = enum { none, even, odd };
    pub const FlowControl = enum { none, CTS, RTS, CTS_RTS };

    pub const Config = struct {
        tx_pin: gpio.Pin,
        rx_pin: gpio.Pin,
        baud_rate: u32 = 115200,
        word_bits: WordBits = .eight,
        stop_bits: StopBits = .one,
        parity: Parity = .none,
        flow_control: FlowControl = .none,

        tx_dma: bool = false,
        rx_dma: bool = false,
    };

    pub fn apply(comptime self: Usart, comptime cfg: Config) void {
        clocks.enable(Peripherals.to_peripheral(self.instance));

        cfg.tx_pin.apply(.{
            .mode = .{ .output = .alternate_function_push_pull },
            .speed = .max_50MHz,
            .pull = .disabled,
            .alternate_function = af_for(self.instance, cfg.tx_pin, .tx),
        });
        cfg.rx_pin.apply(.{
            .mode = .{ .input = .floating },
            .speed = .max_50MHz,
            .pull = .up,
            .alternate_function = af_for(self.instance, cfg.rx_pin, .rx),
        });

        const regs = Peripherals.to_reg(self.instance);
        regs.CTLR1.modify(.{ .UE = 0 });

        regs.CTLR2.modify(.{ .STOP = switch (cfg.stop_bits) {
            .one => 0b00,
            .half => 0b01,
            .two => 0b10,
            .one_and_half => 0b11,
        } });

        const word_m: u1 = switch (cfg.word_bits) {
            .five, .six, .seven, .eight => 0,
            .nine => 1,
        };
        const word_m_ext: u2 = switch (cfg.word_bits) {
            .five => 0b11,
            .six => 0b10,
            .seven => 0b01,
            .eight, .nine => 0b00,
        };
        const parity_enable: u1 = if (cfg.parity == .none) 0 else 1;
        const parity_select: u1 = switch (cfg.parity) {
            .none, .even => 0,
            .odd => 1,
        };

        regs.CTLR1.modify(.{
            .M = word_m,
            .M_EXT = word_m_ext,
            .PCE = parity_enable,
            .PS = parity_select,
            .TE = 1,
            .RE = 1,
        });

        regs.CTLR3.modify(.{
            .RTSE = if (cfg.flow_control == .RTS or cfg.flow_control == .CTS_RTS) 1 else 0,
            .CTSE = if (cfg.flow_control == .CTS or cfg.flow_control == .CTS_RTS) 1 else 0,
        });

        self.set_baudrate(cfg.baud_rate);
        regs.CTLR1.modify(.{ .UE = 1 });

        regs.CTLR3.modify(.{
            .DMAT = @intFromBool(cfg.tx_dma),
            .DMAR = @intFromBool(cfg.rx_dma),
        });
    }

    /// Sets the baud rate divisor. On CH32H417 the USART is
    /// clocked from HCLK and always uses 16x oversampling.
    pub fn set_baudrate(self: Usart, baud_rate: u32) void {
        const regs = Peripherals.to_reg(self.instance);
        const hclk: u64 = clocks.get_freqs().hclk;

        const integerdivider: u64 = (25 * hclk) / (4 * @as(u64, baud_rate));
        var brr: u32 = @intCast((integerdivider / 100) << 4);
        var fractional: u64 = integerdivider - (100 * @as(u64, brr >> 4));
        fractional = ((fractional * 16) + 50) / 100;

        if (fractional > 0xf) {
            brr += 1 << 4;
        } else {
            brr |= @intCast(fractional & 0xf);
        }

        regs.BRR.raw = brr;
    }

    pub inline fn is_writeable(self: Usart) bool {
        return Peripherals.to_reg(self.instance).STATR.read().TXE == 1;
    }

    pub inline fn is_readable(self: Usart) bool {
        return Peripherals.to_reg(self.instance).STATR.read().RXNE == 1;
    }

    pub inline fn is_tx_complete(self: Usart) bool {
        return Peripherals.to_reg(self.instance).STATR.read().TC == 1;
    }

    pub inline fn write_byte(self: Usart, byte: u8) void {
        Peripherals.to_reg(self.instance).DATAR.raw = @as(u32, byte);
    }

    pub inline fn read_byte(self: Usart) u8 {
        return @intCast(Peripherals.to_reg(self.instance).DATAR.read().DR);
    }

    /// Reads the error flags and clears them if any are set.
    ///
    /// NOTE: call this *before* `is_readable` / `read_byte`, or errors
    /// would be cleared.
    pub fn check_errors(self: Usart) ReceiveError!void {
        const regs = Peripherals.to_reg(self.instance);
        const status = regs.STATR.read();

        var err: ?ReceiveError = null;
        if (status.ORE == 1) {
            err = error.OverrunError;
        } else if (status.FE == 1) {
            err = error.FramingError;
        } else if (status.PE == 1) {
            err = error.ParityError;
        } else if (status.NE == 1) {
            err = error.NoiseError;
        }

        if (err) |e| {
            _ = regs.STATR.read();
            _ = regs.DATAR.read();
            return e;
        }
    }

    pub fn writev_blocking(self: Usart, payloads: []const []const u8) TransmitError!usize {
        var written: usize = 0;
        for (payloads) |payload| {
            for (payload) |byte| {
                while (!self.is_writeable()) {}
                self.write_byte(byte);
                written += 1;
            }
        }

        while (!self.is_tx_complete()) {}
        return written;
    }

    pub fn write_blocking(self: Usart, payload: []const u8) TransmitError!usize {
        return self.writev_blocking(&.{payload});
    }

    pub fn readv_blocking(self: Usart, buffers: []const []u8) ReceiveError!usize {
        var read: usize = 0;
        for (buffers) |buffer| {
            for (buffer) |*byte| {
                while (!self.is_readable()) {}
                try self.check_errors();
                byte.* = self.read_byte();
                read += 1;
            }
        }
        return read;
    }

    pub fn read_blocking(self: Usart, buffer: []u8) ReceiveError!usize {
        return self.readv_blocking(&.{buffer});
    }

    /// NOTE: Don't mix interrupt-driven reception with the blocking `read_*`
    /// functions on the same instance: they race on `DATAR`. Interrupt-driven
    /// RX combined with blocking TX is fine (opposite directions).
    pub const Interrupts = struct {
        /// RXNEIE: a byte has been received.
        rx: bool = false,
        /// IDLEIE: an idle line was detected (end of a burst).
        idle: bool = false,
        /// EIE + PEIE: overrun, framing, noise and parity errors.
        errors: bool = false,

        pub const none: Interrupts = .{};
        pub const all: Interrupts = .{ .rx = true, .idle = true, .errors = true };
    };

    pub fn set_interrupts(self: Usart, cfg: Interrupts) void {
        const regs = Peripherals.to_reg(self.instance);
        regs.CTLR1.modify(.{
            .RXNEIE = @intFromBool(cfg.rx),
            .IDLEIE = @intFromBool(cfg.idle),
            .PEIE = @intFromBool(cfg.errors),
        });
        regs.CTLR3.modify(.{ .EIE = @intFromBool(cfg.errors) });
    }

    /// TODO: is this eliminable?
    pub inline fn irq(self: Usart) cpu.Interrupt {
        return switch (self.instance) {
            .USART1 => .USART1,
            .USART2 => .USART2,
            .USART3 => .USART3,
            .USART4 => .USART4,
            .USART5 => .USART5,
            .USART6 => .USART6,
            .USART7 => .USART7,
            .USART8 => .USART8,
        };
    }

    pub fn enable_interrupt(comptime self: Usart) void {
        cpu.interrupt.enable(self.irq());
    }

    pub fn disable_interrupt(comptime self: Usart) void {
        cpu.interrupt.disable(self.irq());
    }

    pub inline fn is_idle(self: Usart) bool {
        return Peripherals.to_reg(self.instance).STATR.read().IDLE == 1;
    }

    /// Clears the IDLE flag (read `STATR`, then read `DATAR`).
    pub fn clear_idle(self: Usart) void {
        const regs = Peripherals.to_reg(self.instance);
        _ = regs.STATR.read();
        _ = regs.DATAR.read();
    }

    pub fn dma_target(self: Usart, kind: enum { tx, rx }) dma.Target {
        const request: dma.Request = switch (self.instance) {
            .USART1 => if (kind == .tx) .USART1_TX else .USART1_RX,
            .USART2 => if (kind == .tx) .USART2_TX else .USART2_RX,
            .USART3 => if (kind == .tx) .USART3_TX else .USART3_RX,
            .USART4 => if (kind == .tx) .USART4_TX else .USART4_RX,
            .USART5 => if (kind == .tx) .USART5_TX else .USART5_RX,
            .USART6 => if (kind == .tx) .USART6_TX else .USART6_RX,
            .USART7 => if (kind == .tx) .USART7_TX else .USART7_RX,
            .USART8 => if (kind == .tx) .USART8_TX else .USART8_RX,
        };
        return .{
            .addr = @intFromPtr(&Peripherals.to_reg(self.instance).DATAR),
            .request = request,
        };
    }

    pub const Writer = struct {
        usart: Usart,
        interface: std.Io.Writer,
    };

    pub const Reader = struct {
        usart: Usart,
        interface: std.Io.Reader,
    };

    pub fn writer(self: Usart, buffer: []u8) Writer {
        return .{
            .usart = self,
            .interface = .{
                .buffer = buffer,
                .vtable = &.{ .drain = drain },
            },
        };
    }

    pub fn reader(self: Usart, buffer: []u8) Reader {
        return .{
            .usart = self,
            .interface = .{
                .buffer = buffer,
                .seek = 0,
                .end = 0,
                .vtable = &.{ .stream = stream },
            },
        };
    }

    pub fn init_logger(self: Usart) void {
        usart_logger = self.writer(&logger_buffer);
    }
};

pub const usart1 = Usart{ .instance = .USART1 };
pub const usart2 = Usart{ .instance = .USART2 };
pub const usart3 = Usart{ .instance = .USART3 };
pub const usart4 = Usart{ .instance = .USART4 };
pub const usart5 = Usart{ .instance = .USART5 };
pub const usart6 = Usart{ .instance = .USART6 };
pub const usart7 = Usart{ .instance = .USART7 };
pub const usart8 = Usart{ .instance = .USART8 };

fn drain(w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
    const usart_writer: *Usart.Writer = @fieldParentPtr("interface", w);
    const usart = usart_writer.usart;

    w.end -= usart.write_blocking(w.buffer[0..w.end]) catch |err| switch (err) {
        error.Timeout => return error.WriteFailed,
    };

    var n: usize = 0;
    n += usart.writev_blocking(data[0 .. data.len - 1]) catch |err| switch (err) {
        error.Timeout => return error.WriteFailed,
    };
    for (0..splat) |_|
        n += usart.write_blocking(data[data.len - 1]) catch |err| switch (err) {
            error.Timeout => return error.WriteFailed,
        };

    return n;
}

fn stream(r: *std.Io.Reader, w: *std.Io.Writer, limit: std.Io.Limit) std.Io.Reader.StreamError!usize {
    const usart_reader: *Usart.Reader = @fieldParentPtr("interface", r);
    if (limit == .nothing) return 0;

    var buf: [1]u8 = undefined;
    const n = usart_reader.usart.read_blocking(&buf) catch return error.ReadFailed;

    return switch (n) {
        0 => 0,
        1 => blk: {
            try w.writeByte(buf[0]);
            break :blk 1;
        },
        else => unreachable,
    };
}

var usart_logger: ?Usart.Writer = null;
var logger_buffer: [0]u8 = .{};

pub fn deinit_logger() void {
    usart_logger = null;
}

pub fn log(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
    comptime format: []const u8,
    args: anytype,
) void {
    const prefix = comptime switch (scope) {
        .default => "[" ++ level.asText() ++ "] ",
        else => "[" ++ level.asText() ++ "] (" ++ @tagName(scope) ++ ") ",
    };

    if (usart_logger) |*logger| {
        logger.interface.print(prefix ++ format ++ "\r\n", args) catch {};
    }
}
