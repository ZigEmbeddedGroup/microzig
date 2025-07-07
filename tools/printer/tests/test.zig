const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

const elf_data = @embedFile("elf");

const test_data: common.Data = @import("test_data.zon");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    var elf_fbs = std.io.fixedBufferStream(elf_data);
    var elf = try printer.Elf.init(allocator, &elf_fbs);
    defer elf.deinit(allocator);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    try std.testing.expectEqual(test_data.zig_version_string, builtin.zig_version_string);

    for (test_data.tests) |t| {
        const actual = try debug_info.query(allocator, t.address);
        defer if (actual.file_path) |file_path| allocator.free(file_path);

        try std.testing.expectEqualDeep(actual, t.query_result);
    }

    std.debug.print("test: success\n", .{});
}
