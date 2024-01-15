const std = @import("std");
const isa = @import("decoder.zig");

pub const Flash = struct {
    pub const Address = u24;

    ctx: ?*anyopaque,
    vtable: *const VTable,

    /// Size of the flash memory in bytes. Is always 2-aligned.
    size: usize,

    pub fn read(mem: Flash, addr: Address) u16 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u16,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: Address) u16 {
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

            pub const vtable = VTable{ .readFn = memRead };

            fn memRead(ctx: ?*anyopaque, addr: Address) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return std.mem.bytesAsSlice(u16, &mem.data)[addr];
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

    pub fn read(mem: RAM, addr: Address) u8 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: RAM, addr: Address, value: u8) void {
        std.debug.assert(addr < mem.size);
        return mem.vtable.writeFn(mem.ctx, addr, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, value: u8) void,
    };

    pub const empty = RAM{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u16) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u16, value: u8) void {
        _ = value;
        _ = addr;
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
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{
                .readFn = memRead,
                .writeFn = memWrite,
            };

            fn memRead(ctx: ?*anyopaque, addr: Address) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return mem.data[addr];
            }

            fn memWrite(ctx: ?*anyopaque, addr: Address, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                mem.data[addr] = value;
            }
        };
    }
};

pub const EEPROM = RAM; // actually the same interface *shrug*

pub const IO = struct {
    pub const Address = u6;

    ctx: ?*anyopaque,

    /// Size of the EEPROM in bytes.
    vtable: *const VTable,

    pub fn read(mem: IO, addr: Address) u8 {
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: IO, addr: Address, value: u8) void {
        return mem.writeMasked(addr, 0xFF, value);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn writeMasked(mem: IO, addr: Address, mask: u8, value: u8) void {
        return mem.vtable.writeFn(mem.ctx, addr, mask, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: Address) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void {
        _ = mask;
        _ = value;
        _ = addr;
        _ = ctx;
    }
};
