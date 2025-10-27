const std = @import("std");
const isa = @import("decoder.zig");

pub const Flash = struct {
    pub const Address = u24;
    pub const Error = error{InvalidAddress};

    ctx: ?*anyopaque,
    vtable: *const VTable,

    /// Size of the flash memory in bytes (word count). Is always 2-aligned.
    size: Address,

    pub fn read(mem: Flash, addr: Address) Error!u16 {
        if (addr >= mem.size) return error.InvalidAddress;
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: Address) Error!u16,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = empty_read },
    };

    fn empty_read(ctx: ?*anyopaque, addr: Address) Error!u16 {
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

            fn mem_read(ctx: ?*anyopaque, addr: Address) Error!u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                if (addr >= @as(Address, @intCast(@divExact(size, 2)))) return error.InvalidAddress;
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
        mem.write_masked(addr, 0xFF, value);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn write_masked(mem: IO, addr: Address, mask: u8, value: u8) void {
        mem.vtable.writeFn(mem.ctx, addr, mask, value);
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

pub const BusConfig = struct {
    address_type: type,
};

/// IO Bus interface with masked writes as the primary write method
pub fn IOBusInterface(comptime address_type: type) type {
    return struct {
        const Self = @This();
        pub const Address = address_type;

        ctx: *anyopaque,
        vtable: *const VTable,

        pub const VTable = struct {
            read: *const fn (ctx: *anyopaque, addr: Address) u8,
            write: *const fn (ctx: *anyopaque, addr: Address, mask: u8, v: u8) void,
            check_exit: ?*const fn (ctx: *anyopaque) ?u8 = null,
        };

        pub fn read(self: *const Self, addr: Address) u8 {
            return self.vtable.read(self.ctx, addr);
        }

        /// Write with mask - this is the primary write interface for IO
        /// `mask` determines which bits of `value` are written.
        pub fn write(self: *const Self, addr: Address, mask: u8, v: u8) void {
            self.vtable.write(self.ctx, addr, mask, v);
        }

        pub fn check_exit(self: *const Self) ?u8 {
            if (self.vtable.check_exit) |f| return f(self.ctx) else return null;
        }
    };
}

/// Standard data bus using 24-bit addressing (for AVR data space)
pub const DataBus = Bus(.{ .address_type = u24 });

/// Standard IO bus using 12-bit addressing (for AVR IO space)
pub const IOBus = IOBusInterface(IO.Address);

/// Unified byte-addressable bus interface used by MemoryMapping for RAM and IO
pub fn Bus(comptime config: BusConfig) type {
    return struct {
        const Self = @This();
        pub const Address = config.address_type;
        pub const Error = error{InvalidAddress};

        ctx: *anyopaque,
        vtable: *const VTable,

        pub const VTable = struct {
            read: *const fn (ctx: *anyopaque, addr: Address) Error!u8,
            write: *const fn (ctx: *anyopaque, addr: Address, v: u8) Error!void,
            check_exit: ?*const fn (ctx: *anyopaque) ?u8 = null,
        };

        pub fn read(self: *const Self, addr: Address) !u8 {
            return self.vtable.read(self.ctx, addr);
        }

        pub fn write(self: *const Self, addr: Address, v: u8) !void {
            try self.vtable.write(self.ctx, addr, v);
        }

        pub fn check_exit(self: *const Self) ?u8 {
            if (self.vtable.check_exit) |f| return f(self.ctx) else return null;
        }
    };
}

/// Fixed-size memory device with byte-addressable read/write operations
/// Takes an optional bus_config parameter. If not provided, uses the smallest address width needed.
pub fn FixedSizeMemory(comptime size: comptime_int, comptime bus_config: ?BusConfig) type {
    const default_addr_type = if (size <= 256) u8 else if (size <= 65536) u16 else u24;
    const config = bus_config orelse BusConfig{ .address_type = default_addr_type };

    return struct {
        const Self = @This();
        pub const BusType = Bus(config);
        const AddressType = BusType.Address;

        data: [size]u8 align(2) = .{0} ** size,

        pub fn bus(self: *Self) BusType {
            return .{ .ctx = self, .vtable = &bus_vtable };
        }

        pub const bus_vtable = BusType.VTable{
            .read = read,
            .write = write,
            .check_exit = null,
        };

        fn read(ctx: *anyopaque, addr: AddressType) BusType.Error!u8 {
            const mem: *Self = @ptrCast(@alignCast(ctx));
            if (addr >= size) return error.InvalidAddress;
            return mem.data[addr];
        }

        fn write(ctx: *anyopaque, addr: AddressType, value: u8) BusType.Error!void {
            const mem: *Self = @ptrCast(@alignCast(ctx));
            if (addr >= size) return error.InvalidAddress;
            mem.data[addr] = value;
        }
    };
}

/// A logical memory space composed of non-overlapping segments.
pub fn MemoryMapping(comptime BusType: type) type {
    return struct {
        const Self = @This();

        /// A mapping entry within this MemoryMapping.
        pub const Segment = struct {
            /// Base address within the enclosing memory space.
            at: BusType.Address,
            /// Size in bytes of the mapped range.
            size: BusType.Address,
            /// Backend handling the mapped range starting at index 0.
            backend: BusType,
        };

        segments: []const Segment, // sorted by .at, owned by this struct

        pub const InitError = error{OverlappingSegments} || std.mem.Allocator.Error;
        pub const AccessError = error{InvalidAddress};

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

        pub fn read(self: *const Self, addr: BusType.Address) AccessError!u8 {
            const seg = self.find(addr) orelse return error.InvalidAddress;
            const idx = addr - seg.at;
            return seg.backend.read(idx) catch error.InvalidAddress;
        }

        pub fn write(self: *const Self, addr: BusType.Address, v: u8) AccessError!void {
            const seg = self.find(addr) orelse return error.InvalidAddress;
            const idx = addr - seg.at;
            return seg.backend.write(idx, v) catch error.InvalidAddress;
        }

        fn find(self: *const Self, addr: BusType.Address) ?*const Segment {
            // Linear scan is fine initially; segments are sorted.
            for (self.segments) |*s| {
                if (addr >= s.at and addr < s.at + s.size) return s;
            }
            return null;
        }

        /// Returns a Bus interface for this MemoryMapping.
        /// The returned Bus uses absolute addressing within this space (not segment-relative).
        pub fn bus(self: *Self) BusType {
            return .{
                .ctx = @as(*anyopaque, @ptrCast(self)),
                .vtable = &bus_vtable,
            };
        }

        const bus_vtable = BusType.VTable{
            .read = bus_read,
            .write = bus_write,
            .check_exit = bus_check_exit,
        };

        fn bus_read(ctx: *anyopaque, addr: BusType.Address) BusType.Error!u8 {
            const self: *const Self = @ptrCast(@alignCast(ctx));
            return self.read(addr);
        }

        fn bus_write(ctx: *anyopaque, addr: BusType.Address, v: u8) BusType.Error!void {
            const self: *const Self = @ptrCast(@alignCast(ctx));
            try self.write(addr, v);
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
}

test "MemoryMapping: detects overlapping segments" {
    const testing = std.testing;

    var ram1_storage = FixedSizeMemory(16, null){};
    var ram2_storage = FixedSizeMemory(16, null){};
    const ram1 = ram1_storage.bus();
    const ram2 = ram2_storage.bus();

    const BusType = @TypeOf(ram1);
    const Mapping = MemoryMapping(BusType);

    const segs = [_]Mapping.Segment{
        .{ .at = 0x10, .size = 12, .backend = ram1 },
        .{ .at = 0x18, .size = 12, .backend = ram2 }, // overlaps 0x1A..0x1B
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    try testing.expectError(error.OverlappingSegments, Mapping.init(alloc, &segs));
}

test "MemoryMapping: basic read/write across segments" {
    const testing = std.testing;

    var io_storage = FixedSizeMemory(32, null){}; // stand-in for IO range (no side effects)
    var sram_storage = FixedSizeMemory(64, null){};
    const io_dev = io_storage.bus();
    const sram_dev = sram_storage.bus();

    const BusType = @TypeOf(io_dev);
    const Mapping = MemoryMapping(BusType);

    const segs = [_]Mapping.Segment{
        .{ .at = 0x0000, .size = 0x20, .backend = io_dev },
        .{ .at = 0x0020, .size = 0x40, .backend = sram_dev },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try Mapping.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Write to IO region and SRAM region via MemoryMapping
    try ms.write(0x0005, 0xAA);
    try ms.write(0x0025, 0xCC);

    try testing.expectEqual(@as(u8, 0xAA), try io_dev.read(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), try sram_dev.read(0x0005)); // 0x25 - 0x20 = 0x5

    // Read back via MemoryMapping
    try testing.expectEqual(@as(u8, 0xAA), try ms.read(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), try ms.read(0x0025));
}

test "MemoryMapping: unmapped read returns InvalidAddress" {
    const testing = std.testing;

    var sram_storage = FixedSizeMemory(64, null){};
    const sram_dev = sram_storage.bus();

    const BusType = @TypeOf(sram_dev);
    const Mapping = MemoryMapping(BusType);

    // Only map 0x0020-0x005F (64 bytes at 0x20)
    const segs = [_]Mapping.Segment{
        .{ .at = 0x0020, .size = 0x40, .backend = sram_dev },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try Mapping.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Try to read from unmapped address (before mapped region)
    try testing.expectError(error.InvalidAddress, ms.read(0x0010));

    // Try to read from unmapped address (after mapped region)
    try testing.expectError(error.InvalidAddress, ms.read(0x0070));
}

test "MemoryMapping: unmapped write returns InvalidAddress" {
    const testing = std.testing;

    var sram_storage = FixedSizeMemory(64, null){};
    const sram_dev = sram_storage.bus();

    const BusType = @TypeOf(sram_dev);
    const Mapping = MemoryMapping(BusType);

    // Only map 0x0020-0x005F (64 bytes at 0x20)
    const segs = [_]Mapping.Segment{
        .{ .at = 0x0020, .size = 0x40, .backend = sram_dev },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try Mapping.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Try to write to unmapped address (before mapped region)
    try testing.expectError(error.InvalidAddress, ms.write(0x0010, 0xFF));

    // Try to write to unmapped address (after mapped region)
    try testing.expectError(error.InvalidAddress, ms.write(0x0070, 0xFF));
}

test "Flash: out of bounds read returns InvalidAddress" {
    const testing = std.testing;

    var flash_storage = Flash.Static(128){};
    const flash = flash_storage.memory();

    // Flash has 128 bytes (64 words), so valid addresses are 0-63
    // Try to read beyond the flash size
    try testing.expectError(error.InvalidAddress, flash.read(64));
    try testing.expectError(error.InvalidAddress, flash.read(100));
}
