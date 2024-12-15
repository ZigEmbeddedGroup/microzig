const std = @import("std");
const clap = @import("clap");
const xml = @import("xml.zig");
const Database = @import("Database.zig");

const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const file_size_max = 100 * 1024 * 1024;
pub const std_options = std.Options{
    .log_level = .debug,
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
    patch_path: ?[]const u8 = null,
    dump: bool = false,
    help: bool = false,

    fn deinit(args: *Arguments) void {
        if (args.input_path) |input_path| args.allocator.free(input_path);
        if (args.output_path) |output_path| args.allocator.free(output_path);
        if (args.patch_path) |patch_path| args.allocator.free(patch_path);
    }
};

fn print_usage(writer: anytype) !void {
    try writer.writeAll(
        \\regz
        \\  --help                Display this help and exit
        \\  --dump                Dump SQLite file instead of generate code
        \\  --format <str>        Explicitly set format type, one of: svd, atdf, json
        \\  --output_path <str>   Write to a file
        \\  --patch_path <str>    After reading format, apply NDJSON based patch file
        \\<str>
        \\
    );
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
        } else if (std.mem.eql(u8, args[i], "--dump")) {
            ret.dump = true;
        } else if (std.mem.eql(u8, args[i], "--format")) {
            i += 1;
            if (i >= args.len)
                return error.FormatRequiresArgument;

            const format_str = args[i];

            ret.format = std.meta.stringToEnum(Database.Format, format_str) orelse {
                std.log.err("Unknown schema type: {s}, must be one of: svd, atdf, json", .{
                    format_str,
                });
                return error.Explained;
            };
        } else if (std.mem.eql(u8, args[i], "--output_path")) {
            i += 1;
            ret.output_path = try allocator.dupeZ(u8, args[i]);
        } else if (std.mem.eql(u8, args[i], "--patch_path")) {
            i += 1;
            ret.patch_path = try allocator.dupe(u8, args[i]);
        } else if (std.mem.startsWith(u8, args[i], "-")) {
            std.log.err("Unknown argument '{s}'", .{args[i]});
            try print_usage(std.io.getStdErr().writer());
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
    var arena = ArenaAllocator.init(allocator);
    defer arena.deinit();

    var args = try parse_args(allocator);
    defer args.deinit();

    if (args.help) {
        try print_usage(std.io.getStdOut().writer());
        return;
    }

    // TODO: if format not specified, try using file extension
    const text = if (args.input_path) |input_path| blk: {
        break :blk try std.fs.cwd().readFileAlloc(allocator, input_path, file_size_max);
    } else blk: {
        const stdin = std.io.getStdIn().reader().any();
        break :blk try stdin.readAllAlloc(allocator, file_size_max);
    };
    defer allocator.free(text);

    const format = args.format orelse {
        std.log.err("Format not specified", .{});
        return error.Explained;
    };

    var db = try Database.create_from_xml(allocator, format, text);
    defer db.destroy();

    if (args.patch_path) |patch_path| {
        const patch = try std.fs.cwd().readFileAlloc(allocator, patch_path, 1024 * 1024);
        defer allocator.free(patch);

        // TODO: diagnostics
        try db.apply_patch(patch);
    }

    if (args.dump) {
        const output_path = args.output_path orelse return error.MissingOutputPath;
        try db.backup(output_path);
        return;
    }

    const raw_writer = if (args.output_path) |output_path|
        if (std.fs.path.isAbsolute(output_path)) writer: {
            if (std.fs.path.dirname(output_path)) |dirname| {
                _ = dirname;
                // TODO: recursively create absolute path if it doesn't exist
            }

            break :writer (try std.fs.createFileAbsolute(output_path, .{})).writer();
        } else writer: {
            if (std.fs.path.dirname(output_path)) |dirname|
                try std.fs.cwd().makePath(dirname);

            break :writer (try std.fs.cwd().createFile(output_path, .{})).writer();
        }
    else
        std.io.getStdOut().writer();

    var buffered = std.io.bufferedWriter(raw_writer);
    try db.to_zig(buffered.writer());
    try buffered.flush();
}
