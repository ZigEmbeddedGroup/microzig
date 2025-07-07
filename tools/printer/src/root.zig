const std = @import("std");

pub const Elf = @import("Elf.zig");
pub const DebugInfo = @import("DebugInfo.zig");

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
        elf: Elf,
        debug_info: *DebugInfo,
        out_stream: anytype,
        out_tty_config: std.io.tty.Config,
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
                        try output_source_line(out_stream, out_tty_config, query_result);
                    }

                    continue :loop .waiting;
                }

                self.state = .{ .print_address = address };
            },
        }

        try out_stream.writeAll(data[index..]);
    }
};

fn output_location_info(
    out_stream: anytype,
    out_tty_config: std.io.tty.Config,
    address: u64,
    query_result: DebugInfo.QueryResult,
) !void {
    try out_tty_config.setColor(out_stream, .bold);

    if (query_result.dir_path != null and query_result.file_path != null)
        try out_stream.print("{s}:", .{std.fs.path.fmtJoin(&.{ query_result.dir_path.?, query_result.file_path.? })})
    else
        try out_stream.writeAll("???:");

    if (query_result.line) |line| {
        try out_stream.print("{}:", .{line});
    } else {
        try out_stream.writeAll("?:");
    }

    if (query_result.column) |column| {
        try out_stream.print("{}", .{column});
    } else {
        try out_stream.writeAll("?");
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
    out_stream: anytype,
    out_tty_config: std.io.tty.Config,
    query_result: DebugInfo.QueryResult,
) !void {
    // we need all these to output the source line
    const column = query_result.column orelse return;
    const line_no = query_result.line orelse return;
    const dir_path = query_result.dir_path orelse return;
    const file_path = query_result.file_path orelse return;

    var dir = try std.fs.cwd().openDir(dir_path, .{});
    defer dir.close();

    const file = dir.openFile(file_path, .{}) catch return;
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    const in_stream = buf_reader.reader();

    var line_count: u32 = 1;
    var buf: [150]u8 = undefined;
    const src_line: struct {
        line: []const u8,
        too_long: bool,
    } = loop: while (true) : (line_count += 1) {
        var too_long = false;

        const line = in_stream.readUntilDelimiterOrEof(&buf, '\n') catch |err| switch (err) {
            error.StreamTooLong => blk: {
                try in_stream.skipUntilDelimiterOrEof('\n');
                too_long = true;
                break :blk &buf;
            },
            else => return err,
        } orelse return;

        if (line_no == line_count) {
            break :loop .{
                .line = line,
                .too_long = too_long,
            };
        }
    } else return;

    try out_stream.print("{s}", .{src_line.line});
    if (src_line.too_long) {
        try out_stream.writeAll(" [...]");
    }
    try out_stream.writeAll("\n");

    if (column > 0) {
        const space_needed = column - 1;

        try out_stream.writeByteNTimes(' ', space_needed);
        try out_tty_config.setColor(out_stream, .green);
        try out_stream.writeAll("^");
        try out_tty_config.setColor(out_stream, .reset);
    }
    try out_stream.writeAll("\n");
}
