//! sorcerer-cli: Command-line interface for MicroZig register definitions
//!
//! A lightweight CLI tool that provides access to MicroZig register definitions without GUI
//! dependencies. Generates Zig register code from SVD/ATDF files.
//!
//! Usage:
//!   sorcerer-cli list [--port <name>] [--json]
//!   sorcerer-cli generate <chip> [-o <dir>]
//!
const std = @import("std");
const regz = @import("regz");
const schemas = @import("schemas");

const Allocator = std.mem.Allocator;
const VirtualIo = regz.virtual_io.VirtualIo;
const Writer = std.Io.Writer;

const usage =
    \\sorcerer-cli - MicroZig Register Definition Tool
    \\
    \\Usage:
    \\  sorcerer-cli <command> [options]
    \\
    \\Commands:
    \\  list                    List all available targets
    \\  generate <chip>         Generate register definitions for a chip
    \\
    \\Options for 'list':
    \\  --port <name>           Filter by port name (e.g., rp2xxx, ch32v)
    \\  --json                  Output in JSON format
    \\
    \\Options for 'generate':
    \\  -o, --output <dir>      Output directory (default: ./zig-out)
    \\
    \\General options:
    \\  -h, --help              Show this help
    \\
    \\Examples:
    \\  sorcerer-cli list
    \\  sorcerer-cli list --port rp2xxx
    \\  sorcerer-cli list --json
    \\  sorcerer-cli generate RP2040 -o ./my-regs/
    \\
;

pub fn main(init: std.process.Init) !void {
    run(init) catch |err| {
        switch (err) {
            error.Explained => std.process.exit(1),
            else => return err,
        }
    };
}

fn run(init: std.process.Init) !void {
    const gpa = init.gpa;
    const arena = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(arena);

    var stdout_writer = std.Io.File.stderr()
        .writer(io, try arena.alloc(u8, 4 * 1024));
    const stdout = &stdout_writer.interface;

    var stderr_writer = std.Io.File.stderr()
        .writer(io, try arena.alloc(u8, 4 * 1024));
    const stderr = &stderr_writer.interface;

    if (args.len < 2) {
        try stdout.writeAll(usage);
        try stdout.flush();
        return error.Explained;
    }

    const command = args[1];

    if (std.mem.eql(u8, command, "list")) {
        try run_list(gpa, args[2..], stdout, stderr);
    } else if (std.mem.eql(u8, command, "generate")) {
        try run_generate(gpa, io, args[2..], stdout, stderr);
    } else if (std.mem.eql(u8, command, "-h") or std.mem.eql(u8, command, "--help")) {
        try stdout.writeAll(usage);
        try stdout.flush();
    } else {
        try stderr.print("Unknown command: {s}\n\n", .{command});
        try stderr.flush();
        try stdout.writeAll(usage);
        try stdout.flush();
        return error.Explained;
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// List command
// ─────────────────────────────────────────────────────────────────────────────

fn run_list(allocator: Allocator, args: []const []const u8, stdout: *Writer, stderr: *Writer) !void {
    var port_filter: ?[]const u8 = null;
    var json_output = false;

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--port")) {
            i += 1;
            if (i >= args.len) {
                try stderr.writeAll("Error: --port requires a value\n");
                try stderr.flush();
                return error.Explained;
            }
            port_filter = args[i];
        } else if (std.mem.eql(u8, arg, "--json")) {
            json_output = true;
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try stdout.writeAll(usage);
            try stdout.flush();
            return;
        } else {
            try stderr.print("Unknown option: {s}\n", .{arg});
            try stderr.flush();
            return error.Explained;
        }
    }

    if (json_output) {
        try print_list_json(allocator, port_filter, stdout);
    } else {
        try print_list_table(allocator, port_filter, stdout);
    }
}

fn print_list_table(allocator: Allocator, port_filter: ?[]const u8, w: *Writer) !void {
    // Track seen chip names to deduplicate display
    var seen_chips: std.StringHashMapUnmanaged(void) = .empty;
    defer seen_chips.deinit(allocator);

    // Print header
    w.print("{s:<24} {s}\n", .{ "CHIP", "PORT" }) catch |err| return handle_write_error(err);
    w.print("{s:-<24} {s:-<24}\n", .{ "", "" }) catch |err| return handle_write_error(err);

    // Print entries (one line per unique chip)
    for (schemas.schemas) |schema| {
        const port_name = get_port_name(schema.location);

        // Apply filter
        if (port_filter) |filter| {
            if (std.mem.indexOf(u8, port_name, filter) == null) {
                continue;
            }
        }

        for (schema.chips) |chip| {
            // Skip if we've already shown this chip name
            if (seen_chips.contains(chip.name)) {
                continue;
            }
            seen_chips.put(allocator, chip.name, {}) catch {};

            w.print("{s:<24} {s}\n", .{ chip.name, port_name }) catch |err| return handle_write_error(err);
        }
    }
    w.flush() catch |err| return handle_write_error(err);
}

/// Handle write errors - exit silently on BrokenPipe so that we can e.g. pipe to `more`.
fn handle_write_error(err: anyerror) error{Explained} {
    return switch (err) {
        error.BrokenPipe => {
            // Pipe closed by reader (e.g., `head`). Exit silently.
            std.process.exit(0);
        },
        else => error.Explained,
    };
}

fn print_list_json(allocator: Allocator, port_filter: ?[]const u8, w: *Writer) !void {
    var entries: std.ArrayList(JsonEntry) = .empty;
    defer entries.deinit(allocator);

    // Track seen chip names to deduplicate
    var seen_chips: std.StringHashMapUnmanaged(void) = .empty;
    defer seen_chips.deinit(allocator);

    for (schemas.schemas) |schema| {
        const port_name = get_port_name(schema.location);

        // Apply filter
        if (port_filter) |filter| {
            if (std.mem.indexOf(u8, port_name, filter) == null) {
                continue;
            }
        }

        for (schema.chips) |chip| {
            // Skip if we've already added this chip name
            if (seen_chips.contains(chip.name)) {
                continue;
            }
            seen_chips.put(allocator, chip.name, {}) catch {};

            try entries.append(allocator, .{
                .chip = chip.name,
                .port = port_name,
                .format = @tagName(schema.format),
            });
        }
    }

    // Serialize to JSON string and print
    const json_str = try std.json.Stringify.valueAlloc(allocator, entries.items, .{ .whitespace = .indent_2 });
    defer allocator.free(json_str);

    w.writeAll(json_str) catch |err| return handle_write_error(err);
    w.writeByte('\n') catch |err| return handle_write_error(err);
    w.flush() catch |err| return handle_write_error(err);
}

const JsonEntry = struct {
    chip: []const u8,
    port: []const u8,
    format: []const u8,
};

fn get_port_name(location: schemas.Usage.Location) []const u8 {
    return switch (location) {
        .src_path => |src| src.port_name,
        .dependency => |dep| dep.port_name,
    };
}

// ─────────────────────────────────────────────────────────────────────────────
// Generate command
// ─────────────────────────────────────────────────────────────────────────────

fn run_generate(
    allocator: Allocator,
    io: std.Io,
    args: []const []const u8,
    stdout: *Writer,
    stderr: *Writer,
) !void {
    var chip_name: ?[]const u8 = null;
    var output_path: []const u8 = "./zig-out";

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "-o") or std.mem.eql(u8, arg, "--output")) {
            i += 1;
            if (i >= args.len) {
                try stderr.writeAll("Error: --output requires a value\n");
                try stderr.flush();
                return error.Explained;
            }
            output_path = args[i];
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try stdout.writeAll(usage);
            try stdout.flush();
            return;
        } else if (!std.mem.startsWith(u8, arg, "-")) {
            chip_name = arg;
        } else {
            try stderr.print("Unknown option: {s}\n", .{arg});
            try stderr.flush();
            return error.Explained;
        }
    }

    const chip = chip_name orelse {
        try stderr.writeAll("Error: chip name is required\n");
        try stderr.writeAll("Usage: sorcerer-cli generate <chip> [-o <dir>]\n");
        try stderr.flush();
        return error.Explained;
    };

    // Find matching schema
    const schema = find_schema(chip) orelse {
        try stderr.print("Error: chip '{s}' not found\n", .{chip});
        try stderr.writeAll("Use 'sorcerer-cli list' to see available chips\n");
        try stderr.flush();
        return error.Explained;
    };

    try generate_code(
        allocator,
        io,
        schema,
        chip,
        output_path,
        stdout,
        stderr,
    );
}

fn find_schema(chip_name: []const u8) ?schemas.Usage {
    for (schemas.schemas) |schema| {
        for (schema.chips) |chip| {
            if (std.mem.eql(u8, chip.name, chip_name)) {
                return schema;
            }
        }
    }
    return null;
}

fn generate_code(
    allocator: Allocator,
    io: std.Io,
    schema: schemas.Usage,
    chip_name: []const u8,
    output_path: []const u8,
    stdout: *Writer,
    stderr: *Writer,
) !void {
    // Get full path to register definition file
    const input_path = try get_full_path(allocator, schema.location);
    defer allocator.free(input_path);

    try stdout.print("Generating register definitions for {s}...\n", .{chip_name});
    try stdout.print("  Input: {s}\n", .{input_path});
    try stdout.print("  Output: {s}/\n", .{output_path});
    try stdout.flush();

    // Map format
    const format: regz.Database.Format = switch (schema.format) {
        .svd => .svd,
        .atdf => .atdf,
        .embassy => .embassy,
        .targetdb => .targetdb,
    };

    // Create database from register definition file
    var db = regz.Database.create_from_path(allocator, io, format, input_path, chip_name) catch |err| {
        try stderr.print("Error loading register definition: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };
    defer db.destroy();

    // Generate to virtual filesystem first
    var vfs = try VirtualIo.init(allocator);
    defer vfs.deinit();

    db.to_zig(vfs.io(), VirtualIo.root_dir, .{}) catch |err| {
        try stderr.print("Error generating Zig code: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };

    // Write virtual filesystem contents to actual directory
    var output_dir = std.Io.Dir.cwd().createDirPathOpen(io, output_path, .{}) catch |err| {
        try stderr.print("Error creating output directory: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };
    defer output_dir.close(io);

    const files_written = try vfs.save_dir_recursive(.root, io, output_dir);

    try stdout.print("Generated {} file(s)\n", .{files_written});
    try stdout.flush();
}

fn get_full_path(allocator: Allocator, location: schemas.Usage.Location) ![]const u8 {
    return switch (location) {
        .src_path => |src| try std.fmt.allocPrint(allocator, "{s}/{s}", .{ src.build_root, src.sub_path }),
        .dependency => |dep| try std.fmt.allocPrint(allocator, "{s}/{s}", .{ dep.build_root, dep.sub_path }),
    };
}
