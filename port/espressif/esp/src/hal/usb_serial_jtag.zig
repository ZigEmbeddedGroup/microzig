const std = @import("std");
const assert = std.debug.assert;
const microzig = @import("microzig");
const USB_SERIAL_JTAG = microzig.chip.peripherals.USB_DEVICE;

/// Returns `false` if data can be sent.
pub fn tx_fifo_full() bool {
    return USB_SERIAL_JTAG.EP1_CONF.read().SERIAL_IN_EP_DATA_FREE == 0;
}

/// Call this after you are done writing data. After `tx_fifo_full()` returns false
/// you can start sending more data.
pub fn tx_fifo_flush() void {
    USB_SERIAL_JTAG.EP1_CONF.modify(.{ .WR_DONE = 1 });
}

/// Writes one byte to the fifo.
pub fn tx_fifo_write(byte: u8) void {
    USB_SERIAL_JTAG.EP1.write(.{
        .RDWR_BYTE = byte,
    });
}

/// USB Serial JTAG logger. To use this, add `.logFn = logger.log` to your
/// `microzig_options`.
pub const logger = struct {
    var timed_out: bool = false;
    var buffer: [256]u8 = undefined;
    var writer = std.Io.Writer{
        .buffer = &buffer,
        .vtable = &.{
            .drain = logger.drain,
        },
    };

    fn drain(w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
        // bytes from buffer are not included in count.
        w.end -= write_blocking(w.buffer[0..w.end]) catch |err| switch (err) {
            error.Timeout => {
                logger.timed_out = true;
                return error.WriteFailed;
            },
        };
        assert(w.end == 0);

        var n: usize = 0;
        for (0..data.len - 1) |i| {
            n += write_blocking(data[i]) catch |err| switch (err) {
                error.Timeout => {
                    logger.timed_out = true;
                    return error.WriteFailed;
                },
            };
        }

        for (0..splat) |_|
            n += write_blocking(data[data.len - 1]) catch |err| switch (err) {
                error.Timeout => {
                    logger.timed_out = true;
                    return error.WriteFailed;
                },
            };

        return n;
    }

    fn write_blocking(data: []const u8) !usize {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        if (tx_fifo_full()) {
            if (timed_out) {
                return error.Timeout;
            }

            try wait_for_flush();
        } else {
            timed_out = false;
        }

        for (data) |byte| {
            if (tx_fifo_full()) {
                tx_fifo_flush();
                try wait_for_flush();
            }

            tx_fifo_write(byte);
        }

        tx_fifo_flush();

        return data.len;
    }

    fn wait_for_flush() error{Timeout}!void {
        var timeout: usize = 50_000;
        while (tx_fifo_full()) {
            if (timeout == 0) {
                timed_out = true;
                return error.Timeout;
            }
            timeout -= 1;
        }
    }

    pub fn log(
        comptime level: std.log.Level,
        comptime scope: @TypeOf(.EnumLiteral),
        comptime format: []const u8,
        args: anytype,
    ) void {
        const level_prefix = comptime level.asText();
        const prefix = comptime level_prefix ++ switch (scope) {
            .default => ": ",
            else => " (" ++ @tagName(scope) ++ "): ",
        };

        // TODO: add timestamp to log message
        writer.print(prefix ++ format ++ "\r\n", args) catch {};
    }
};
