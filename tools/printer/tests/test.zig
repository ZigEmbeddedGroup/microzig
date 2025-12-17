const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

var buf: [1024]u8 = undefined;

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 3) return error.UsageError;

    const elf_path = args[1];
    const test_data_path = args[2];
    const test_name = std.fs.path.stem(test_data_path);

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();

    var elf_file_reader = elf_file.reader(&buf);

    var elf = try printer.Elf.init(allocator, &elf_file_reader);
    defer elf.deinit(allocator);

    const test_data_raw = try std.fs.cwd().readFileAllocOptions(allocator, test_data_path, 1_000_000, null, .@"1", 0);
    defer allocator.free(test_data_raw);

    const test_data = try std.zon.parse.fromSlice(common.Data, allocator, test_data_raw, null, .{});
    defer std.zon.parse.free(allocator, test_data);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    if (!std.mem.eql(u8, test_data.zig_version, builtin.zig_version_string)) return error.ZigVersionMismatch;

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
