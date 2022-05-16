const std = @import("std");
const clap = @import("clap");
const xml = @import("xml.zig");
const svd = @import("svd.zig");
const Database = @import("Database.zig");

const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

pub const log_level: std.log.Level = .info;

const svd_schema = @embedFile("cmsis-svd.xsd");

const params = clap.parseParamsComptime(
    \\-h, --help                Display this help and exit
    \\-s, --schema <str>        Explicitly set schema type, one of: svd, atdf, json
    \\-o, --output_path <str>   Write to a file
    \\<str>...
    \\
);

pub fn main() !void {
    mainImpl() catch |err| switch (err) {
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

fn mainImpl() anyerror!void {
    defer xml.cleanupParser();

    var gpa = std.heap.GeneralPurposeAllocator(.{
        .stack_trace_frames = 20,
    }){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var arena = ArenaAllocator.init(allocator);
    defer arena.deinit();

    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{
        .diagnostic = &diag,
    }) catch |err| {
        // Report useful error and exit
        diag.report(std.io.getStdErr().writer(), err) catch {};
        return error.Explained;
    };
    defer res.deinit();

    if (res.args.help)
        return clap.help(std.io.getStdErr().writer(), clap.Help, &params, .{});

    var schema: ?Schema = if (res.args.schema) |schema_str|
        if (std.meta.stringToEnum(Schema, schema_str)) |s| s else {
            std.log.err(
                "Unknown schema type: {s}, must be one of: svd, atdf, json",
                .{
                    schema_str,
                },
            );
            return error.Explained;
        }
    else
        null;

    var db = switch (res.positionals.len) {
        0 => blk: {
            if (schema == null) {
                std.log.err("schema must be chosen when reading from stdin", .{});
                return error.Explained;
            }

            if (schema.? == .json) {
                return error.Todo;
            }

            var stdin = std.io.getStdIn().reader();
            const doc: *xml.Doc = xml.readIo(readFn, null, &stdin, null, null, 0) orelse return error.ReadXmlFd;
            defer xml.freeDoc(doc);

            break :blk try parseXmlDatabase(allocator, doc, schema.?);
        },
        1 => blk: {
            // if schema is null, then try to determine using file extension
            if (schema == null) {
                const ext = std.fs.path.extension(res.positionals[0]);
                if (ext.len > 0) {
                    schema = std.meta.stringToEnum(Schema, ext[1..]) orelse {
                        std.log.err("unable to determine schema from file extension of '{s}'", .{res.positionals[0]});
                        return error.Explained;
                    };
                }
            }

            // schema is guaranteed to be non-null from this point on
            if (schema.? == .json) {
                return error.Todo;
            }

            // all other schema types are xml based
            const doc: *xml.Doc = xml.readFile(res.positionals[0].ptr, null, 0) orelse return error.ReadXmlFile;
            defer xml.freeDoc(doc);

            break :blk try parseXmlDatabase(allocator, doc, schema.?);
        },
        else => {
            std.log.err("this program takes max one positional argument for now", .{});
            return error.Explained;
        },
    };
    defer db.deinit();

    const writer = if (res.args.output_path) |output_path|
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

    try db.toZig(writer);
}

fn readFn(ctx: ?*anyopaque, buffer: ?[*]u8, len: c_int) callconv(.C) c_int {
    if (buffer == null)
        return -1;

    return if (ctx) |c| blk: {
        const reader = @ptrCast(*std.fs.File.Reader, @alignCast(@alignOf(*std.fs.File.Reader), c));
        const n = reader.read(buffer.?[0..@intCast(usize, len)]) catch return -1;
        break :blk @intCast(c_int, n);
    } else -1;
}

fn parseXmlDatabase(allocator: Allocator, doc: *xml.Doc, schema: Schema) !Database {
    return switch (schema) {
        .json => unreachable,
        .atdf => try Database.initFromAtdf(allocator, doc),
        .svd => try Database.initFromSvd(allocator, doc),
        .dslite => return error.Todo,
        .xml => determine_type: {
            const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
            if (xml.findValueForKey(root_element, "device") != null)
                break :determine_type try Database.initFromSvd(allocator, doc)
            else if (xml.findValueForKey(root_element, "avr-tools-device-file") != null)
                break :determine_type try Database.initFromAtdf(allocator, doc)
            else {
                std.log.err("unable do detect register schema type", .{});
                return error.Explained;
            }
        },
    };
}
