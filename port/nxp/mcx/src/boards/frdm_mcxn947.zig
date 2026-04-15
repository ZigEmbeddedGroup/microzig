const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const FlexComm = hal.FlexComm;
const Pin = hal.Pin;

/// The GPIO corresponding to a led color.
/// Putting a 0 to a led output enables it and a 1 disables it (see board schematic for why).
///
/// Example:
/// ```zig
/// const red = Led.Red;
/// red.init();
/// red.set_direction(.out);
/// red.put(1); // toggle off the led
/// ```
pub const Led = struct {
    pub const Red = hal.GPIO.num(0, 10);
    pub const Green = hal.GPIO.num(0, 27);
    pub const Blue = hal.GPIO.num(1, 2);
};

/// See `init_debug_console`.
pub fn init_debug_console_pins() void {
    // FC4_P0
    Pin.num(1, 8).configure()
        .alt(2)
        .enable_input_buffer()
        .done();
    // FC4_P1
    Pin.num(1, 9).configure()
        .alt(2)
        .enable_input_buffer()
        .done();
}

/// Init the same debug console as in the official SDK.
/// Uses Uart to communicate (8bit, no parity, baudrate = 115200, one stop bit, lsb bit order).
///
/// If a `led` is provided, it is inited and will be set on by `panic` (if used) in case of a panic.
///
/// ```zig
/// pub const microzig_options = microzig.Options {
///     .log_level = .debug,
///     .logFn = get_log_fn("\n", .Default)
/// };
/// pub fn main() !void {
///     hal.Port.num(1).init();
///     init_debug_console_pins();
///     init_debug_console(Led.Red, &.{});
///
///     // You can now use `std.log`:
///     std.log.debug("====== Starting ======", .{});
/// ```
pub fn init_debug_console(led: ?hal.GPIO, writer_buffer: []u8) !void {
    if (led) |l| {
        l.init();
        l.set_direction(.out);
        l.put(1);
        panic_led = l;
    }

    FlexComm.num(4).set_clock(.FRO_12MHz, 1);
    const uart: FlexComm.LP_UART = try .init(4, .Default);
    uart_writer = uart.writer(writer_buffer);
}

pub const Colors = struct {
    debug: []const u8,
    info: []const u8,
    warn: []const u8,
    err: []const u8,

    bold: []const u8,
    reset: []const u8,

    pub const Default = Colors{
        .debug = "\u{001b}[34m", // blue
        .info = "",
        .warn = "\u{001b}[33m", // yellow
        .err = "\u{001b}[31m", // red
        .bold = "\u{001b}[1m",
        .reset = "\u{001b}[m",
    };

    pub const None = Colors{ .debug = "", .info = "", .warn = "", .err = "", .bold = "", .reset = "" };
};

pub var uart_writer: ?FlexComm.LP_UART.Writer = null;
pub var panic_led: ?hal.GPIO = null;

/// Returns a log function. The function will use `colors` (can be `.None` for no colors)
/// and append `terminator` at the end of each log (similar to `std.log.defaultLog`).
pub fn get_log_fn(comptime terminator: []const u8, comptime colors: Colors) @TypeOf(std.log.defaultLog) {
    return struct {
        pub fn log_fn(comptime level: std.log.Level, comptime scope: @TypeOf(.EnumLiteral), comptime format: []const u8, args: anytype) void {
            // TODO: log timestamp
            const color = comptime switch (level) {
                .debug => colors.debug,
                .info => colors.info,
                .warn => colors.warn,
                .err => colors.err,
            };
            const level_prefix = comptime "[" ++ colors.bold ++ color ++ level.asText() ++ colors.reset ++ "]";

            const prefix = comptime level_prefix ++ switch (scope) {
                .default => ": ",
                else => " (" ++ @tagName(scope) ++ "): ",
            };

            if (uart_writer) |*writer| {
                writer.interface.print(prefix ++ format ++ terminator, args) catch {};
                writer.interface.flush() catch {};
            }
        }
    }.log_fn;
}

/// Example panic handler.
/// Enable a led (if defined) and defaults to microzig's panic handler.
/// Useless if no panic led is defined.
///
/// See `init_debug_console` to define the led
///
/// How to enable:
/// ```zig
/// // In your main file
/// pub const panic = board.panic;
/// ```
pub const panic = std.debug.FullPanic(struct {
    pub fn panic_fn(message: []const u8, first_trace_address: ?usize) noreturn {
        if (panic_led) |led| led.put(0);
        return microzig.panic.call(message, first_trace_address);
    }
}.panicFn);
