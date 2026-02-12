const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

// const clap = @import("clap"); TODO: use clap
const Database = @import("Database.zig");
const FS_Directory = @import("FS_Directory.zig");
const gen = @import("gen.zig");
const Patch = @import("patch.zig").Patch;
const xml = @import("xml.zig");

pub const std_options = std.Options{
    .log_level = .warn,
};

pub fn main() !void {
    main_impl() catch |err| switch (err) {
        error.Explained => std.process.exit(1),
        else => return err,
    };
}

const Arguments = struct {
    allocator: Allocator,
    format: ?Database.Format = null,
    input_path: ?[]const u8 = null,
    output_path: ?[:0]const u8 = null,
    device: ?[]const u8 = null,
    patch_paths: std.ArrayList([]const u8) = .{},
    dump_path: ?[:0]const u8 = null,
    help: bool = false,

    fn append_patch_path(args: *Arguments, patch_path: []const u8) !void {
        const copy = try args.allocator.dupe(u8, patch_path);
        errdefer args.allocator.free(copy);

        try args.patch_paths.append(args.allocator, copy);
    }

    fn deinit(args: *Arguments) void {
        if (args.input_path) |input_path| args.allocator.free(input_path);
        if (args.output_path) |output_path| args.allocator.free(output_path);
        if (args.device) |device| args.allocator.free(device);
        if (args.dump_path) |dump_path| args.allocator.free(dump_path);

        for (args.patch_paths.items) |patch_path| args.allocator.free(patch_path);
        args.patch_paths.deinit(args.allocator);
    }
};

fn print_usage(writer: *std.Io.Writer) !void {
    try writer.writeAll(
        \\regz
        \\  --help                Display this help and exit
        \\  --db_dump_path <str>  Dump SQLite file
        \\  --format <str>        Explicitly set format type, one of: svd, atdf, json, embassy
        \\  --output_path <str>   Write to a file
        \\  --device <str>        Specific device to generate code for
        \\  --patch_path <str>    After reading format, apply NDJSON based patch file
        \\<str>
        \\
    );
    try writer.flush();
}

fn parse_args(allocator: Allocator) !Arguments {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var ret = Arguments{
        .allocator = allocator,
    };
    errdefer ret.deinit();

    var i: usize = 1;
    while (i < args.len) : (i += 1)
        if (std.mem.eql(u8, args[i], "--help")) {
            ret.help = true;
        } else if (std.mem.eql(u8, args[i], "--db_dump_path")) {
            i += 1;
            ret.dump_path = try allocator.dupeZ(u8, args[i]);
        } else if (std.mem.eql(u8, args[i], "--format")) {
            i += 1;
            if (i >= args.len)
                return error.FormatRequiresArgument;

            const format_str = args[i];

            ret.format = std.meta.stringToEnum(Database.Format, format_str) orelse {
                std.log.err("Unknown schema type: {s}, must be one of: svd, atdf, json, embassy", .{
                    format_str,
                });
                return error.Explained;
            };
        } else if (std.mem.eql(u8, args[i], "--output_path")) {
            i += 1;
            ret.output_path = try allocator.dupeZ(u8, args[i]);
        } else if (std.mem.eql(u8, args[i], "--device")) {
            i += 1;
            ret.device = try allocator.dupe(u8, args[i]);
        } else if (std.mem.eql(u8, args[i], "--patch_path")) {
            i += 1;
            try ret.append_patch_path(args[i]);
        } else if (std.mem.startsWith(u8, args[i], "-")) {
            std.log.err("Unknown argument '{s}'", .{args[i]});

            var buf: [80]u8 = undefined;
            var writer = std.fs.File.stderr().writer(&buf);
            try print_usage(&writer.interface);
            return error.Explained;
        } else if (ret.input_path != null) {
            std.log.err("Input path is already set to '{s}', you are trying to set it to '{s}'", .{
                ret.input_path.?,
                args[i],
            });
            return error.Explained;
        } else {
            ret.input_path = try allocator.dupe(u8, args[i]);
        };

    return ret;
}

fn main_impl() anyerror!void {
    defer xml.cleanupParser();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var args = try parse_args(allocator);
    defer args.deinit();

    if (args.help) {
        var buf: [80]u8 = undefined;
        var writer = std.fs.File.stdout().writer(&buf);
        try print_usage(&writer.interface);
        return;
    }

    const input_path = args.input_path orelse return error.MissingInputPath;
    const output_path = args.output_path orelse return error.MissingOutputPath;

    const format = args.format orelse {
        std.log.err("Format not specified", .{});
        return error.Explained;
    };

    var db = try Database.create_from_path(allocator, format, input_path, args.device);
    defer db.destroy();

    for (args.patch_paths.items) |patch_path| {
        const patch_text = try std.fs.cwd().readFileAllocOptions(allocator, patch_path, std.math.maxInt(u64), null, .@"1", 0);
        defer allocator.free(patch_text);

        var diags: std.zon.parse.Diagnostics = .{};
        defer diags.deinit(allocator);

        const patches = std.zon.parse.fromSlice([]const Patch, allocator, patch_text, &diags, .{}) catch |err| {
            std.log.err("Failed to parse zon patch file '{s}': {f}", .{ patch_path, diags });
            return err;
        };
        defer std.zon.parse.free(allocator, patches);

        for (patches) |patch|
            try db.apply_patch(patch);
    }

    // arch dependent stuff
    {
        var arena = ArenaAllocator.init(allocator);
        defer arena.deinit();

        for (try db.get_devices(arena.allocator())) |device| {
            if (device.arch.is_arm()) {
                const arm = @import("arch/arm.zig");
                try arm.load_system_interrupts(db, device.id, device.arch);
            }
        }
    }

    if (args.dump_path) |dump_path| {
        try db.backup(dump_path);
    }
    // output_path is the directory to write files
    var output_dir = try std.fs.cwd().makeOpenPath(output_path, .{});
    defer output_dir.close();

    var fs = FS_Directory.init(output_dir);
    try gen.to_zig(db, fs.directory(), .{});
}

test "all" {
    @setEvalBranchQuota(2000);
    _ = @import("analysis.zig");
    _ = @import("format/atdf.zig");
    _ = Database;
    _ = @import("gen.zig");
    _ = @import("format/svd.zig");
    _ = @import("VirtualFilesystem.zig");
}
