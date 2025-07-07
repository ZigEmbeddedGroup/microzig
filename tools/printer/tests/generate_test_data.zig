const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

const elf_data = @embedFile("elf");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    var test_data_file = try std.fs.cwd().createFile("tests/test_data.zon", .{});
    defer test_data_file.close();

    var elf_fbs = std.io.fixedBufferStream(elf_data);
    var elf = try printer.Elf.init(allocator, &elf_fbs);
    defer elf.deinit(allocator);

    var debug_info = try printer.DebugInfo.init(allocator, elf);
    defer debug_info.deinit(allocator);

    var tests: std.ArrayListUnmanaged(common.Test) = .empty;
    defer {
        for (tests.items) |t| {
            if (t.query_result.file_path) |file_path| allocator.free(file_path);
        }
        tests.deinit(allocator);
    }

    for (elf.loaded_regions) |region| {
        if (!region.flags.exec) continue;

        var address = region.start_address;
        while (address < region.end_address) : (address += 1024) {
            const query_result = try debug_info.query(allocator, address);
            try tests.append(allocator, .{
                .address = address,
                .query_result = query_result,
            });
        }
    }

    const test_data: common.Data = .{
        .zig_version_string = builtin.zig_version_string,
        .tests = tests.items,
    };
    try std.zon.stringify.serialize(test_data, .{}, test_data_file.writer());
}
