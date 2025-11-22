const std = @import("std");
const printer = @import("printer");

pub const Test = struct {
    address: u64,
    expected: struct {
        line: u32,
        column: u32,
        file_path: []const u8,
        function_name: ?[]const u8,
        module_name: ?[]const u8,
    },
};

pub const Data = struct {
    zig_version: []const u8,
    tests: []const Test,
};
