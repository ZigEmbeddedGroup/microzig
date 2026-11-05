const std = @import("std");
const Io = std.Io;

/// Reads lines one by one from in_stream and outputs them with annotated
/// addresses to out_stream. Returns after it reaches the end of the stream.
pub fn annotate(
    gpa: std.mem.Allocator,
    io: Io,
    in_stream: *Io.Reader,
    terminal: *Io.Terminal,
    elf: *std.debug.ElfFile,
) !void {
    while (true) {
        const line = in_stream.takeDelimiterInclusive('\n') catch |err| switch (err) {
            error.ReadFailed => return error.ReadFailed,
            error.EndOfStream => {
                try output_line(gpa, io, in_stream.buffered(), terminal, elf);
                try terminal.writer.flush();
                return;
            },
            error.StreamTooLong => return error.StreamTooLong,
        };

        try output_line(gpa, io, line, terminal, elf);
        try terminal.writer.flush();
    }
}

fn output_line(
    gpa: std.mem.Allocator,
    io: Io,
    line: []const u8,
    terminal: *Io.Terminal,
    elf: *std.debug.ElfFile,
) !void {
    try terminal.writer.writeAll(line);

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

    var text_arena: std.heap.ArenaAllocator = .init(gpa);
    defer text_arena.deinit();
    const di = &(elf.dwarf orelse return);
    const compile_unit = di.findCompileUnit(elf.endian, address) catch return;
    const maybe_name = di.getSymbolName(address);
    const maybe_src_loc = di.getLineNumberInfo(gpa, text_arena.allocator(), elf.endian, compile_unit, address) catch null;

    try output_location_info(terminal, address, maybe_name, maybe_src_loc);
    if (maybe_src_loc) |src_loc| try output_source_line(io, terminal, src_loc);
}

fn output_location_info(
    terminal: *Io.Terminal,
    address: u64,
    maybe_name: ?[]const u8,
    maybe_src_loc: ?std.debug.SourceLocation,
) !void {
    try terminal.setColor(.bold);

    if (maybe_src_loc) |src_loc| {
        try terminal.writer.print("{s}:{}:{}", .{
            src_loc.file_name,
            src_loc.line,
            src_loc.column,
        });
    } else {
        try terminal.writer.writeAll("???:?:?");
    }

    try terminal.setColor(.reset);
    try terminal.writer.writeAll(": ");

    try terminal.setColor(.dim);
    try terminal.writer.print("0x{x} in {s} ({s})\n", .{
        address,
        maybe_name orelse "???",
        if (maybe_src_loc) |src_loc| std.Io.Dir.path.basename(src_loc.file_name) else "???",
    });
    try terminal.setColor(.reset);
}

fn output_source_line(
    io: Io,
    terminal: *Io.Terminal,
    src_loc: std.debug.SourceLocation,
) !void {
    var file = std.Io.Dir.cwd().openFile(io, src_loc.file_name, .{}) catch return;
    defer file.close(io);

    var r_buf: [512]u8 = undefined;
    var file_reader = file.reader(io, &r_buf);

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

    try terminal.writer.print("{s}", .{src_line.line});
    if (src_line.too_long) {
        try terminal.writer.writeAll(" [...]");
    }
    try terminal.writer.writeAll("\n");

    if (src_loc.column > 0) {
        const space_needed = src_loc.column - 1;

        try terminal.writer.splatByteAll(' ', space_needed);
        try terminal.setColor(.green);
        try terminal.writer.writeAll("^");
        try terminal.setColor(.reset);
    }

    try terminal.writer.writeAll("\n");
}
