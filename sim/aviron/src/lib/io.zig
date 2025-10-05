const std = @import("std");
const isa = @import("decoder.zig");

pub const Flash = struct {
    pub const Address = u24;

    ctx: ?*anyopaque,
    vtable: *const VTable,

    /// Size of the flash memory in bytes (word count). Is always 2-aligned.
    size: Address,

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
};

pub const RAM = struct {
    pub const Address = u24;

    pub fn Static(comptime size: comptime_int) type {
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn device(self: *Self) Device {
                return Device{ .ctx = self, .vtable = &dev_vtable };
            }

            pub const dev_vtable = Device.VTable{
                .read8 = dev_read8,
                .write8 = dev_write8,
                .write_masked = dev_write_masked,
                .check_exit = null,
            };

            fn dev_read8(ctx: *anyopaque, addr: Device.Address) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx));
                std.debug.assert(addr < size);
                return mem.data[addr];
            }

            fn dev_write8(ctx: *anyopaque, addr: Device.Address, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx));
                std.debug.assert(addr < size);
                mem.data[addr] = value;
            }

            fn dev_write_masked(ctx: *anyopaque, addr: Device.Address, mask: u8, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx));
                std.debug.assert(addr < size);
                const old = mem.data[addr];
                mem.data[addr] = (old & ~mask) | (value & mask);
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
};

// Unified byte-addressable device interface used by MemorySpace for RAM and IO
pub const Device = struct {
    pub const Address = u24;

    ctx: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        read8: *const fn (ctx: *anyopaque, addr: Address) u8,
        write8: *const fn (ctx: *anyopaque, addr: Address, v: u8) void,
        write_masked: *const fn (ctx: *anyopaque, addr: Address, mask: u8, v: u8) void,
        check_exit: ?*const fn (ctx: *anyopaque) ?u8 = null,
    };

    pub fn read8(self: *const Device, addr: Address) u8 {
        return self.vtable.read8(self.ctx, addr);
    }

    pub fn write8(self: *const Device, addr: Address, v: u8) void {
        self.vtable.write8(self.ctx, addr, v);
    }

    pub fn write_masked(self: *const Device, addr: Address, mask: u8, v: u8) void {
        self.vtable.write_masked(self.ctx, addr, mask, v);
    }

    pub fn check_exit(self: *const Device) ?u8 {
        if (self.vtable.check_exit) |f| return f(self.ctx) else return null;
    }
};
