const std = @import("std");
const clap = @import("clap");
const xml = @import("xml.zig");
const Database = @import("Database.zig");

const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const svd_schema = @embedFile("cmsis-svd.xsd");

pub fn main() !void {
    main_impl() catch |err| switch (err) {
        error.Explained => std.process.exit(1),
        else => return err,
    };
}

const Arguments = struct {
    allocator: Allocator,
    schema: ?Database.Schema = null,
    input_path: ?[]const u8 = null,
    output_path: ?[]const u8 = null,
    output_json: bool = false,
    standalone: bool = false,
    help: bool = false,

    fn deinit(args: *Arguments) void {
        if (args.input_path) |input_path| args.allocator.free(input_path);
        if (args.output_path) |output_path| args.allocator.free(output_path);
    }
};

fn print_usage(writer: anytype) !void {
    try writer.writeAll(
        \\regz
        \\  --help                Display this help and exit
        \\  --schema <str>        Explicitly set schema type, one of: svd, atdf, json
        \\  --output_path <str>   Write to a file
        \\  --json                Write output as JSON
        \\  --standalone          Write standalone output with no microzig dependencies
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
        } else if (std.mem.eql(u8, args[i], "--schema")) {
            i += 1;
            if (i >= args.len)
                return error.SchemaRequiresArgument;

            const schema_str = args[i];

            ret.schema = std.meta.stringToEnum(Database.Schema, schema_str) orelse {
                std.log.err("Unknown schema type: {s}, must be one of: svd, atdf, json", .{
                    schema_str,
                });
                return error.Explained;
            };
        } else if (std.mem.eql(u8, args[i], "--output_path")) {
            i += 1;
            ret.output_path = try allocator.dupe(u8, args[i]);
        } else if (std.mem.eql(u8, args[i], "--json")) {
            ret.output_json = true;
        } else if (std.mem.eql(u8, args[i], "--standalone")) {
            ret.standalone = true;
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

    var db = if (args.input_path) |input_path| blk: {
        const schema = args.schema orelse schema: {
            // if schema is null, then try to determine using file extension
            const ext = std.fs.path.extension(input_path);
            if (ext.len > 0) {
                break :schema std.meta.stringToEnum(Database.Schema, ext[1..]) orelse {
                    std.log.err("unable to determine schema from file extension of '{s}'", .{input_path});
                    return error.Explained;
                };
            }

            std.log.err("unable to determine schema from file extension of '{s}'", .{input_path});
            return error.Explained;
        };
        const file = try std.fs.cwd().openFile(input_path, .{});
        defer file.close();
        const reader = file.reader().any();
        break :blk try Database.init_from_reader(allocator, reader, schema);
    } else blk: {
        const stdin = std.io.getStdIn().reader().any();
        break :blk try Database.init_from_reader(allocator, stdin, args.schema);
    };
    defer db.deinit();

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
    if (args.output_json)
        try db.json_stringify(
            .{ .whitespace = .indent_2 },
            buffered.writer(),
        )
    else
        try db.to_zig(buffered.writer(), args.standalone);

    try buffered.flush();
}
