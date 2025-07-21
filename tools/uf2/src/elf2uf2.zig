const std = @import("std");
const uf2 = @import("uf2.zig");

// command line options:
// --output-path
// --family-id
// --elf-path
const usage =
    \\elf2uf2 [--family-id <id>] --elf-path <path> --output-path <path>
    \\ --help                    Show this message
    \\ --elf-path                Path of the ELF file to convert
    \\ --output-path             Path to save the generated UF2 file
    \\ --family-id               Family id of the microcontroller
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

var elf_reader_buf: [1024]u8 = undefined;
var output_writer_buf: [1024]u8 = undefined;

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

    const family_id: ?uf2.FamilyId = if (try find_arg(args, "--family-id")) |family_id_str|
        if (std.mem.startsWith(u8, family_id_str, "0x"))
            @as(uf2.FamilyId, @enumFromInt(try std.fmt.parseInt(u32, family_id_str, 0)))
        else
            std.meta.stringToEnum(uf2.FamilyId, family_id_str) orelse {
                std.log.err("invalid family id: {s}, valid family names are:", .{family_id_str});
                inline for (@typeInfo(uf2.FamilyId).@"enum".fields) |field|
                    std.log.err(" - {s}", .{field.name});

                return error.InvalidFamilyId;
            }
    else
        null;

    var archive = uf2.Archive.init(gpa.allocator());
    defer archive.deinit();

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    var elf_reader = elf_file.reader(&elf_reader_buf);

    try archive.add_elf(&elf_reader, .{
        .family_id = family_id,
    });

    const dest_file = try std.fs.cwd().createFile(output_path, .{});
    defer dest_file.close();

    var writer = dest_file.writer(&output_writer_buf);
    try archive.write_to(&writer.interface);
    try writer.interface.flush();
}
