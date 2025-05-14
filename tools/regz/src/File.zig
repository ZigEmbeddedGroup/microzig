ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    write_all: *const fn (*anyopaque, filename: []const u8) WriteAllError!File,
};

pub const WriteAllError = error{
    TODO,
};

pub inline fn write_all(f: File, bytes: []const u8) WriteAllError!File {
    return f.vtable.write_all(f.ptr, bytes);
}

const Directory = @This();
const File = @import("File.zig");
