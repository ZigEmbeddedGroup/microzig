const builtin = @import("builtin");
const printer = @import("printer");

pub const Test = struct {
    address: u64,
    query_result: printer.DebugInfo.QueryResult,
};

pub const Data = struct {
    elf_path: []const u8,
    tests: []const Test,
};
