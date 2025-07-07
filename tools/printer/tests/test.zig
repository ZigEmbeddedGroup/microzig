const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

const elf_data = @embedFile("elf");

const all_data: []const common.Data = @import("test_data.zon");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    for (all_data) |data| {
        const elf_file = try std.fs.cwd().openFile(data.elf_path, .{});
        defer elf_file.close();

        var elf = try printer.Elf.init(allocator, elf_file);
        defer elf.deinit(allocator);

        var debug_info = try printer.DebugInfo.init(allocator, elf);
        defer debug_info.deinit(allocator);

        for (data.tests) |t| {
            const actual = try debug_info.query(allocator, t.address);
            defer if (actual.file_path) |file_path| allocator.free(file_path);

            try std.testing.expectEqual(t.query_result.line, actual.line);
            try std.testing.expectEqual(t.query_result.column, actual.column);
            try expect_equal_maybe_strings(t.query_result.file_path, actual.file_path);
            try expect_equal_maybe_strings(t.query_result.function_name, actual.function_name);
            try expect_equal_maybe_strings(t.query_result.module_name, actual.module_name);
        }
    }

    std.debug.print("test: success\n", .{});
}

fn expect_equal_maybe_strings(expected: ?[]const u8, actual: ?[]const u8) !void {
    return std.testing.expectEqualStrings(expected orelse "", actual orelse "");
}
