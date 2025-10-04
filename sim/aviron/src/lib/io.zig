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
};

pub const EEPROM = RAM; // actually the same interface *shrug*

/// Mapper handles translation of data-space addresses to the appropriate memory backend.
/// This allows different AVR MCUs to have different memory layouts (e.g., IO registers
/// mapped at different locations, extended IO space, etc.)
pub const Mapper = struct {
    pub const Address = u24;

    ctx: ?*anyopaque,
    vtable: *const VTable,

    pub fn read(mapper: Mapper, addr: Address) u8 {
        return mapper.vtable.readFn(mapper.ctx, addr);
    }

    pub fn write(mapper: Mapper, addr: Address, value: u8) void {
        mapper.vtable.writeFn(mapper.ctx, addr, value);
    }

    /// `mask` determines which bits of `value` are written.
    pub fn write_masked(mapper: Mapper, addr: Address, mask: u8, value: u8) void {
        mapper.vtable.writeMaskedFn(mapper.ctx, addr, mask, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: Address, value: u8) void,
        writeMaskedFn: *const fn (ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void,
    };

    pub const empty = Mapper{
        .ctx = null,
        .vtable = &VTable{
            .readFn = empty_read,
            .writeFn = empty_write,
            .writeMaskedFn = empty_write_masked,
        },
    };

    fn empty_read(ctx: ?*anyopaque, addr: Address) u8 {
        _ = ctx;
        _ = addr;
        return 0xFF;
    }

    fn empty_write(ctx: ?*anyopaque, addr: Address, value: u8) void {
        _ = ctx;
        _ = addr;
        _ = value;
    }

    fn empty_write_masked(ctx: ?*anyopaque, addr: Address, mask: u8, value: u8) void {
        _ = ctx;
        _ = addr;
        _ = mask;
        _ = value;
    }

    /// SimpleMapper is a range-based mapper that routes data-space addresses to IO or SRAM.
    /// The mapper translates data-space addresses to array indices for SRAM access.
    //
    /// NOTE: The mapper holds pointers to IO and SRAM, not copies. This allows the CPU to
    /// share the same memory instances - the CPU uses the mapper for all data-space access
    /// (loads, stores, stack operations, etc.), but keeps direct IO access for reading/writing
    /// special registers like SP and SREG.
    pub fn SimpleMapper(
        comptime io_translate_fn: *const fn (data_addr: u24) ?IO.Address,
        comptime sram_base: u24,
    ) type {
        return struct {
            const Self = @This();

            io: *IO,
            sram: *RAM,

            pub fn mapper(self: *Self) Mapper {
                return Mapper{
                    .ctx = self,
                    .vtable = &vtable,
                };
            }

            const vtable = Mapper.VTable{
                .readFn = mapperRead,
                .writeFn = mapperWrite,
                .writeMaskedFn = mapperWriteMasked,
            };

            fn mapperRead(ctx: ?*anyopaque, addr: Mapper.Address) u8 {
                const self: *Self = @ptrCast(@alignCast(ctx.?));

                // Check if address is in IO range
                if (io_translate_fn(addr)) |io_addr| {
                    return self.io.read(io_addr);
                }

                // Check if address is in SRAM range
                if (addr < sram_base) {
                    std.debug.print("Mapper read from unmapped address: 0x{X:0>6} (below SRAM base 0x{X:0>6})\n", .{ addr, sram_base });
                    @panic("Read from unmapped memory address");
                }

                // Translate to SRAM array index
                const sram_index = addr - sram_base;
                return self.sram.read(sram_index);
            }

            fn mapperWrite(ctx: ?*anyopaque, addr: Mapper.Address, value: u8) void {
                const self: *Self = @ptrCast(@alignCast(ctx.?));

                // Check if address is in IO range
                if (io_translate_fn(addr)) |io_addr| {
                    self.io.write(io_addr, value);
                    return;
                }

                // Check if address is in SRAM range
                if (addr < sram_base) {
                    std.debug.print("Mapper write to unmapped address: 0x{X:0>6} (below SRAM base 0x{X:0>6})\n", .{ addr, sram_base });
                    @panic("Write to unmapped memory address");
                }

                // Translate to SRAM array index
                const sram_index = addr - sram_base;
                self.sram.write(sram_index, value);
            }

            fn mapperWriteMasked(ctx: ?*anyopaque, addr: Mapper.Address, mask: u8, value: u8) void {
                const self: *Self = @ptrCast(@alignCast(ctx.?));

                // Check if address is in IO range
                if (io_translate_fn(addr)) |io_addr| {
                    self.io.write_masked(io_addr, mask, value);
                    return;
                }

                // Check if address is in SRAM range
                if (addr < sram_base) {
                    std.debug.print("Mapper write_masked to unmapped address: 0x{X:0>6} (below SRAM base 0x{X:0>6})\n", .{ addr, sram_base });
                    @panic("Write to unmapped memory address");
                }

                // Translate to SRAM array index - perform read-modify-write
                const sram_index = addr - sram_base;
                const old_value = self.sram.read(sram_index);
                const new_value = (old_value & ~mask) | (value & mask);
                self.sram.write(sram_index, new_value);
            }
        };
    }
};

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
