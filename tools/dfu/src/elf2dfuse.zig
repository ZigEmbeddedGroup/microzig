const std = @import("std");
const dfuse = @import("dfuse");

const usage =
    \\elf2dfuse [options] --elf-path <path> --output-path <path>
    \\
    \\Converts an ELF file to DfuSe format.
    \\
    \\Options:
    \\  --vendor-id <vid>          USB Vendor ID in hex (default: 0x0483)
    \\  --product-id <pid>         USB Product ID in hex (default: 0xDF11)
    \\  --device-id <did>          Device version in hex (default: 0xFFFF)
    \\  --elf-path <path>          Path to input ELF file (required)
    \\  --output-path <path>       Path to output DFU file (required)
    \\  --help                     Show this message
    \\
;

fn find_arg(args: []const []const u8, key: []const u8) !?[]const u8 {
    const key_idx = for (args, 0..) |arg, i| {
        if (std.mem.eql(u8, key, arg))
            break i;
    } else return null;

    if (key_idx >= args.len - 1) {
        std.log.err("missing value for {s}", .{key});
        return error.MissingArgValue;
    }

    const value = args[key_idx + 1];
    if (std.mem.startsWith(u8, value, "--")) {
        std.log.err("missing value for {s}", .{key});
        return error.MissingArgValue;
    }

    return value;
}

var elf_reader_buf: [4096]u8 = undefined;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const args = try std.process.argsAlloc(gpa.allocator());
    defer std.process.argsFree(gpa.allocator(), args);

    for (args) |arg| if (std.mem.eql(u8, "--help", arg)) {
        var writer = std.fs.File.stdout().writer(&.{});
        try writer.interface.writeAll(usage);
        return;
    };

    const elf_path = (try find_arg(args, "--elf-path")) orelse {
        std.log.err("missing arg: --elf-path", .{});
        return error.MissingArg;
    };

    const output_path = (try find_arg(args, "--output-path")) orelse {
        std.log.err("missing arg: --output-path", .{});
        return error.MissingArg;
    };

    var opts: dfuse.Options = .{};

    if (try find_arg(args, "--vendor-id")) |vid_str| {
        opts.vendor_id = std.fmt.parseInt(u16, vid_str, 0) catch {
            std.log.err("invalid vendor id: {s}", .{vid_str});
            return error.InvalidVendorId;
        };
    }

    if (try find_arg(args, "--product-id")) |pid_str| {
        opts.product_id = std.fmt.parseInt(u16, pid_str, 0) catch {
            std.log.err("invalid product id: {s}", .{pid_str});
            return error.InvalidProductId;
        };
    }

    if (try find_arg(args, "--device-id")) |did_str| {
        opts.device_id = std.fmt.parseInt(u16, did_str, 0) catch {
            std.log.err("invalid device id: {s}", .{did_str});
            return error.InvalidDeviceId;
        };
    }

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    var elf_reader = elf_file.reader(&elf_reader_buf);

    const dest_file = try std.fs.cwd().createFile(output_path, .{});
    defer dest_file.close();

    // Unbuffered because dfu uses an hashed writer, which suggests
    // using an unbuffered underlying writer
    var writer = dest_file.writer(&.{});
    try dfuse.from_elf(gpa.allocator(), &elf_reader, &writer.interface, opts);
}
