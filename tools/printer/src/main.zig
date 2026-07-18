const std = @import("std");
const builtin = @import("builtin");
const printer = @import("printer");

var elf_file_reader_buf: [1024]u8 = undefined;
var in_stream_buf: [1024]u8 = undefined;
var out_stream_buf: [1024]u8 = undefined;

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len < 2) {
        var stderr = std.Io.File.stderr().writer(io, &.{});
        try stderr.interface.writeAll("usage: ./printer elf_file [input_file]\n");
        std.process.exit(1);
    }

    const elf_file = try std.Io.Dir.cwd().openFile(io, args[1], .{});
    defer elf_file.close(io);

    var elf_file_reader = elf_file.reader(io, &elf_file_reader_buf);
    var elf: printer.Elf = try .init(gpa, &elf_file_reader);
    defer elf.deinit(gpa);

    var debug_info: printer.DebugInfo = try .init(gpa, elf);
    defer debug_info.deinit(gpa);

    const input_file = if (args.len <= 2 or std.mem.eql(u8, args[2], "-"))
        std.Io.File.stdin()
    else
        try std.Io.Dir.cwd().openFile(io, args[2], .{});
    defer input_file.close(io);

    var reader = input_file.reader(io, &in_stream_buf);

    const stdout = std.Io.File.stdout();
    var writer = stdout.writer(io, &out_stream_buf);

    const no_color = try init.minimal.environ.containsUnempty(gpa, "NO_COLOR");
    const clicolor_force = try init.minimal.environ.containsUnempty(gpa, "CLICOLOR_FORCE");
    var terminal: std.Io.Terminal = .{
        .writer = &writer.interface,
        .mode = try std.Io.Terminal.Mode.detect(io, stdout, no_color, clicolor_force),
    };

    try printer.annotate(
        io,
        &reader.interface,
        &terminal,
        elf,
        &debug_info,
    );
}
