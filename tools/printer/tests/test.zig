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
            const actual = debug_info.query(t.address);

            // Just a bit prettier output.
            if (t.query_result.source_location != null and actual.source_location != null) {
                const expected_loc = t.query_result.source_location.?;
                const actual_loc = actual.source_location.?;

                try std.testing.expectEqual(expected_loc.line, actual_loc.line);
                try std.testing.expectEqual(expected_loc.column, actual_loc.column);
                try std.testing.expectEqualStrings(expected_loc.file_path, actual_loc.file_path);
                try std.testing.expectEqualStrings(expected_loc.dir_path, actual_loc.dir_path);
            } else {
                try std.testing.expectEqual(t.query_result.source_location, actual.source_location);
            }

            try std.testing.expectEqualStrings(t.query_result.function_name orelse "", actual.function_name orelse "");
            try std.testing.expectEqualStrings(t.query_result.module_name orelse "", actual.module_name orelse "");
        }
    }

    std.debug.print("test: success\n", .{});
}
