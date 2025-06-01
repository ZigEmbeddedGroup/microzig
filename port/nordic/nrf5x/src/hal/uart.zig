const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");
const types = microzig.chip.types;

// TODO: UARTE0? Does DMA, just set rxd.ptr or txd.ptr. UART0 is deprecated (but still works?) on nRF52840
const UART_Regs = types.peripherals.UART0;

const gpio = @import("gpio.zig");
const time = @import("time.zig");

var uart_logger: ?UART.Writer = null;

pub fn num(n: u1) UART {
    return @enumFromInt(n);
}

/// Set a specific uart instance to be used for logging.
///
/// Allows system logging over uart via:
/// pub const microzig_options = microzig.Options{
///     .logFn = hal.uart.log,
/// };
pub fn init_logger(uart: UART) void {
    uart_logger = uart.writer();
    uart_logger.?.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
}

pub fn deinit_logger() void {
    uart_logger = null;
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

// TODO: On 52840 the CONFIG register has 1 bit for STOP bits
pub const Config = struct {
    rx_pin: gpio.Pin,
    tx_pin: gpio.Pin,
    control_flow: ?struct {
        cts_pin: gpio.Pin,
        rts_pin: gpio.Pin,
    } = null,
    parity: Parity = .exclude,
    baud_rate: BaudRate = .@"9600",
};

pub const Parity = enum {
    include,
    exclude,
};

pub const BaudRate = enum {
    @"1200",
    @"2400",
    @"4800",
    @"9600",
    @"14400",
    @"19200",
    @"28800",
    @"31250",
    @"38400",
    @"56000",
    @"57600",
    @"76800",
    @"115200",
    @"230400",
    @"250000",
    @"460800",
    @"921600",
    @"1000000",
};

pub const UART = enum(u1) {
    _,

    pub const Writer = std.io.GenericWriter(UART, TransmitError, generic_writer_fn);
    pub const Reader = std.io.GenericReader(UART, ReceiveError, generic_reader_fn);

    const TransmitError = error{};
    const ReceiveError = error{};

    inline fn get_regs(uart: UART) *volatile UART_Regs {
        return switch (@intFromEnum(uart)) {
            0 => peripherals.UART0,
            else => unreachable,
        };
    }

    pub fn apply(uart: UART, comptime config: Config) void {
        uart.disable();

        // TODO: Make these optional... could have rx only for example
        uart.set_txd(config.tx_pin);
        config.tx_pin.set_direction(.out);
        config.tx_pin.put(1);
        uart.set_rxd(config.rx_pin);
        const hwfc = if (config.control_flow) |cf| blk: {
            uart.set_cts(cf.cts_pin);
            config.uart_cts.set_direction(.in);
            uart.set_rts(cf.rts_pin);
            config.uart_rts.set_direction(.out);
            config.uart_rts.put(1);
            break :blk true;
        } else false;

        uart.set_baud_rate(config.baud_rate);

        const regs = uart.get_regs();
        regs.CONFIG.modify(.{
            .HWFC = if (hwfc)
                .Enabled
            else
                .Disabled,
            .PARITY = switch (config.parity) {
                .include => .Included,
                .exclude => .Excluded,
            },
        });

        uart.enable();
    }

    fn set_txd(uart: UART, pin: gpio.Pin) void {
        const regs = uart.get_regs();
        switch (compatibility.chip) {
            .nrf52 => regs.PSELTXD.raw = @intFromEnum(pin),
            .nrf52840 => regs.PSEL.TXD.write(.{
                .PIN = pin.index(),
                .PORT = pin.port(),
                .CONNECT = .Connected,
            }),
        }
    }

    fn set_rxd(uart: UART, pin: gpio.Pin) void {
        const regs = uart.get_regs();
        switch (compatibility.chip) {
            .nrf52 => regs.PSELRXD.raw = @intFromEnum(pin),
            .nrf52840 => regs.PSEL.RXD.write(.{
                .PIN = pin.index(),
                .PORT = pin.port(),
                .CONNECT = .Connected,
            }),
        }
    }

    fn set_cts(uart: UART, pin: gpio.Pin) void {
        const regs = uart.get_regs();
        switch (compatibility.chip) {
            .nrf52 => regs.PSELCTS.raw = @intFromEnum(pin),
            .nrf52840 => regs.PSEL.CTS.write(.{
                .PIN = pin.index(),
                .PORT = pin.port(),
                .CONNECT = @enumFromInt(0), // 0 means connected lol
            }),
        }
    }

    fn set_rts(uart: UART, pin: gpio.Pin) void {
        const regs = uart.get_regs();
        switch (compatibility.chip) {
            .nrf52 => regs.PSELRTS.raw = @intFromEnum(pin),
            .nrf52840 => regs.PSEL.RTS.write(.{
                .PIN = pin.index(),
                .PORT = pin.port(),
                .CONNECT = @enumFromInt(0), // 0 means connected lol
            }),
        }
    }

    pub fn set_baud_rate(uart: UART, baud_rate: BaudRate) void {
        const regs = uart.get_regs();
        regs.BAUDRATE.write(.{
            .BAUDRATE = switch (baud_rate) {
                .@"1200" => .Baud1200,
                .@"2400" => .Baud2400,
                .@"4800" => .Baud4800,
                .@"9600" => .Baud9600,
                .@"14400" => .Baud14400,
                .@"19200" => .Baud19200,
                .@"28800" => .Baud28800,
                .@"31250" => .Baud31250,
                .@"38400" => .Baud38400,
                .@"56000" => .Baud56000,
                .@"57600" => .Baud57600,
                .@"76800" => .Baud76800,
                .@"115200" => .Baud115200,
                .@"230400" => .Baud230400,
                .@"250000" => .Baud250000,
                .@"460800" => .Baud460800,
                .@"921600" => .Baud921600,
                .@"1000000" => .Baud1M,
            },
        });
    }

    pub fn enable(uart: UART) void {
        const regs = uart.get_regs();
        regs.ENABLE.write(.{ .ENABLE = .Enabled });
    }

    pub fn disable(uart: UART) void {
        const regs = uart.get_regs();
        regs.ENABLE.write(.{ .ENABLE = .Disabled });
    }

    pub fn read_blocking(uart: UART, buffer: []u8) void {
        uart.start_rx_task();
        defer uart.stop_rx_task();

        for (buffer) |*b| {
            // NOTE: Page 821
            // > To prevent loss of incoming data, the RXD register must only be read one time
            // > following every RXDRDY event.
            while (!uart.have_rx_rdy_event()) {}
            uart.clear_rx_rdy_event();

            b.* = uart.read_rxd();
        }
    }

    pub fn write_blocking(uart: UART, buffer: []const u8) void {
        uart.start_tx_task();
        defer uart.stop_tx_task();

        for (buffer) |b| {
            uart.clear_tx_rdy_event();

            uart.write_txd(b);

            while (!uart.have_tx_rdy_event()) {}
        }
    }

    pub fn reader(uart: UART) Reader {
        return .{ .context = uart };
    }

    pub fn writer(uart: UART) Writer {
        return .{ .context = uart };
    }

    fn generic_writer_fn(uart: UART, buffer: []const u8) TransmitError!usize {
        uart.write_blocking(buffer);
        return buffer.len;
    }

    fn generic_reader_fn(uart: UART, buffer: []u8) ReceiveError!usize {
        uart.read_blocking(buffer);
        return buffer.len;
    }

    pub fn read_rxd(uart: UART) u8 {
        return uart.get_regs().RXD.read().RXD;
    }

    pub fn write_txd(uart: UART, byte: u8) void {
        const regs = uart.get_regs();
        return regs.TXD.write(.{ .TXD = byte });
    }

    pub fn start_rx_task(uart: UART) void {
        const regs = uart.get_regs();
        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });
    }

    pub fn stop_rx_task(uart: UART) void {
        const regs = uart.get_regs();
        regs.TASKS_STOPRX.write(.{ .TASKS_STOPRX = .Trigger });
    }

    pub fn start_tx_task(uart: UART) void {
        const regs = uart.get_regs();
        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });
    }

    pub fn stop_tx_task(uart: UART) void {
        const regs = uart.get_regs();
        regs.TASKS_STOPTX.write(.{ .TASKS_STOPTX = .Trigger });
    }

    pub fn suspend_task(uart: UART) void {
        const regs = uart.get_regs();
        regs.TASKS_SUSPEND.write(.{ .TASKS_SUSPEND = .Trigger });
    }

    pub fn have_rx_rdy_event(uart: UART) bool {
        return uart.get_regs().EVENTS_RXDRDY.read().EVENTS_RXDRDY == .Generated;
    }

    pub fn clear_rx_rdy_event(uart: UART) void {
        uart.get_regs().EVENTS_RXDRDY.raw = 0;
    }

    pub fn have_tx_rdy_event(uart: UART) bool {
        return uart.get_regs().EVENTS_TXDRDY.read().EVENTS_TXDRDY == .Generated;
    }

    pub fn clear_tx_rdy_event(uart: UART) void {
        uart.get_regs().EVENTS_TXDRDY.raw = 0;
    }

    pub fn have_rx_timeout_event(uart: UART) bool {
        return uart.get_regs().EVENTS_RXTO.read().EVENTS_RXTO == .Generated;
    }

    pub fn clear_rx_timeout_event(uart: UART) void {
        uart.get_regs().EVENTS_RXTO.raw = 0;
    }
};
