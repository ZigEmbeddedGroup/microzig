const std = @import("std");
const printer = @import("printer");
const Elf = printer.Elf;
const DebugInfo = printer.DebugInfo;
const Annotator = printer.Annotator;

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len <= 1) {
        try std.io.getStdErr().writeAll("usage: ./printer elf_file [input_file]\n");
        std.process.exit(1);
    }

    const elf_file = try std.fs.cwd().openFile(args[1], .{});
    defer elf_file.close();

    const input_file = if (args.len <= 2 or std.mem.eql(u8, args[2], "-"))
        std.io.getStdIn()
    else
        try std.fs.cwd().openFile(args[2], .{});
    defer input_file.close();

    var elf = try Elf.init(allocator, elf_file);
    defer elf.deinit(allocator);

    var debug_info = try DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    const in_stream = input_file.reader();

    const stdout = std.io.getStdOut();
    const out_stream = stdout.writer();
    const out_tty_config = std.io.tty.detectConfig(stdout);

    var buf: [1024]u8 = undefined;
    var annotator: Annotator = .init;

    while (true) {
        const n = try in_stream.read(&buf);

        try annotator.process(
            allocator,
            buf[0..n],
            elf,
            &debug_info,
            out_stream,
            out_tty_config,
        );
    }
}
