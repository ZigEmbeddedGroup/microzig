const std = @import("std");
const config = @import("config");

const section = struct {
    const name = config.section_name;

    const start = @extern(*anyopaque, .{
        .name = config.section_marker_start,
    });

    const end = @extern(*anyopaque, .{
        .name = config.section_marker_end,
    });
};

pub const PrintInfo = struct {
    instructions: []const Instruction,

    pub const Instruction = union(enum) {
        text: []const u8,
    };

    fn generate(comptime fmt: []const u8, comptime Args: type) PrintInfo {
        _ = Args;
        var instructions: []const Instruction = &.{};

        instructions = instructions ++ [_]Instruction{.{ .text = fmt }};

        const instructions_copy = instructions;
        return .{
            .instructions = instructions_copy,
        };
    }
};

/// Write binary protocol to writer. It's up to you to figure out how to receive
/// it and format it.
pub fn print(w: *std.Io.Writer, comptime fmt: []const u8, args: anytype) std.Io.Writer.Error!void {
    const print_info: PrintInfo = comptime .generate(fmt, @TypeOf(args));
    const id = register(print_info);
    try w.writeLeb128(id);

    inline for (print_info.instructions) |insn| switch (insn) {
        .text => unreachable, // The receiver will know to print.
    };
}

fn register(comptime print_info: PrintInfo) u32 {
    const Entry = struct {
        var byte: u8 = undefined;
    };

    const name = comptime blk: {
        var buf: [config.print_info_size_max]u8 = undefined;
        var writer: std.Io.Writer = .fixed(&buf);
        std.json.Stringify.value(print_info, .{}, &writer) catch unreachable;
        // Not sure if this will copy it right at comptime.
        break :blk writer.buffered();
    };

    @export(&Entry.byte, .{
        .name = name,
        .section = section.name,
    });

    // This has to be done at runtime because we can't make comptime
    // calculations based off where the linker places things.
    return @intCast(@intFromPtr(&Entry.byte) - @intFromPtr(section.start));
}

pub const Printer = struct {
    reader: *std.Io.Reader,
    writer: *std.Io.Writer,
    lookup: std.AutoArrayHashMap(u32, PrintInfo),

    /// Process a single record, flushes the writer.
    pub fn process_record(p: *Printer) !void {
        const id = try p.reader.takeLeb128(u32);
        const print_info = p.lookup.get(id) orelse return error.InvalidID;

        for (print_info.instructions) |insn| switch (insn) {
            .text => |str| try p.writer.writeAll(str),
        };

        try p.writer.flush();
    }
};
