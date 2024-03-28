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

const Schema = enum {
    atdf,
    dslite,
    json,
    svd,
    xml,
};

const Arguments = struct {
    allocator: Allocator,
    schema: ?Schema = null,
    input_path: ?[]const u8 = null,
    output_path: ?[]const u8 = null,
    output_json: bool = false,
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

            ret.schema = std.meta.stringToEnum(Schema, schema_str) orelse {
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
                break :schema std.meta.stringToEnum(Schema, ext[1..]) orelse {
                    std.log.err("unable to determine schema from file extension of '{s}'", .{input_path});
                    return error.Explained;
                };
            }

            std.log.err("unable to determine schema from file extension of '{s}'", .{input_path});
            return error.Explained;
        };

        const path = try arena.allocator().dupeZ(u8, input_path);
        if (schema == .json) {
            const file = try std.fs.cwd().openFile(path, .{});
            defer file.close();

            const text = try file.reader().readAllAlloc(allocator, std.math.maxInt(usize));
            defer allocator.free(text);

            break :blk try Database.init_from_json(allocator, text);
        }

        // all other schema types are xml based
        var doc = try xml.Doc.from_file(path);
        defer doc.deinit();

        break :blk try parse_xml_database(allocator, doc, schema);
    } else blk: {
        if (args.schema == null) {
            std.log.err("schema must be chosen when reading from stdin", .{});
            return error.Explained;
        }

        var stdin = std.io.getStdIn().reader();
        var doc = try xml.Doc.from_io(read_fn, &stdin);
        defer doc.deinit();

        break :blk try parse_xml_database(allocator, doc, args.schema.?);
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
        try db.to_zig(buffered.writer());

    try buffered.flush();
}

fn read_fn(ctx: ?*anyopaque, buffer: ?[*]u8, len: c_int) callconv(.C) c_int {
    if (buffer == null)
        return -1;

    return if (ctx) |c| blk: {
        const reader = @as(*std.fs.File.Reader, @ptrCast(@alignCast(c)));
        const n = reader.read(buffer.?[0..@as(usize, @intCast(len))]) catch return -1;
        break :blk @as(c_int, @intCast(n));
    } else -1;
}

fn parse_xml_database(allocator: Allocator, doc: xml.Doc, schema: Schema) !Database {
    return switch (schema) {
        .json => unreachable,
        .atdf => try Database.init_from_atdf(allocator, doc),
        .svd => try Database.init_from_svd(allocator, doc),
        .dslite => return error.Todo,
        .xml => return error.Todo,
        //determine_type: {
        //    const root = try doc.getRootElement();
        //    if (xml.findValueForKey(root, "device") != null)
        //        break :determine_type try Database.initFromSvd(allocator, doc)
        //    else if (xml.findValueForKey(root, "avr-tools-device-file") != null)
        //        break :determine_type try Database.initFromAtdf(allocator, doc)
        //    else {
        //        std.log.err("unable do detect register schema type", .{});
        //        return error.Explained;
        //    }
        //},
    };
}
