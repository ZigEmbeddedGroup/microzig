const std = @import("std");
const printer = @import("printer");

var elf_file_reader_buf: [1024]u8 = undefined;
var out_stream_buf: [1024]u8 = undefined;
var printer_writer_buf: [512]u8 = undefined;

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        try std.fs.File.stderr().writeAll("usage: ./printer elf_file [input_file]\n");
        std.process.exit(1);
    }

    const elf_file = try std.fs.cwd().openFile(args[1], .{});
    defer elf_file.close();
    var elf_file_reader = elf_file.reader(&elf_file_reader_buf);

    var elf = try printer.Elf.init(allocator, &elf_file_reader);
    defer elf.deinit(allocator);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    const input_file = if (args.len <= 2 or std.mem.eql(u8, args[2], "-"))
        std.fs.File.stdin()
    else
        try std.fs.cwd().openFile(args[2], .{});
    defer input_file.close();
    var in_stream = input_file.reader(&.{});

    const stdout = std.fs.File.stdout();
    var out_stream = stdout.writer(&out_stream_buf);
    const out_tty_config = std.io.tty.detectConfig(stdout);

    var printer_writer: printer.Writer = .init(
        &printer_writer_buf,
        &out_stream.interface,
        out_tty_config,
        elf,
        &debug_info,
    );

    while (true) {
        _ = try in_stream.interface.stream(&printer_writer.interface, .unlimited);

        // flush the writers
        // TODO: Is there a better way to do this?
        try printer_writer.interface.flush();
        try out_stream.interface.flush();
    }
}
