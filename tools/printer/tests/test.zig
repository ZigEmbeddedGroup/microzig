const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

var buf: [1024]u8 = undefined;

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len != 3)
        return error.UsageError;

    const elf_path = args[1];
    const test_data_path = args[2];
    const test_name = std.fs.path.stem(test_data_path);

    const elf_file = try std.Io.Dir.cwd().openFile(io, elf_path, .{});
    defer elf_file.close(io);

    var elf_file_reader = elf_file.reader(io, &buf);

    var elf = try printer.Elf.init(gpa, &elf_file_reader);
    defer elf.deinit(gpa);

    const test_data_raw = try std.Io.Dir.cwd().readFileAllocOptions(io, test_data_path, gpa, .limited(1_000_000), .@"1", 0);
    defer gpa.free(test_data_raw);

    const test_data = try std.zon.parse.fromSliceAlloc(common.Data, gpa, test_data_raw, null, .{});
    defer std.zon.parse.free(gpa, test_data);

    var debug_info = try printer.DebugInfo.init(gpa, elf);
    defer debug_info.deinit(gpa);

    if (!std.mem.eql(u8, test_data.zig_version, builtin.zig_version_string))
        return error.ZigVersionMismatch;

    for (test_data.tests) |t| {
        const actual = debug_info.query(t.address);
        const actual_loc = actual.source_location.?;

        try std.testing.expectEqual(t.expected.line, actual_loc.line);
        try std.testing.expectEqual(t.expected.column, actual_loc.column);
        try std.testing.expectEqualStrings(t.expected.file_path, actual_loc.file_path);

        try std.testing.expectEqualStrings(t.expected.function_name orelse "", actual.function_name orelse "");
        try std.testing.expectEqualStrings(t.expected.module_name orelse "", actual.module_name orelse "");
    }

    std.debug.print("test {s}: success\n", .{test_name});
}
