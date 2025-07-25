const std = @import("std");
const Io = std.Io;

pub const Elf = @import("Elf.zig");
pub const DebugInfo = @import("DebugInfo.zig");

pub const Writer = struct {
    interface: Io.Writer,

    annotator: Annotator = .init,
    out_stream: *Io.Writer,
    out_tty_config: std.io.tty.Config,
    elf: Elf,
    debug_info: *DebugInfo,

    pub fn init(buffer: []u8, out_stream: *Io.Writer, out_tty_config: std.io.tty.Config, elf: Elf, debug_info: *DebugInfo) Writer {
        return .{
            .interface = init_interface(buffer),
            .out_stream = out_stream,
            .out_tty_config = out_tty_config,
            .elf = elf,
            .debug_info = debug_info,
        };
    }

    pub fn init_interface(buffer: []u8) Io.Writer {
        return .{
            .vtable = &.{
                .drain = drain,
                .sendFile = Io.Writer.unimplementedSendFile,
            },
            .buffer = buffer,
        };
    }

    pub fn drain(io_w: *Io.Writer, data: []const []const u8, splat: usize) Io.Writer.Error!usize {
        const w: *Writer = @alignCast(@fieldParentPtr("interface", io_w));

        var len: usize = 0;

        const buffered = io_w.buffered();
        if (buffered.len != 0) {
            errdefer _ = io_w.consume(len);

            w.annotator.process(buffered, w.out_stream, w.out_tty_config, w.elf, w.debug_info) catch return error.WriteFailed;
            len += buffered.len;
        }

        for (data[0 .. data.len - 1]) |buf| {
            if (buf.len == 0) continue;

            errdefer _ = io_w.consume(len);

            w.annotator.process(buf, w.out_stream, w.out_tty_config, w.elf, w.debug_info) catch return error.WriteFailed;
            len += buf.len;
        }

        const pattern = data[data.len - 1];
        if (pattern.len == 0 or splat == 0) return io_w.consume(len);

        for (0..splat) |_| {
            errdefer _ = io_w.consume(len);

            w.annotator.process(pattern, w.out_stream, w.out_tty_config, w.elf, w.debug_info) catch return error.WriteFailed;
        }
        len += splat * pattern.len;

        return io_w.consume(len);
    }
};

/// Takes data and displays it, as well as annotating addresses where it's
/// necessary.
pub const Annotator = struct {
    state: State,

    pub const init: Annotator = .{ .state = .waiting };

    pub const State = union(enum) {
        waiting,
        reading_address: struct {
            buf: [16]u8,
            digit_count: usize,
        },
        print_address: u64,
    };

    pub fn process(
        self: *Annotator,
        data: []const u8,
        out_stream: *Io.Writer,
        out_tty_config: std.io.tty.Config,
        elf: Elf,
        debug_info: *DebugInfo,
    ) !void {
        var index: usize = 0;

        loop: switch (self.state) {
            .waiting => {
                if (std.mem.indexOf(u8, data[index..], "0x")) |start_hex_index| {
                    try out_stream.writeAll(data[index..][0 .. start_hex_index + 2]);
                    index += start_hex_index + 2;

                    continue :loop .{ .reading_address = .{
                        .buf = undefined,
                        .digit_count = 0,
                    } };
                }
                self.state = .waiting;
            },
            .reading_address => |old_state| {
                var new_state = old_state;

                while (index < data.len) : ({
                    index += 1;
                    new_state.digit_count += 1;
                }) {
                    if (std.ascii.isHex(data[index])) {
                        if (new_state.digit_count >= 16) {
                            continue :loop .waiting;
                        }

                        new_state.buf[new_state.digit_count] = data[index];
                    } else {
                        if (new_state.digit_count == 8 or new_state.digit_count == 16) {
                            const address = std.fmt.parseInt(
                                u64,
                                new_state.buf[0..new_state.digit_count],
                                16,
                            ) catch unreachable; // we know this is valid

                            continue :loop .{ .print_address = address };
                        } else {
                            continue :loop .waiting;
                        }
                    }

                    try out_stream.writeByte(data[index]);
                }

                self.state = .{ .reading_address = new_state };
            },
            .print_address => |address| {
                if (std.mem.indexOfScalar(u8, data[index..], '\n')) |new_line_index| {
                    if (elf.is_address_executable(address)) {
                        const query_result = debug_info.query(address);

                        try out_stream.writeAll(data[index..][0 .. new_line_index + 1]);
                        index += new_line_index + 1;

                        try output_location_info(out_stream, out_tty_config, address, query_result);
                        if (query_result.source_location) |src_loc| {
                            try output_source_line(out_stream, out_tty_config, src_loc);
                        }
                    }

                    continue :loop .waiting;
                }

                self.state = .{ .print_address = address };
            },
        }

        try out_stream.writeAll(data[index..]);

        try out_stream.flush();
    }
};

fn output_location_info(
    out_stream: *Io.Writer,
    out_tty_config: std.io.tty.Config,
    address: u64,
    query_result: DebugInfo.QueryResult,
) !void {
    try out_tty_config.setColor(out_stream, .bold);

    if (query_result.source_location) |src_loc| {
        try out_stream.print("{f}:{}:{}", .{
            std.fs.path.fmtJoin(&.{ src_loc.dir_path, src_loc.file_path }),
            src_loc.line,
            src_loc.column,
        });
    } else {
        try out_stream.writeAll("???:?:?");
    }

    try out_tty_config.setColor(out_stream, .reset);
    try out_stream.writeAll(": ");

    try out_tty_config.setColor(out_stream, .dim);
    try out_stream.print("0x{x} in {s} ({s})\n", .{
        address,
        query_result.function_name orelse "???",
        query_result.module_name orelse "???",
    });
    try out_tty_config.setColor(out_stream, .reset);
}

fn output_source_line(
    out_stream: *Io.Writer,
    out_tty_config: std.io.tty.Config,
    src_loc: DebugInfo.ResolvedSourceLocation,
) !void {
    var dir = try std.fs.cwd().openDir(src_loc.dir_path, .{});
    defer dir.close();

    const file = dir.openFile(src_loc.file_path, .{}) catch return;
    defer file.close();

    var r_buf: [512]u8 = undefined;
    var file_reader = file.reader(&r_buf);

    var line_count: u32 = 1;
    var line_buf: [128]u8 = undefined;
    const src_line: struct {
        line: []const u8,
        too_long: bool,
    } = while (line_count < src_loc.line) : (line_count += 1) {
        _ = file_reader.interface.discardDelimiterInclusive('\n') catch |err| {
            if (err == error.EndOfStream) {
                return error.InvalidLineNumber;
            } else {
                return err;
            }
        };
    } else blk: {
        const line = file_reader.interface.takeDelimiterExclusive('\n') catch |err| switch (err) {
            error.EndOfStream => return error.InvalidLineNumber,
            error.StreamTooLong => break :blk .{
                .line = &line_buf,
                .too_long = true,
            },
            else => return err,
        };

        break :blk .{
            .line = line,
            .too_long = false,
        };
    };

    try out_stream.print("{s}", .{src_line.line});
    if (src_line.too_long) {
        try out_stream.writeAll(" [...]");
    }
    try out_stream.writeAll("\n");

    if (src_loc.column > 0) {
        const space_needed = src_loc.column - 1;

        _ = try out_stream.splatByte(' ', space_needed);
        try out_tty_config.setColor(out_stream, .green);
        try out_stream.writeAll("^");
        try out_tty_config.setColor(out_stream, .reset);
    }
    try out_stream.writeAll("\n");
}
