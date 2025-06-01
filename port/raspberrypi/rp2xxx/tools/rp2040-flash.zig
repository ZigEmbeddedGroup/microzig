const std = @import("std");
const args_parser = @import("args");
const builtin = @import("builtin");

const CliOptions = struct {
    help: bool = false,
    device: ?[]const u8 = null,
    wait: bool = false,

    pub const shorthands = .{
        .h = "help",
        .d = "device",
        .w = "wait",
    };
};

const wait_device_ready_timeout = 60 * std.time.ns_per_s; // timeout until a device is found
const wait_device_avail_timeout = 60 * std.time.ns_per_s; // timeout until a device is found
const access_denied_limit = 20; // try that many times with AccessDenied before the user is informed

fn print_usage(file: std.fs.File, exe: ?[]const u8) !void {
    try file.writer().writeAll(exe orelse "rp2040-flash");
    try file.writer().writeAll(
        \\ [-h] [-d <device>] <uf2-file>
        \\Flash your RP2040 devices easily via UF2 interface.
        \\
        \\Options:
        \\  -h, --help          Shows this help text.
        \\  -d, --device <path> Uses <path> as the UF2 device. Otherwise tries to auto-guess the correct device.
        \\  -w, --wait          Waits 60 seconds until a device appears.
        \\
    );
}

pub fn main() !u8 {
    const stderr = std.io.getStdErr();
    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = arena.deinit();

    const allocator = arena.allocator();

    var cli = args_parser.parseForCurrentProcess(CliOptions, allocator, .print) catch return 1;
    defer cli.deinit();

    if (cli.options.help) {
        try print_usage(stdout, cli.executable_name);
        return 0;
    }

    if (cli.positionals.len != 1) {
        try print_usage(stderr, cli.executable_name);
        return 1;
    }

    const uf2_file_path = cli.positionals[0];

    var uf2_file = try std.fs.cwd().openFile(uf2_file_path, .{});
    defer uf2_file.close();

    const uf2_stat = try uf2_file.stat();
    if ((uf2_stat.size % 512) != 0) {
        std.log.warn("{s} does not have a size multiple of 512. might be corrupt!", .{uf2_file_path});
    }

    const file_valid = blk: {
        try uf2_file.seekTo(0);

        var file_valid = true;

        while (file_valid) {
            var block: [512]u8 = undefined;
            const len = try uf2_file.read(&block);
            if (len == 0)
                break;

            // 0    4   First magic number, 0x0A324655 ("UF2\n")
            // 4    4   Second magic number, 0x9E5D5157
            // 8    4   Flags
            // 12   4   Address in flash where the data should be written
            // 16   4   Number of bytes used in data (often 256)
            // 20   4   Sequential block number; starts at 0
            // 24   4   Total number of blocks in file
            // 28   4   File size or board family ID or zero
            //                          32   476 Data, padded with zeros
            // 508  4   Final magic number, 0x0AB16F30

            const first_magic_number = std.mem.readIntLittle(u32, block[0..][0..4]);
            const second_magic_number = std.mem.readIntLittle(u32, block[4..][0..4]);
            const final_magic_number = std.mem.readIntLittle(u32, block[508..][0..4]);

            file_valid = file_valid and (first_magic_number == 0x0A324655);
            file_valid = file_valid and (second_magic_number == 0x9E5D5157);
            file_valid = file_valid and (final_magic_number == 0x0AB16F30);
        }
        break :blk file_valid;
    };

    if (file_valid == false) {
        std.log.warn("{s} does not seem to be a valid UF2 file. Do you really want to flash it?", .{uf2_file_path});
        while (true) {
            try stderr.writer().writeAll("Flash? [jN]: ");

            var buffer: [64]u8 = undefined;
            const selection_or_null = try stdin.reader().readUntilDelimiterOrEof(&buffer, '\n');

            const selection_str = std.mem.trim(u8, selection_or_null orelse "", "\r\n\t ");
            if (selection_str.len == 0)
                return 1;

            if (std.ascii.eqlIgnoreCase(selection_str, "j"))
                break;

            if (std.ascii.eqlIgnoreCase(selection_str, "n"))
                return 1;
        }
    }

    try uf2_file.seekTo(0);

    const detect_timeout = std.time.nanoTimestamp() + wait_device_avail_timeout;
    var first_run = true;
    const device_path = if (cli.options.device) |devname|
        try allocator.dupe(u8, devname)
    else while (true) {
        if (std.time.nanoTimestamp() >= detect_timeout) {
            try stderr.writeAll("failed to detect any RP2040 devices :(\n");

            return 1;
        }

        const maybe_device = try auto_detect_pico(allocator);

        if (maybe_device) |device|
            break device;

        if (!cli.options.wait) {
            try stderr.writeAll("failed to detect any RP2040 devices :(\n");
            return 1;
        }

        if (first_run) {
            try stderr.writeAll("failed to detect any RP2040 devices, waiting...\n");
            first_run = false;
        }

        std.time.sleep(250 * std.time.ns_per_ms);
    };

    const connect_timeout = std.time.nanoTimestamp() + wait_device_ready_timeout;

    var first_attempt = true;
    var access_denied_counter: u32 = 0;
    var last_err: anyerror = error.Unknown;
    var device_file: std.fs.File = blk: while (std.time.nanoTimestamp() < connect_timeout) {
        var device = std.fs.cwd().openFile(device_path, .{ .mode = .write_only }) catch |err| {
            last_err = err;

            switch (err) {
                error.FileNotFound => {}, // just waiting for the device
                error.AccessDenied => {
                    access_denied_counter += 1;
                    if (access_denied_counter >= access_denied_limit) {
                        try stderr.writer().print("Could not open {s}: Access denied. Do you have write-access to the device?\n", .{device_path});
                        return 1;
                    }
                },
                else => |e| return e,
            }

            if (first_attempt) {
                try stderr.writer().print("Waiting for {s}.", .{device_path});
                first_attempt = false;
            } else {
                try stderr.writeAll(".");
            }
            std.time.sleep(250 * std.time.ns_per_ms);
            continue;
        };
        try stderr.writeAll("\n");
        break :blk device;
    } else {
        try stderr.writer().print("\nfailed to connect to {s}: {s}\n", .{ device_path, @errorName(last_err) });
        return 1;
    };
    defer device_file.close();

    try stderr.writeAll("Flashing");

    {
        try uf2_file.seekTo(0);

        var block_num: u64 = 0;
        while (true) {
            try stderr.writeAll(".");

            var block: [512]u8 = undefined;
            const rd_len = try uf2_file.read(&block);
            if (rd_len == 0)
                break;
            if (rd_len != block.len) {
                try stderr.writer().print("\nFailed to read block {}: Only {} bytes read!\n", .{ block_num, rd_len });
                return 1;
            }

            const wr_len = try device_file.write(&block);
            if (wr_len != block.len) {
                try stderr.writer().print("\nFailed to write block {}: Only {} bytes written!\n", .{ block_num, wr_len });
                return 1;
            }

            block_num += 1;
        }
    }
    try stderr.writeAll("\nDone.\n");

    return 0;
}

fn auto_detect_pico(allocator: std.mem.Allocator) !?[]const u8 {
    switch (builtin.os.tag) {
        .linux => {
            const stdin = std.io.getStdIn();
            const stderr = std.io.getStdErr();

            const Device = struct {
                name: []const u8,
                path: []const u8,
            };

            var picos = std.ArrayList(Device).init(allocator);
            defer picos.deinit();

            var base_dir = try std.fs.openIterableDirAbsolute("/sys/block/", .{});
            defer base_dir.close();

            var iter = base_dir.iterate();

            while (try iter.next()) |entry| {
                var device_dir = try base_dir.dir.openDir(entry.name, .{});
                defer device_dir.close();

                const H = struct {
                    fn is_pico_device(dir: std.fs.Dir, allo: std.mem.Allocator) !?[]const u8 {
                        // "/sys/block/*/removable" => "1"
                        // "/sys/block/*/device/model" => "RP2"
                        // "/sys/block/*/device/vendor" => "RPI"

                        var buffer: [64]u8 = undefined;

                        const removable = std.mem.trim(u8, try dir.readFile("removable", &buffer), "\r\n\t ");
                        if (!std.mem.eql(u8, removable, "1"))
                            return null;

                        const device_model = std.mem.trim(u8, try dir.readFile("device/model", &buffer), "\r\n\t ");
                        if (!std.mem.eql(u8, device_model, "RP2"))
                            return null;

                        const device_vendor = std.mem.trim(u8, try dir.readFile("device/vendor", &buffer), "\r\n\t ");
                        if (!std.mem.eql(u8, device_vendor, "RPI"))
                            return null;

                        const device_id = std.mem.trim(u8, try dir.readFile("dev", &buffer), "\r\n\t ");

                        return try std.fs.path.join(allo, &.{
                            "/dev/block", device_id,
                        });
                    }
                };

                const maybe_device = H.is_pico_device(device_dir, allocator) catch |err| {
                    if (err != error.FileNotFound and err != error.AccessDenied) {
                        std.log.err("failed to scan /sys/block/{s}: {s}", .{ entry.name, @errorName(err) });
                    }
                    continue;
                };

                if (maybe_device) |device_path| {
                    try picos.append(Device{
                        .name = try allocator.dupe(u8, entry.name),
                        .path = device_path,
                    });
                }
            }

            if (picos.items.len == 0) {
                return null;
            }

            var default_selection: usize = 0;

            try stderr.writer().writeAll("Select your device:\n");
            for (picos.items, 1..) |pico_dev, index| {
                try stderr.writer().print("#{d: <2} {s}\n", .{ index, pico_dev.name });

                if (default_selection == 0) {
                    default_selection = index;
                }
            }

            const selection = while (true) {
                try stderr.writer().print("Select port [{}]: ", .{default_selection});

                var buffer: [64]u8 = undefined;
                const selection_or_null = try stdin.reader().readUntilDelimiterOrEof(&buffer, '\n');

                const selection_str = std.mem.trim(u8, selection_or_null orelse break default_selection, "\r\n\t ");

                if (selection_str.len == 0)
                    break default_selection;

                const selection = std.fmt.parseInt(usize, selection_str, 10) catch continue;

                if (selection < 1 or selection > picos.items.len) {
                    continue;
                }

                break selection;
            };

            return picos.items[selection - 1].path;
        },

        else => {
            std.log.warn("Device auto-detection not implemented for {s}", .{@tagName(builtin.os.tag)});
            return null;
        },
    }
}
