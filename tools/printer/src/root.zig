const std = @import("std");
const Io = std.Io;

pub const Elf = @import("Elf.zig");
pub const DebugInfo = @import("DebugInfo.zig");

/// Reads lines one by one from in_stream and outputs them with annotated
/// addresses to out_stream. Returns after it reaches the end of the stream.
pub fn annotate(
    in_stream: *Io.Reader,
    out_stream: *Io.Writer,
    out_tty_config: std.io.tty.Config,
    elf: Elf,
    debug_info: *DebugInfo,
) !void {
    while (true) {
        const line = in_stream.takeDelimiterInclusive('\n') catch |err| switch (err) {
            error.ReadFailed => return error.ReadFailed,
            error.EndOfStream => {
                try output_line(in_stream.buffered(), out_stream, out_tty_config, elf, debug_info);
                try out_stream.flush();
                return;
            },
            error.StreamTooLong => return error.StreamTooLong,
        };

        try output_line(line, out_stream, out_tty_config, elf, debug_info);
        try out_stream.flush();
    }
}

fn output_line(
    line: []const u8,
    out_stream: *Io.Writer,
    out_tty_config: std.io.tty.Config,
    elf: Elf,
    debug_info: *DebugInfo,
) !void {
    try out_stream.writeAll(line);

    const prefix_index = std.mem.indexOf(u8, line, "0x") orelse return;
    var after_prefix = line[prefix_index + 2 ..];

    var hex_digit_count: u32 = 0;
    for (after_prefix) |c| {
        if (!std.ascii.isHex(c) or hex_digit_count > 16) {
            break;
        } else {
            hex_digit_count += 1;
        }
    }

    if (hex_digit_count != 8 and hex_digit_count != 16) return;

    const address = std.fmt.parseInt(u64, after_prefix[0..hex_digit_count], 16) catch unreachable;
    if (elf.is_address_executable(address)) {
        const query_result = debug_info.query(address);
        try output_location_info(out_stream, out_tty_config, address, query_result);
        if (query_result.source_location) |src_loc| {
            try output_source_line(out_stream, out_tty_config, src_loc);
        }
    }
}

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
    var dir = std.fs.cwd().openDir(src_loc.dir_path, .{}) catch return;
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

        try out_stream.splatByteAll(' ', space_needed);
        try out_tty_config.setColor(out_stream, .green);
        try out_stream.writeAll("^");
        try out_tty_config.setColor(out_stream, .reset);
    }
    try out_stream.writeAll("\n");
}
