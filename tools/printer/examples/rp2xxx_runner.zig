const std = @import("std");
const printer = @import("printer");
const serial = @import("serial");

var elf_file_reader_buf: [1024]u8 = undefined;
var in_stream_buf: [1024]u8 = undefined;
var out_stream_buf: [1024]u8 = undefined;

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len != 4)
        return error.UsageError;

    const elf_path = args[1];
    const serial_device_path = args[2];
    const baud_rate = try std.fmt.parseInt(u32, args[3], 10);

    const elf_file = try std.Io.Dir.cwd().openFile(io, elf_path, .{});
    defer elf_file.close(io);
    var elf_file_reader = elf_file.reader(io, &elf_file_reader_buf);

    var elf: printer.Elf = try .init(gpa, &elf_file_reader);
    defer elf.deinit(gpa);

    var debug_info: printer.DebugInfo = try .init(gpa, elf);
    defer debug_info.deinit(gpa);

    const serial_device = try std.Io.Dir.cwd().openFile(io, serial_device_path, .{});
    defer serial_device.close(io);
    try serial.configureSerialPort(serial_device, .{
        .baud_rate = baud_rate,
    });
    try serial.flushSerialPort(serial_device, .both);
    var reader = serial_device.reader(io, &in_stream_buf);

    var flash_cmd = try std.process.spawn(io, .{
        .argv = &.{ "picotool", "load", "-u", "-v", "-x", "-t", "elf", elf_path },
    });
    const term = try flash_cmd.wait(io);
    switch (term) {
        .exited => |code| if (code != 0) return error.FlashCommandFailed,
        else => {},
    }

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
