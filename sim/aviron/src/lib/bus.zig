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

// Unified byte-addressable bus interface used by MemoryMapping for RAM and IO
pub const Bus = struct {
    pub const Address = u24;

    ctx: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        read: *const fn (ctx: *anyopaque, addr: Address) u8,
        write: *const fn (ctx: *anyopaque, addr: Address, v: u8) void,
        write_masked: *const fn (ctx: *anyopaque, addr: Address, mask: u8, v: u8) void,
        check_exit: ?*const fn (ctx: *anyopaque) ?u8 = null,
    };

    pub fn read(self: *const Bus, addr: Address) u8 {
        return self.vtable.read(self.ctx, addr);
    }

    pub fn write(self: *const Bus, addr: Address, v: u8) void {
        self.vtable.write(self.ctx, addr, v);
    }

    pub fn write_masked(self: *const Bus, addr: Address, mask: u8, v: u8) void {
        self.vtable.write_masked(self.ctx, addr, mask, v);
    }

    pub fn check_exit(self: *const Bus) ?u8 {
        if (self.vtable.check_exit) |f| return f(self.ctx) else return null;
    }
};

/// Fixed-size memory device with byte-addressable read/write operations
pub fn FixedSizedMemory(comptime size: comptime_int) type {
    return struct {
        const Self = @This();

        data: [size]u8 align(2) = .{0} ** size,

        pub fn bus(self: *Self) Bus {
            return .{ .ctx = self, .vtable = &bus_vtable };
        }

        pub const bus_vtable = Bus.VTable{
            .read = dev_read,
            .write = dev_write,
            .write_masked = dev_write_masked,
            .check_exit = null,
        };

        fn dev_read(ctx: *anyopaque, addr: Bus.Address) u8 {
            const mem: *Self = @ptrCast(@alignCast(ctx));
            std.debug.assert(addr < size);
            return mem.data[addr];
        }

        fn dev_write(ctx: *anyopaque, addr: Bus.Address, value: u8) void {
            const mem: *Self = @ptrCast(@alignCast(ctx));
            std.debug.assert(addr < size);
            mem.data[addr] = value;
        }

        fn dev_write_masked(ctx: *anyopaque, addr: Bus.Address, mask: u8, value: u8) void {
            const mem: *Self = @ptrCast(@alignCast(ctx));
            std.debug.assert(addr < size);
            const old = mem.data[addr];
            mem.data[addr] = (old & ~mask) | (value & mask);
        }
    };
}

/// A mapping entry within a MemoryMapping.
pub const Segment = struct {
    /// Base address within the enclosing memory space.
    at: Bus.Address,
    /// Size in bytes of the mapped range.
    size: Bus.Address,
    /// Backend handling the mapped range starting at index 0.
    backend: Bus,
};

/// A logical memory space composed of non-overlapping segments.
pub const MemoryMapping = struct {
    const Self = @This();

    segments: []const Segment, // sorted by .at, owned by this struct

    pub const InitError = error{OverlappingSegments} || std.mem.Allocator.Error;
    pub const AccessError = error{ Unmapped, ReadOnly, OutOfRange };

    pub fn init(alloc: std.mem.Allocator, segs: []const Segment) InitError!Self {
        // Copy segments to owned memory
        const owned = try alloc.alloc(Segment, segs.len);
        @memcpy(owned, segs);

        // Sort by base address
        std.sort.block(Segment, owned, {}, struct {
            fn lessThan(_: void, a: Segment, b: Segment) bool {
                return a.at < b.at;
            }
        }.lessThan);

        // Validate non-overlap
        if (owned.len > 1) {
            var i: usize = 0;
            while (i + 1 < owned.len) : (i += 1) {
                const cur_end = owned[i].at + owned[i].size;
                if (cur_end > owned[i + 1].at) {
                    alloc.free(owned);
                    return error.OverlappingSegments;
                }
            }
        }

        return .{ .segments = owned };
    }

    pub fn deinit(self: *const Self, alloc: std.mem.Allocator) void {
        alloc.free(self.segments);
    }

    pub fn read(self: *const Self, addr: Bus.Address) AccessError!u8 {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        return seg.backend.read(idx);
    }

    pub fn write(self: *const Self, addr: Bus.Address, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        seg.backend.write(idx, v);
        return;
    }

    pub fn write_masked(self: *const Self, addr: Bus.Address, mask: u8, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        seg.backend.write_masked(idx, mask, v);
        return;
    }

    fn find(self: *const Self, addr: Bus.Address) ?*const Segment {
        // Linear scan is fine initially; segments are sorted.
        for (self.segments) |*s| {
            if (addr >= s.at and addr < s.at + s.size) return s;
        }
        return null;
    }

    /// Returns a Bus interface for this MemoryMapping.
    /// The returned Bus uses absolute addressing within this space (not segment-relative).
    pub fn bus(self: *Self) Bus {
        return .{
            .ctx = @as(*anyopaque, @ptrCast(self)),
            .vtable = &bus_vtable,
        };
    }

    const bus_vtable = Bus.VTable{
        .read = bus_read,
        .write = bus_write,
        .write_masked = bus_write_masked,
        .check_exit = bus_check_exit,
    };

    fn bus_read(ctx: *anyopaque, addr: Bus.Address) u8 {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        return self.read(addr) catch |e| switch (e) {
            error.Unmapped => @panic("Read from unmapped memory address"),
            error.OutOfRange => @panic("Read out of range"),
            error.ReadOnly => @panic("ReadOnly error on read"),
        };
    }

    fn bus_write(ctx: *anyopaque, addr: Bus.Address, v: u8) void {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        self.write(addr, v) catch |e| switch (e) {
            error.Unmapped => @panic("Write to unmapped memory address"),
            error.OutOfRange => @panic("Write out of range"),
            error.ReadOnly => @panic("Write to read-only memory"),
        };
    }

    fn bus_write_masked(ctx: *anyopaque, addr: Bus.Address, mask: u8, v: u8) void {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        self.write_masked(addr, mask, v) catch |e| switch (e) {
            error.Unmapped => @panic("Masked write to unmapped memory address"),
            error.OutOfRange => @panic("Masked write out of range"),
            error.ReadOnly => @panic("Masked write to read-only memory"),
        };
    }

    fn bus_check_exit(ctx: *anyopaque) ?u8 {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        // Check all segments for exit condition
        for (self.segments) |*seg| {
            if (seg.backend.check_exit()) |code| {
                return code;
            }
        }
        return null;
    }
};

test "MemoryMapping: detects overlapping segments" {
    const testing = std.testing;

    var ram1_storage = FixedSizedMemory(16){};
    var ram2_storage = FixedSizedMemory(16){};
    const ram1 = ram1_storage.bus();
    const ram2 = ram2_storage.bus();

    const segs = [_]Segment{
        .{ .at = 0x10, .size = 12, .backend = ram1 },
        .{ .at = 0x18, .size = 12, .backend = ram2 }, // overlaps 0x1A..0x1B
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    try testing.expectError(error.OverlappingSegments, MemoryMapping.init(alloc, &segs));
}

test "MemoryMapping: basic read/write across segments" {
    const testing = std.testing;

    var io_storage = FixedSizedMemory(32){}; // stand-in for IO range (no side effects)
    var sram_storage = FixedSizedMemory(64){};
    const io_dev = io_storage.bus();
    const sram_dev = sram_storage.bus();

    const segs = [_]Segment{
        .{ .at = 0x0000, .size = 0x20, .backend = io_dev },
        .{ .at = 0x0020, .size = 0x40, .backend = sram_dev },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try MemoryMapping.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Write to IO region and SRAM region via MemoryMapping
    try ms.write(0x0005, 0xAA);
    try ms.write(0x0025, 0xCC);

    try testing.expectEqual(@as(u8, 0xAA), io_dev.read(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), sram_dev.read(0x0005)); // 0x25 - 0x20 = 0x5

    // Read back via MemoryMapping
    try testing.expectEqual(@as(u8, 0xAA), try ms.read(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), try ms.read(0x0025));
}
