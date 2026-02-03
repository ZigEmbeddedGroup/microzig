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
const RegisterSchemaUsage = @import("RegisterSchemaUsage");

const Allocator = std.mem.Allocator;

const StdoutWriter = struct {
    buf: [4096]u8 = undefined,
    file_writer: ?std.fs.File.Writer = null,

    fn writer(self: *StdoutWriter) *std.Io.Writer {
        if (self.file_writer == null) {
            self.file_writer = std.fs.File.stdout().writer(&self.buf);
        }
        return &self.file_writer.?.interface;
    }
};

const StderrWriter = struct {
    buf: [4096]u8 = undefined,
    file_writer: ?std.fs.File.Writer = null,

    fn writer(self: *StderrWriter) *std.Io.Writer {
        if (self.file_writer == null) {
            self.file_writer = std.fs.File.stderr().writer(&self.buf);
        }
        return &self.file_writer.?.interface;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    run(allocator) catch |err| {
        switch (err) {
            error.Explained => std.process.exit(1),
            else => return err,
        }
    };
}

fn run(allocator: Allocator) !void {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        try print_usage();
        return error.Explained;
    }

    const command = args[1];

    if (std.mem.eql(u8, command, "list")) {
        try run_list(allocator, args[2..]);
    } else if (std.mem.eql(u8, command, "generate")) {
        try run_generate(allocator, args[2..]);
    } else if (std.mem.eql(u8, command, "-h") or std.mem.eql(u8, command, "--help")) {
        try print_usage();
    } else {
        var stderr_writer: StderrWriter = .{};
        const stderr = stderr_writer.writer();
        try stderr.print("Unknown command: {s}\n\n", .{command});
        try stderr.flush();
        try print_usage();
        return error.Explained;
    }
}

fn print_usage() !void {
    var stdout_writer: StdoutWriter = .{};
    const stdout = stdout_writer.writer();
    try stdout.writeAll(
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
    );
    try stdout.flush();
}

// ─────────────────────────────────────────────────────────────────────────────
// List command
// ─────────────────────────────────────────────────────────────────────────────

fn run_list(allocator: Allocator, args: []const []const u8) !void {
    var port_filter: ?[]const u8 = null;
    var json_output = false;

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--port")) {
            i += 1;
            if (i >= args.len) {
                var stderr_writer: StderrWriter = .{};
                const stderr = stderr_writer.writer();
                try stderr.writeAll("Error: --port requires a value\n");
                try stderr.flush();
                return error.Explained;
            }
            port_filter = args[i];
        } else if (std.mem.eql(u8, arg, "--json")) {
            json_output = true;
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try print_usage();
            return;
        } else {
            var stderr_writer: StderrWriter = .{};
            const stderr = stderr_writer.writer();
            try stderr.print("Unknown option: {s}\n", .{arg});
            try stderr.flush();
            return error.Explained;
        }
    }

    if (json_output) {
        try print_list_json(allocator, port_filter);
    } else {
        try print_list_table(allocator, port_filter);
    }
}

fn print_list_table(allocator: Allocator, port_filter: ?[]const u8) !void {
    var stdout_writer: StdoutWriter = .{};
    const stdout = stdout_writer.writer();

    // Track seen chip names to deduplicate display
    var seen_chips = std.StringHashMap(void).init(allocator);
    defer seen_chips.deinit();

    // Print header
    stdout.print("{s:<24} {s}\n", .{ "CHIP", "PORT" }) catch |err| return handle_write_error(err);
    stdout.print("{s:-<24} {s:-<24}\n", .{ "", "" }) catch |err| return handle_write_error(err);

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
            seen_chips.put(chip.name, {}) catch {};

            stdout.print("{s:<24} {s}\n", .{ chip.name, port_name }) catch |err| return handle_write_error(err);
        }
    }
    stdout.flush() catch |err| return handle_write_error(err);
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

fn print_list_json(allocator: Allocator, port_filter: ?[]const u8) !void {
    var entries: std.ArrayList(JsonEntry) = .{};
    defer entries.deinit(allocator);

    // Track seen chip names to deduplicate
    var seen_chips = std.StringHashMap(void).init(allocator);
    defer seen_chips.deinit();

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
            seen_chips.put(chip.name, {}) catch {};

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

    var stdout_writer: StdoutWriter = .{};
    const stdout = stdout_writer.writer();
    stdout.writeAll(json_str) catch |err| return handle_write_error(err);
    stdout.writeByte('\n') catch |err| return handle_write_error(err);
    stdout.flush() catch |err| return handle_write_error(err);
}

const JsonEntry = struct {
    chip: []const u8,
    port: []const u8,
    format: []const u8,
};

fn get_port_name(location: RegisterSchemaUsage.Location) []const u8 {
    return switch (location) {
        .src_path => |src| src.port_name,
        .dependency => |dep| dep.port_name,
    };
}

// ─────────────────────────────────────────────────────────────────────────────
// Generate command
// ─────────────────────────────────────────────────────────────────────────────

fn run_generate(allocator: Allocator, args: []const []const u8) !void {
    var chip_name: ?[]const u8 = null;
    var output_path: []const u8 = "./zig-out";

    var i: usize = 0;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "-o") or std.mem.eql(u8, arg, "--output")) {
            i += 1;
            if (i >= args.len) {
                var stderr_writer: StderrWriter = .{};
                const stderr = stderr_writer.writer();
                try stderr.writeAll("Error: --output requires a value\n");
                try stderr.flush();
                return error.Explained;
            }
            output_path = args[i];
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try print_usage();
            return;
        } else if (!std.mem.startsWith(u8, arg, "-")) {
            chip_name = arg;
        } else {
            var stderr_writer: StderrWriter = .{};
            const stderr = stderr_writer.writer();
            try stderr.print("Unknown option: {s}\n", .{arg});
            try stderr.flush();
            return error.Explained;
        }
    }

    const chip = chip_name orelse {
        var stderr_writer: StderrWriter = .{};
        const stderr = stderr_writer.writer();
        try stderr.writeAll("Error: chip name is required\n");
        try stderr.writeAll("Usage: sorcerer-cli generate <chip> [-o <dir>]\n");
        try stderr.flush();
        return error.Explained;
    };

    // Find matching schema
    const schema = find_schema(chip) orelse {
        var stderr_writer: StderrWriter = .{};
        const stderr = stderr_writer.writer();
        try stderr.print("Error: chip '{s}' not found\n", .{chip});
        try stderr.writeAll("Use 'sorcerer-cli list' to see available chips\n");
        try stderr.flush();
        return error.Explained;
    };

    try generate_code(allocator, schema, chip, output_path);
}

fn find_schema(chip_name: []const u8) ?RegisterSchemaUsage {
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
    schema: RegisterSchemaUsage,
    chip_name: []const u8,
    output_path: []const u8,
) !void {
    var stderr_writer: StderrWriter = .{};
    const stderr = stderr_writer.writer();
    var stdout_writer: StdoutWriter = .{};
    const stdout = stdout_writer.writer();

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
    var db = regz.Database.create_from_path(allocator, format, input_path, chip_name) catch |err| {
        try stderr.print("Error loading register definition: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };
    defer db.destroy();

    // Generate to virtual filesystem first
    var vfs = regz.VirtualFilesystem.init(allocator);
    defer vfs.deinit();

    db.to_zig(vfs.dir(), .{}) catch |err| {
        try stderr.print("Error generating Zig code: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };

    // Write virtual filesystem contents to actual directory
    var output_dir = std.fs.cwd().makeOpenPath(output_path, .{}) catch |err| {
        try stderr.print("Error creating output directory: {}\n", .{err});
        try stderr.flush();
        return error.Explained;
    };
    defer output_dir.close();

    const files_written = try write_vfs_to_dir(allocator, &vfs, output_dir, .root, "");

    try stdout.print("Generated {d} file(s)\n", .{files_written});
    try stdout.flush();
}

fn get_full_path(allocator: Allocator, location: RegisterSchemaUsage.Location) ![]const u8 {
    return switch (location) {
        .src_path => |src| try std.fmt.allocPrint(allocator, "{s}/{s}", .{ src.build_root, src.sub_path }),
        .dependency => |dep| try std.fmt.allocPrint(allocator, "{s}/{s}", .{ dep.build_root, dep.sub_path }),
    };
}

fn write_vfs_to_dir(
    allocator: Allocator,
    vfs: *regz.VirtualFilesystem,
    output_dir: std.fs.Dir,
    parent_id: regz.VirtualFilesystem.ID,
    parent_path: []const u8,
) !usize {
    var files_written: usize = 0;

    const children = try vfs.get_children(allocator, parent_id);
    defer allocator.free(children);

    for (children) |child| {
        const name = vfs.get_name(child.id);
        const full_path = if (parent_path.len > 0)
            try std.fmt.allocPrint(allocator, "{s}/{s}", .{ parent_path, name })
        else
            try allocator.dupe(u8, name);
        defer allocator.free(full_path);

        switch (child.kind) {
            .file => {
                const content = vfs.get_content(child.id);

                // Create subdirectory if needed
                if (std.fs.path.dirname(full_path)) |dirname| {
                    try output_dir.makePath(dirname);
                }

                const file = try output_dir.createFile(full_path, .{});
                defer file.close();
                try file.writeAll(content);

                files_written += 1;
            },
            .directory => {
                files_written += try write_vfs_to_dir(allocator, vfs, output_dir, child.id, full_path);
            },
        }
    }

    return files_written;
}
