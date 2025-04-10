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
        .padding = 0,
    });
}

/// USB Serial JTAG logger. To use this, add `.logFn = logger.logFn` to your `microzig_options`.
pub const logger = struct {
    pub const Error = error{
        Timeout,
    };
    pub const Writer = std.io.GenericWriter(void, Error, generic_writer_fn);

    const writer: Writer = .{ .context = {} };

    var timed_out: bool = false;

    fn generic_writer_fn(_: void, buffer: []const u8) Error!usize {
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

        for (buffer) |byte| {
            if (tx_fifo_full()) {
                tx_fifo_flush();
                try wait_for_flush();
            }

            tx_fifo_write(byte);
        }

        tx_fifo_flush();

        return buffer.len;
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

    pub fn logFn(
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
