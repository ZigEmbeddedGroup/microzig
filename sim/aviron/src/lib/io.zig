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

    pub fn getBase(mem: Flash) Address {
        return mem.vtable.getBaseFn(mem.ctx);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u16,
        getBaseFn: *const fn (ctx: ?*anyopaque) Address,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = empty_read, .getBaseFn = empty_get_base },
    };

    fn empty_read(ctx: ?*anyopaque, addr: Address) u16 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn empty_get_base(ctx: ?*anyopaque) Address {
        _ = ctx;
        return 0;
    }

    pub fn Static(comptime size: comptime_int) type {
        if ((size & 1) != 0)
            @compileError("size must be a multiple of two!");
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,
            /// Base address (in words) where this flash is mapped.
            base: Address = 0,

            pub fn memory(self: *Self) Flash {
                return Flash{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{ .readFn = mem_read, .getBaseFn = get_base };

            fn mem_read(ctx: ?*anyopaque, addr: Address) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(addr >= mem.base);
                const off: Address = addr - mem.base;
                std.debug.assert(off < @as(Address, @intCast(@divExact(size, 2))));
                return std.mem.bytesAsSlice(u16, &mem.data)[off];
            }

            fn get_base(ctx: ?*anyopaque) Address {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return mem.base;
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
        // Logical RAM addresses include SRAM base; backend maps to array indices.
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: RAM, addr: Address, value: u8) void {
        // Logical RAM addresses include SRAM base; backend maps to array indices.
        return mem.vtable.writeFn(mem.ctx, addr, value);
    }

    pub fn getBase(mem: RAM) Address {
        return mem.vtable.getBaseFn(mem.ctx);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, value: u8) void,
        getBaseFn: *const fn (ctx: ?*anyopaque) Address,
    };

    pub const empty = RAM{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = empty_read, .writeFn = empty_write, .getBaseFn = empty_get_base },
    };

    fn empty_read(ctx: ?*anyopaque, addr: u16) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn empty_write(ctx: ?*anyopaque, addr: u16, value: u8) void {
        _ = value;
        _ = addr;
        _ = ctx;
    }

    fn empty_get_base(ctx: ?*anyopaque) Address {
        _ = ctx;
        return 0;
    }

    pub fn Static(comptime size: comptime_int) type {
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,
            /// Base address where this RAM is mapped.
            base: Address = 0,

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
                .getBaseFn = get_base,
            };

            fn mem_read(ctx: ?*anyopaque, addr: Address) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(addr >= mem.base);
                const off: Address = addr - mem.base;
                std.debug.assert(off < size);
                return mem.data[off];
            }

            fn mem_write(ctx: ?*anyopaque, addr: Address, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                std.debug.assert(addr >= mem.base);
                const off: Address = addr - mem.base;
                std.debug.assert(off < size);
                mem.data[off] = value;
            }

            fn get_base(ctx: ?*anyopaque) Address {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return mem.base;
            }
        };
    }
};

pub const EEPROM = RAM; // actually the same interface *shrug*

pub const IO = struct {
    pub const Address = u8;

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

    /// Translate an absolute data-space address to an I/O port address if mapped.
    /// Returns null when the address is not mapped to I/O and should be served by SRAM.
    pub fn translate_address(mem: IO, data_addr: u24) ?Address {
        return mem.vtable.translateAddressFn(mem.ctx, data_addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void,
        checkExitFn: *const fn (ctx: ?*anyopaque) ?u8,
        translateAddressFn: *const fn (ctx: ?*anyopaque, data_addr: u24) ?Address,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{
            .readFn = empty_read,
            .writeFn = empty_write,
            .checkExitFn = empty_check_exit,
            .translateAddressFn = empty_translate,
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

    fn empty_translate(ctx: ?*anyopaque, data_addr: u24) ?Address {
        _ = ctx;
        _ = data_addr;
        return null;
    }
};
