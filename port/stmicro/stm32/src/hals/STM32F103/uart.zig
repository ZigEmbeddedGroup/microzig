//TODO: Half-Duplex (Single-Wire mode)
//TODO: Synchronous mode (For USART only)

const std = @import("std");
const time = @import("time.zig");
const microzig = @import("microzig");
const create_peripheral_enum = @import("util.zig").create_peripheral_enum;

const mdf = microzig.drivers;
const drivers = mdf.base;
const Duration = mdf.time.Duration;
const Deadline = mdf.time.Deadline;

const peripherals = microzig.chip.peripherals;
const usart_t = microzig.chip.types.peripherals.usart_v1.USART;
const M0 = microzig.chip.types.peripherals.usart_v1.M0;
const PS = microzig.chip.types.peripherals.usart_v1.PS;
const STOP = microzig.chip.types.peripherals.usart_v1.STOP;

pub const WordBits = enum {
    eight,
    //nine,
};

pub const StopBits = enum {
    one,
    half,
    two,
    one_and_half,
};

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const FlowControl = enum {
    none,
    CTS,
    RTS,
    CTS_RTS,
};

pub const ConfigError = error{
    InvalidUartNum,
    UnsupportedBaudRate,
    UnsupportedFlowControl,
};

pub const Config = struct {
    clock_speed: u32,
    baud_rate: u32 = 115200,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
    flow_control: FlowControl = .none,
};

pub const TransmitError = error{
    Timeout,
};

pub const ReceiveError = error{
    OverrunError,
    NoiseError,
    ParityError,
    FramingError,
    Timeout,
};

pub const ErrorStates = packed struct(u4) {
    overrun_error: bool = false,
    noise_error: bool = false,
    parity_error: bool = false,
    framing_error: bool = false,
};

fn comptime_fail_or_error(msg: []const u8, fmt_args: anytype, err: ConfigError) ConfigError {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, fmt_args));
    } else {
        return err;
    }
}

pub const Instances = create_peripheral_enum("ART", null);
fn get_regs(comptime instance: Instances) *volatile usart_t {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

pub const UART = struct {
    pub const Writer = std.io.GenericWriter(*const UART, TransmitError, generic_writer_fn);
    pub const Reader = std.io.GenericReader(*const UART, ReceiveError, generic_reader_fn);

    regs: *volatile usart_t,
    ///Returns an error at runtime, and raises a compile error at comptime.
    fn validate_baudrate(baud_rate: u32, peri_freq: u32) ConfigError!void {
        const val: f32 = @as(f32, @floatFromInt(peri_freq)) / (@as(f32, @floatFromInt(baud_rate)) * 16);
        if (val > 4095) {
            return comptime_fail_or_error(
                "Baud {d} is too low for Clock {d}",
                .{ baud_rate, peri_freq },
                ConfigError.UnsupportedBaudRate,
            );
        } else if (val < 1.0) {
            return comptime_fail_or_error(
                "Baud {d} is too High for Clock {d}",
                .{ baud_rate, peri_freq },
                ConfigError.UnsupportedBaudRate,
            );
        }
    }

    //the only difference between UART 4 ​​and 5 and USARTs in asynchronous mode is
    // the lack of hardware control flow
    //NOTE: most devices don't have UART 4/5, should we drop support for them?
    fn validate_config(uart: *const UART, config: Config) ConfigError!void {
        const uart_num = @intFromPtr(uart.regs);
        //check for the base address of the UARTx
        if ((uart_num == 0x40005000) or (uart_num == 0x40004c00)) {
            if ((config.flow_control != .none)) {
                return comptime_fail_or_error("UART 4/5 does no have Hardware control flow", .{}, ConfigError.UnsupportedFlowControl);
            }
        }
    }

    pub fn apply(comptime uart: *const UART, comptime config: Config) void {
        comptime validate_baudrate(config.baud_rate, config.clock_speed) catch unreachable;
        comptime validate_config(uart, config) catch unreachable;
        uart.apply_internal(config);
    }

    pub fn apply_runtime(uart: *const UART, config: Config) !void {
        try validate_baudrate(config.baud_rate, config.clock_speed);
        try validate_config(uart, config);
        uart.apply_internal(config);
    }

    fn apply_internal(uart: *const UART, config: Config) void {
        const regs = uart.regs;
        uart.set_baudrate(config.baud_rate, config.clock_speed);
        uart.set_wordbits(config.word_bits);
        uart.set_parity(config.parity);
        uart.set_stopbits(config.stop_bits);
        uart.set_flowcontrol(config.flow_control);
        regs.CR1.modify(.{
            .UE = 1,
            .RE = 1,
            .TE = 1,
        });
    }

    fn set_baudrate(uart: *const UART, baudrate: u32, clock_fraq: u32) void {
        const regs = uart.regs;
        const baud: f32 = @as(f32, @floatFromInt(clock_fraq)) / (@as(f32, @floatFromInt(baudrate)) * 16);

        var mantissa: u32 = @intFromFloat(baud);
        var frac: u32 = @intFromFloat(@floor((baud - @as(f32, @floatFromInt(mantissa))) * 16));
        mantissa += @divTrunc(frac, 16);
        frac = frac % 16;

        const value: u32 = 0xFFFF & ((mantissa << 4) | frac);
        regs.BRR.raw = value;
    }

    fn set_wordbits(uart: *const UART, word: WordBits) void {
        const regs = uart.regs;
        regs.CR1.modify(.{
            .M0 = @as(M0, @enumFromInt(@intFromEnum(word))),
        });
    }

    fn set_stopbits(uart: *const UART, stops: StopBits) void {
        const regs = uart.regs;
        regs.CR2.modify(.{
            .STOP = @as(STOP, @enumFromInt(@intFromEnum(stops))),
        });
    }

    fn set_parity(uart: *const UART, parity: Parity) void {
        const regs = uart.regs;
        switch (parity) {
            .none => {
                regs.CR1.modify(.{
                    .PCE = 0,
                });
            },
            else => |ps| {
                const val: PS = @enumFromInt(@intFromEnum(ps) - 1);
                regs.CR1.modify(.{
                    .PCE = 1,
                    .PS = val,
                });
            },
        }
    }

    fn set_flowcontrol(uart: *const UART, flowcontrol: FlowControl) void {
        const regs = uart.regs;
        var RTS: u1 = 0;
        var CTS: u1 = 0;

        switch (flowcontrol) {
            .CTS => CTS = 1,
            .RTS => RTS = 1,
            .CTS_RTS => {
                CTS = 1;
                RTS = 1;
            },
            else => {},
        }

        regs.CR3.modify(.{
            .RTSE = RTS,
            .CTSE = CTS,
        });
    }

    pub inline fn is_readable(uart: *const UART) bool {
        return (0 != uart.regs.SR.read().RXNE);
    }

    pub inline fn is_writeable(uart: *const UART) bool {
        return (0 != uart.regs.SR.read().TXE);
    }

    pub fn writev_blocking(uart: *const UART, payloads: []const []const u8, timeout: ?Duration) TransmitError!usize {
        const deadline = Deadline.init_relative(time.get_time_since_boot(), timeout);
        const regs = uart.regs;
        var n: usize = 0;
        for (payloads) |pkgs| {
            for (pkgs) |byte| {
                while (!uart.is_writeable()) {
                    if (deadline.is_reached_by(time.get_time_since_boot())) return error.Timeout;
                }
                regs.DR.raw = @intCast(byte);
                n += 1;
            }
        }
        return n;
    }

    pub fn readv_blocking(uart: *const UART, buffers: []const []u8, timeout: ?Duration) ReceiveError!usize {
        const deadline = Deadline.init_relative(time.get_time_since_boot(), timeout);
        const regs = uart.regs;
        var n: usize = 0;
        for (buffers) |buf| {
            for (buf) |*bytes| {
                while (!uart.is_readable()) {
                    if (deadline.is_reached_by(time.get_time_since_boot())) return n;
                }
                const SR = regs.SR.read();

                if (SR.ORE != 0) {
                    return error.OverrunError;
                } else if (SR.NE != 0) {
                    return error.NoiseError;
                } else if (SR.FE != 0) {
                    return error.FramingError;
                } else if (SR.PE != 0) {
                    return error.ParityError;
                }
                const rx = regs.DR.raw;

                bytes.* = @intCast(0xFF & rx);
                n += 1;
            }
        }
        return n;
    }

    pub fn get_errors(uart: *const UART) ErrorStates {
        const regs = uart.regs;
        const read_val = regs.SR.read();
        return .{
            .overrun_error = read_val.ORE == 1,
            .noise_error = read_val.NE == 1,
            .parity_error = read_val.PE == 1,
            .framing_error = read_val.FE == 1,
        };
    }

    pub inline fn clear_errors(uart: *const UART) void {
        const regs = uart.regs;
        std.mem.doNotOptimizeAway(regs.SR.raw);
        std.mem.doNotOptimizeAway(regs.DR.raw);
    }

    pub fn write_blocking(uart: *const UART, data: []const u8, timeout: ?Duration) TransmitError!usize {
        return uart.writev_blocking(&.{data}, timeout);
    }

    pub fn read_blocking(uart: *const UART, data: []u8, timeout: ?Duration) ReceiveError!usize {
        return uart.readv_blocking(&.{data}, timeout);
    }

    pub fn writer(uart: *const UART) Writer {
        return .{ .context = uart };
    }

    pub fn reader(uart: *const UART) Reader {
        return .{ .context = uart };
    }
    fn generic_writer_fn(uart: *const UART, buffer: []const u8) TransmitError!usize {
        return uart.write_blocking(buffer, null);
    }

    fn generic_reader_fn(uart: *const UART, buffer: []u8) ReceiveError!usize {
        return uart.read_blocking(buffer, null);
    }

    pub fn init(comptime uart: Instances) UART {
        return .{ .regs = get_regs(uart) };
    }
};

var uart_logger: ?UART.Writer = null;

///Set a specific uart instance to be used for logging.
///
///Allows system logging over uart via:
///pub const microzig_options = .{
///    .logFn = hal.uart.log,
///};
pub fn init_logger(uart: *const UART) void {
    uart_logger = uart.writer();
    if (uart_logger) |logger| {
        logger.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
    }
}

///Disables logging via the uart instance.
pub fn deinit_logger() void {
    uart_logger = null;
}

pub fn log(comptime level: std.log.Level, comptime scope: @TypeOf(.EnumLiteral), comptime format: []const u8, args: anytype) void {
    const prefix = comptime level.asText() ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (uart_logger) |uart| {
        uart.print(prefix ++ format ++ "\r\n", args) catch {};
    }
}
