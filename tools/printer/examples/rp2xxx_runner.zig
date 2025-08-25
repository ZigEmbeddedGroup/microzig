const std = @import("std");
const printer = @import("printer");
const serial = @import("serial");

var elf_file_reader_buf: [1024]u8 = undefined;
var out_stream_buf: [1024]u8 = undefined;
var printer_writer_buf: [512]u8 = undefined;

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
    var elf_file_reader = elf_file.reader(&elf_file_reader_buf);

    var elf = try printer.Elf.init(allocator, &elf_file_reader);
    defer elf.deinit(allocator);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    const serial_device = try std.fs.cwd().openFile(serial_device_path, .{});
    defer serial_device.close();
    try serial.configureSerialPort(serial_device, .{
        .baud_rate = baud_rate,
    });
    try serial.flushSerialPort(serial_device, .both);
    var in_stream = serial_device.reader(&.{});

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

        try printer_writer.interface.flush();
        try out_stream.interface.flush();
    }
}
