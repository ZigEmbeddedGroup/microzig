const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const board = microzig.board;
const nrf = microzig.hal;
const time = nrf.time;

const rtt = microzig.cpu.rtt;
// Configure RTT with all default settings:
const rtt_instance = rtt.RTT(.{});

// Set up RTT channel 0 as a logger
var rtt_logger: ?rtt_instance.Writer = null;

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
    if (rtt_logger) |*writer| {
        const current_time = time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;
        writer.interface.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
        // Don't forget to flush! This never returns an error with how the Writer interface is implemented
        // so unreachable is appropriate here.
        writer.interface.flush() catch unreachable;
    }
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = log,
};

pub fn main() !void {
    board.init();

    // Nothing will work if you don't initialize the RTT control block first!
    rtt_instance.init();
    // Manually write some bytes to RTT up channel 0 so that it shows up in RTT Viewer
    _ = rtt_instance.write(0, "Hello RTT!\n");
    // Use std.log instead by instantiating a Writer our log function can use, here we aren't buffering
    // so all writes will go immediately to RTT up channel
    rtt_logger = rtt_instance.writer(0, &.{});

    // Instantiate a Reader for RTT down channel 0, giving it an internal buffer that is as big as the max
    // line length we expect. This allows us to utilize the std.Io.Reader interface to read until a delimiter.
    const max_line_len = 64;
    var rtt_reader_buffer: [max_line_len]u8 = undefined;
    var reader = rtt_instance.reader(0, &rtt_reader_buffer);

    // For blinking our LED on a timeout without blocking
    var blink_deadline = mdf.time.make_timeout_us(time.get_time_since_boot(), 500_000);
    var hello_deadline = mdf.time.make_timeout_us(time.get_time_since_boot(), 2_000_000);

    while (true) {
        const now = time.get_time_since_boot();

        // Toggle LED every 500 msec
        if (blink_deadline.is_reached_by(now)) {
            board.led1.toggle();
            blink_deadline = mdf.time.make_timeout_us(now, 500_000);
        }
        // Say hello every 2 seconds
        if (hello_deadline.is_reached_by(now)) {
            std.log.info("Hello!", .{});
            hello_deadline = mdf.time.make_timeout_us(now, 2_000_000);
        }
        // Attempt to read an entire line from RTT
        const line_maybe: ?[]const u8 = reader.interface.takeDelimiterExclusive('\n') catch |err| switch (err) {
            error.EndOfStream => null, // EndOfStream can be safely ignored, this just means there wasn't anything in the RTT buffer
            error.StreamTooLong => v: {
                std.log.err("Line overflowed internal buffer, discarding buffer", .{});
                // Need to purge whatever is in the buffer to read more data as takeDelimiterExclusive() on error
                // leaves the stream state unmodified
                reader.interface.tossBuffered();
                break :v null;
            },
            else => unreachable,
        };
        if (line_maybe) |line| {
            std.log.info("Got a line: \"{s}\"", .{line});
        }
    }
}
