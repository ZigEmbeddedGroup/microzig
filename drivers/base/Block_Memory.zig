const std = @import("std");

const logger = std.log.scoped(.flash);

pub const BaseError = error{ Unsupported, InvalidSector };
pub const WriteError = BaseError || error{ SectorOverrun, WriteDisabled };
pub const ReadError = BaseError || error{ReadDisabled};

pub const VTable = struct {
    enable_write_fn: ?*const fn (*anyopaque) BaseError!void,
    disable_write_fn: ?*const fn (*anyopaque) BaseError!void,
    erase_fn: ?*const fn (*anyopaque, sector: u32) WriteError!void,
    write_fn: ?*const fn (*anyopaque, sector: u32, data: []u8) WriteError!void,
    read_fn: ?*const fn (*anyopaque, offset: u32, data: []u8) ReadError!usize,
    // find_sector_fn: ?*const fn (*anyopaque, offset: u32) BaseError!u32,
    sector_size_fn: ?*const fn (*anyopaque, sector: u32) BaseError!u32,
};

pub const Block_Memory = @This();
ptr: *anyopaque,
vtable: VTable,

pub fn enableWrite(flash: Block_Memory) BaseError!void {
    if (flash.vtable.enable_write_fn) |enable_write_fn| {
        return try enable_write_fn(flash.ptr);
    }
}
pub fn disableWrite(flash: Block_Memory) BaseError!void {
    if (flash.vtable.disable_write_fn) |disable_write_fn| {
        return try disable_write_fn(flash.ptr);
    }
}
pub fn eraseSector(flash: Block_Memory, sector: u32) WriteError!void {
    const erase_fn = flash.vtable.erase_fn orelse return error.Unsupported;
    return erase_fn(flash.ptr, sector);
}
pub fn write(flash: Block_Memory, sector: u32, data: []u8) WriteError!void {
    const sector_size = try flash.sectorSize(sector);
    if (data.len > sector_size) return error.SectorOverrun;
    try flash.eraseSector(sector);
    const write_fn = flash.vtable.write_fn orelse return error.Unsupported;
    return write_fn(flash.ptr, sector, data);
}
pub fn read(flash: Block_Memory, offset: u32, data: []u8) ReadError!usize {
    const read_fn = flash.vtable.read_fn orelse return error.Unsupported;
    return read_fn(flash.ptr, offset, data);
}
// pub fn findSector(flash: Block_Memory, offset: u32) BaseError!u8 {

// }
pub fn sectorSize(flash: Block_Memory, sector: u32) BaseError!u32 {
    const sector_size_fn = flash.vtable.sector_size_fn orelse return error.Unsupported;
    return sector_size_fn(flash.ptr, sector);
}

pub const TestDevice = struct {
    arena: std.heap.ArenaAllocator,
    write_enabled: bool = false,
    read_enabled: bool = false,
    sector_size: u32 = 16384,
    num_sectors: u8 = 4,

    pub fn block_memory(td: *TestDevice) Block_Memory {
        return Block_Memory{ .vtable = vtable, .ptr = td };
    }
    pub fn enableWrite(ctx: *anyopaque) BaseError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        std.debug.print("Enable flash Write\n", .{});
        td.read_enabled = true;
        td.write_enabled = true;
    }
    pub fn disableWrite(ctx: *anyopaque) BaseError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        std.debug.print("Disable flash Write\n", .{});
        td.read_enabled = false;
        td.write_enabled = false;
    }
    pub fn erase(ctx: *anyopaque, sector: u32) WriteError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (td.write_enabled) {
            std.debug.print("Erasing sector: {}\n", .{sector});
        } else {
            return error.WriteDisabled;
        }
    }

    pub fn write(ctx: *anyopaque, sector: u32, data: []u8) WriteError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (td.write_enabled) {
            std.debug.print("Writing offset: {}, data length: {}\n", .{ sector, data.len });
        } else {
            return error.WriteDisabled;
        }
    }
    pub fn read(ctx: *anyopaque, offset: u32, data: []u8) ReadError!usize {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (td.write_enabled) {
            std.debug.print("Reading offset: {}\n", .{offset});
            const length = data.len;
            for (0..length) |i| {
                data[i] = @intCast(i % 256);
            }
            return length;
        } else {
            return error.ReadDisabled;
        }
    }
    pub fn sectorSize(ctx: *anyopaque, sector: u32) BaseError!u32 {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (sector < td.num_sectors) {
            return td.sector_size;
        } else {
            return error.InvalidSector;
        }
    }
    const vtable = VTable{
        .enable_write_fn = TestDevice.enableWrite,
        .disable_write_fn = TestDevice.disableWrite,
        .erase_fn = TestDevice.erase,
        .write_fn = TestDevice.write,
        .read_fn = TestDevice.read,
        .sector_size_fn = TestDevice.sectorSize,
    };
};

test TestDevice {
    const allocator = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer allocator.deinit();
    var td: TestDevice = .{
        .arena = allocator,
    };

    td.sector_size = 10;

    const fd = td.block_memory();
    var buffer: [3]u8 = .{ 42, 43, 44 };
    try std.testing.expectError(error.WriteDisabled, fd.write(0, buffer[0..]));
    try std.testing.expectError(error.ReadDisabled, fd.read(0, buffer[0..]));

    try fd.enableWrite();

    try fd.write(0, buffer[0..]);
    try std.testing.expectEqual(buffer.len, fd.read(0x123, buffer[0..]));
    var big_buf: [11]u8 = undefined;
    @memset(big_buf[0..], 123);
    try std.testing.expectError(error.SectorOverrun, fd.write(0, big_buf[0..]));
}
