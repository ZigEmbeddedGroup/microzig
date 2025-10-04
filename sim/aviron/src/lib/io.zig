const std = @import("std");
const isa = @import("decoder.zig");

pub const Flash = struct {
    pub const Address = u24;

    ctx: ?*anyopaque,
    vtable: *const VTable,

    /// Size of the flash memory in bytes. Is always 2-aligned.
    size: usize,

    pub fn read(mem: Flash, addr: Address) u16 {
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u16,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = empty_read },
    };

    fn empty_read(ctx: ?*anyopaque, addr: Address) u16 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    pub fn Static(comptime size: comptime_int) type {
        if ((size & 1) != 0)
            @compileError("size must be a multiple of two!");
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) Flash {
                return Flash{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{ .readFn = mem_read };

            fn mem_read(ctx: ?*anyopaque, addr: Address) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(addr < @as(Address, @intCast(@divExact(size, 2))));
                return std.mem.bytesAsSlice(u16, &mem.data)[addr];
            }
        };
    }

    /// Dynamically sized flash storage backed by a heap slice.
    pub fn Dynamic() type {
        return struct {
            const Self = @This();

            allocator: std.mem.Allocator,
            data_words: []u16,
            data: []align(2) u8,

            pub fn init(allocator: std.mem.Allocator, size_bytes: usize) !Self {
                if ((size_bytes & 1) != 0) return error.InvalidFlashSize;
                const words = try allocator.alloc(u16, @divExact(size_bytes, 2));
                @memset(words, 0);
                const bytes: []align(2) u8 = std.mem.sliceAsBytes(words);
                return .{ .allocator = allocator, .data_words = words, .data = bytes };
            }

            pub fn deinit(self: *Self) void {
                self.allocator.free(self.data_words);
            }

            pub fn memory(self: *Self) Flash {
                return Flash{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = self.data_words.len,
                };
            }

            pub const vtable = VTable{ .readFn = mem_read };

            fn mem_read(ctx: ?*anyopaque, addr: Address) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(addr < @as(Address, @intCast(mem.data_words.len)));
                return mem.data_words[addr];
            }
        };
    }
};

pub const RAM = struct {
    pub const Address = u24;

    ctx: ?*anyopaque,
    vtable: *const VTable,

    /// Size of the RAM memory space in bytes.
    size: usize,

    pub fn read(mem: RAM, index: Address) u8 {
        // Index is a 0-based array index, not a data-space address.
        return mem.vtable.readFn(mem.ctx, index);
    }

    pub fn write(mem: RAM, index: Address, value: u8) void {
        // Index is a 0-based array index, not a data-space address.
        return mem.vtable.writeFn(mem.ctx, index, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, index: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, index: Address, value: u8) void,
    };

    pub const empty = RAM{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = empty_read, .writeFn = empty_write },
    };

    fn empty_read(ctx: ?*anyopaque, index: Address) u8 {
        _ = index;
        _ = ctx;
        return 0;
    }

    fn empty_write(ctx: ?*anyopaque, index: Address, value: u8) void {
        _ = value;
        _ = index;
        _ = ctx;
    }

    pub fn Static(comptime size: comptime_int) type {
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) RAM {
                return RAM{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = size,
                };
            }

            pub const vtable = VTable{
                .readFn = mem_read,
                .writeFn = mem_write,
            };

            fn mem_read(ctx: ?*anyopaque, index: Address) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(index < size);
                return mem.data[index];
            }

            fn mem_write(ctx: ?*anyopaque, index: Address, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(index < size);
                mem.data[index] = value;
            }
        };
    }

    /// Dynamically sized RAM storage backed by a heap slice.
    pub fn Dynamic() type {
        return struct {
            const Self = @This();

            allocator: std.mem.Allocator,
            data: []u8,

            pub fn init(allocator: std.mem.Allocator, size_bytes: usize) !Self {
                const buf = try allocator.alloc(u8, size_bytes);
                @memset(buf, 0);
                return .{ .allocator = allocator, .data = buf };
            }

            pub fn deinit(self: *Self) void {
                self.allocator.free(self.data);
            }

            pub fn memory(self: *Self) RAM {
                return RAM{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = self.data.len,
                };
            }

            pub const vtable = VTable{
                .readFn = mem_read,
                .writeFn = mem_write,
            };

            fn mem_read(ctx: ?*anyopaque, index: Address) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(index < mem.data.len);
                return mem.data[index];
            }

            fn mem_write(ctx: ?*anyopaque, index: Address, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(index < mem.data.len);
                mem.data[index] = value;
            }
        };
    }
};

pub const EEPROM = RAM; // actually the same interface *shrug*

pub const IO = struct {
    // Some AVR families (e.g., XMEGA) expose extended I/O up to 0xFFF (12 bits).
    pub const Address = u12;

    ctx: ?*anyopaque,

    /// Size of the EEPROM in bytes.
    vtable: *const VTable,

    pub fn read(mem: IO, addr: Address) u8 {
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: IO, addr: Address, value: u8) void {
        return mem.write_masked(addr, 0xFF, value);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn write_masked(mem: IO, addr: Address, mask: u8, value: u8) void {
        return mem.vtable.writeFn(mem.ctx, addr, mask, value);
    }

    pub fn check_exit(mem: IO) ?u8 {
        return mem.vtable.checkExitFn(mem.ctx);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void,
        checkExitFn: *const fn (ctx: ?*anyopaque) ?u8,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{
            .readFn = empty_read,
            .writeFn = empty_write,
            .checkExitFn = empty_check_exit,
        },
    };

    fn empty_read(ctx: ?*anyopaque, addr: Address) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn empty_write(ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void {
        _ = mask;
        _ = value;
        _ = addr;
        _ = ctx;
    }

    fn empty_check_exit(ctx: ?*anyopaque) ?u8 {
        _ = ctx;
        return null;
    }

    // no translate in new design
};
