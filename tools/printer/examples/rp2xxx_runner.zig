const std = @import("std");
const printer = @import("printer");
const serial = @import("serial");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 4) return error.UsageError;

    const elf_path = args[1];
    const serial_device_path = args[2];
    const baud_rate = try std.fmt.parseInt(u32, args[3], 10);

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();

    var elf = try printer.Elf.init(allocator, elf_file);
    defer elf.deinit(allocator);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    var annotator: printer.Annotator = .init;

    const serial_device = try std.fs.cwd().openFile(serial_device_path, .{});
    defer serial_device.close();
    try serial.configureSerialPort(serial_device, .{
        .baud_rate = baud_rate,
    });
    try serial.flushSerialPort(serial_device, .both);

    {
        var flash_cmd: std.process.Child = .init(&.{
            "picotool",
            "load",
            "-u",
            "-v",
            "-x",
            "-t",
            "elf",
            elf_path,
        }, allocator);
        const term = try flash_cmd.spawnAndWait();
        switch (term) {
            .Exited => |code| if (code != 0) return error.FlashCommandFailed,
            else => {},
        }
    }

    const stdout = std.io.getStdOut();
    const out_stream = stdout.writer();
    const out_tty_config = std.io.tty.detectConfig(stdout);

    var buf: [4096]u8 = undefined;
    while (true) {
        const n = try serial_device.read(&buf);
        try annotator.process(allocator, buf[0..n], elf, &debug_info, out_stream, out_tty_config);
    }
}
