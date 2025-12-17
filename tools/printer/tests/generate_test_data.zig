const builtin = @import("builtin");
const std = @import("std");
const printer = @import("printer");

const common = @import("common");

var test_data_writer_buf: [1024]u8 = undefined;
var elf_file_reader_buf: [1024]u8 = undefined;

pub fn main() !void {
    var arena_allocator: std.heap.ArenaAllocator = .init(std.heap.page_allocator);
    defer arena_allocator.deinit();
    const allocator = arena_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    if (args.len != 3) return error.UsageError;

    const elf_path = args[1];
    const test_data_path = args[2];

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    var elf_file_reader = elf_file.reader(&elf_file_reader_buf);

    const elf = try printer.Elf.init(allocator, &elf_file_reader);
    var debug_info = try printer.DebugInfo.init(allocator, elf);

    var tests: std.ArrayList(common.Test) = .empty;

    for (debug_info.loc_list[0..@min(debug_info.loc_list.len, 10)]) |tmp_src_loc| {
        const address = tmp_src_loc.address;
        const query_result = debug_info.query(address);
        const src_loc = query_result.source_location.?; // this shouldn't be null

        try tests.append(allocator, .{
            .address = address,
            .expected = .{
                .line = src_loc.line,
                .column = src_loc.column,
                .file_path = src_loc.file_path,
                .module_name = query_result.module_name,
                .function_name = query_result.function_name,
            },
        });
    }

    var test_data_file = try std.fs.cwd().createFile(test_data_path, .{});
    defer test_data_file.close();
    var test_data_writer = test_data_file.writer(&.{});

    const data: common.Data = .{
        .zig_version = builtin.zig_version_string,
        .tests = tests.items,
    };
    try std.zon.stringify.serialize(data, .{}, &test_data_writer.interface);
    try test_data_writer.interface.writeByte('\n');
    try test_data_writer.interface.flush();
}
