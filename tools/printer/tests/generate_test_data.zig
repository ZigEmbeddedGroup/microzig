const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

pub fn main() !void {
    var arena_allocator: std.heap.ArenaAllocator = .init(std.heap.page_allocator);
    defer arena_allocator.deinit();
    const allocator = arena_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);

    if (args.len != 1 and args.len != 3) {
        return error.UsageError;
    }

    const elf_paths: []const []const u8 = &.{
        "tests/test_program.dwarf32.elf",
        "tests/test_program.dwarf64.elf",
    };

    const cwd = std.fs.cwd();
    if (args.len == 3) {
        try cwd.copyFile(args[1], cwd, "tests/test_program.dwarf32.elf", .{});
        try cwd.copyFile(args[2], cwd, "tests/test_program.dwarf64.elf", .{});
    }

    var test_data_file = try std.fs.cwd().createFile("tests/test_data.zon", .{});
    defer test_data_file.close();

    var all_data: std.ArrayListUnmanaged(common.Data) = .empty;

    for (elf_paths) |elf_path| {
        const elf_file = try std.fs.cwd().openFile(elf_path, .{});
        defer elf_file.close();

        const elf = try printer.Elf.init(allocator, elf_file);
        var debug_info = try printer.DebugInfo.init(allocator, elf);

        var tests: std.ArrayListUnmanaged(common.Test) = .empty;
        for (elf.loaded_regions) |region| {
            if (!region.flags.exec) continue;

            var address = region.start_address;
            while (address < region.end_address) : (address += 0x1000) {
                const query_result = debug_info.query(address);
                try tests.append(allocator, .{
                    .address = address,
                    .query_result = query_result,
                });
            }
        }

        try all_data.append(allocator, .{
            .elf_path = elf_path,
            .tests = tests.items,
        });
    }

    const writer = test_data_file.writer();
    try std.zon.stringify.serialize(all_data.items, .{}, writer);
    try writer.writeByte('\n');
}
