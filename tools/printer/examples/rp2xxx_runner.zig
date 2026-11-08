const std = @import("std");
const printer = @import("printer");
const serial = @import("serial");

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

    var coverage: std.debug.Coverage = .init;
    // arch is ignored for elf files, .thumb is just a placeholder
    var debug_info: std.debug.Info = try .load(gpa, io, .initCwd(elf_path), &coverage, .elf, .thumb);
    defer debug_info.deinit(gpa);
    // NOTE: this is safe because we specify the elf object format when loading the debug_info
    const elf_file = &debug_info.impl.elf;

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

    while (true) {
        try printer.annotate(
            gpa,
            io,
            &reader.interface,
            &terminal,
            elf_file,
        );
    }
}
