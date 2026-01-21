const std = @import("std");
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

pub fn writer(buffer: []u8) std.Io.Writer {
    return .{
        .buffer = buffer,
        .vtable = &.{
            .drain = struct {
                fn drain(w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
                    const buffered = w.buffered();
                    if (buffered.len > 0) {
                        const n = write_buf(buffered) catch return error.WriteFailed;
                        _ = w.consume(n);
                    }

                    var n: usize = 0;
                    for (data[0 .. data.len - 1]) |buf| {
                        if (buf.len == 0) continue;
                        n += write_buf(buffered) catch return error.WriteFailed;
                    }

                    const splat_buf = data[data.len - 1];
                    if (splat > 0 and splat_buf.len > 0) {
                        for (0..splat) |_| {
                            n += write_buf(splat_buf) catch return error.WriteFailed;
                        }
                    }

                    return n;
                }

                var timed_out: bool = false;

                fn write_buf(buf: []const u8) error{Timeout}!usize {
                    if (tx_fifo_full()) {
                        if (timed_out) {
                            return error.Timeout;
                        }

                        try wait_for_flush();
                    } else {
                        timed_out = false;
                    }

                    for (buf) |byte| {
                        if (tx_fifo_full()) {
                            tx_fifo_flush();
                            try wait_for_flush();
                        }

                        tx_fifo_write(byte);
                    }

                    tx_fifo_flush();

                    return buf.len;
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
            }.drain,
        },
    };
}

/// USB Serial JTAG logger. To use this, add `.logFn = logger.log` to your
/// `microzig_options`.
pub const logger = struct {
    pub const Error = error{
        Timeout,
    };

    var log_writer = writer(&.{});

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

        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        log_writer.print(prefix ++ format ++ "\r\n", args) catch {};
    }
};
