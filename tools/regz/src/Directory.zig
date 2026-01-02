ptr: *anyopaque,
vtable: *const VTable,

const Directory = @This();
pub const VTable = struct {
    create_file: *const fn (*anyopaque, path: []const u8, content: []const u8) CreateFileError!void,
};

pub const CreateFileError = error{
    System,
    OutOfMemory,
};

pub inline fn create_file(d: Directory, filename: []const u8, content: []const u8) CreateFileError!void {
    return d.vtable.create_file(d.ptr, filename, content);
}
