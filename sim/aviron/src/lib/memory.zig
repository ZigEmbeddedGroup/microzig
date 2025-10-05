const std = @import("std");
const io = @import("io.zig");

/// Use the unified device interface
pub const Backend = io.Device;
const Device = io.Device;

/// A mapping entry within a MemorySpace.
pub const Segment = struct {
    /// Base address within the enclosing memory space.
    at: Device.Address,
    /// Size in bytes of the mapped range.
    size: Device.Address,
    /// Backend handling the mapped range starting at index 0.
    backend: Backend,
};

/// A logical memory space composed of non-overlapping segments.
pub const MemorySpace = struct {
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

    pub fn read8(self: *const Self, addr: Device.Address) AccessError!u8 {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        return seg.backend.read8(idx);
    }

    pub fn write8(self: *const Self, addr: Device.Address, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        seg.backend.write8(idx, v);
        return;
    }

    pub fn write_masked(self: *const Self, addr: Device.Address, mask: u8, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        seg.backend.write_masked(idx, mask, v);
        return;
    }

    fn find(self: *const Self, addr: Device.Address) ?*const Segment {
        // Linear scan is fine initially; segments are sorted.
        for (self.segments) |*s| {
            if (addr >= s.at and addr < s.at + s.size) return s;
        }
        return null;
    }

    /// Returns a Device interface for this MemorySpace.
    /// The returned Device uses absolute addressing within this space (not segment-relative).
    pub fn device(self: *Self) Device {
        return Device{
            .ctx = @as(*anyopaque, @ptrCast(self)),
            .vtable = &device_vtable,
        };
    }

    const device_vtable = Device.VTable{
        .read8 = device_read8,
        .write8 = device_write8,
        .write_masked = device_write_masked,
        .check_exit = device_check_exit,
    };

    fn device_read8(ctx: *anyopaque, addr: Device.Address) u8 {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        return self.read8(addr) catch |e| switch (e) {
            error.Unmapped => @panic("Read from unmapped memory address"),
            error.OutOfRange => @panic("Read out of range"),
            error.ReadOnly => @panic("ReadOnly error on read"),
        };
    }

    fn device_write8(ctx: *anyopaque, addr: Device.Address, v: u8) void {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        self.write8(addr, v) catch |e| switch (e) {
            error.Unmapped => @panic("Write to unmapped memory address"),
            error.OutOfRange => @panic("Write out of range"),
            error.ReadOnly => @panic("Write to read-only memory"),
        };
    }

    fn device_write_masked(ctx: *anyopaque, addr: Device.Address, mask: u8, v: u8) void {
        const self: *const Self = @ptrCast(@alignCast(ctx));
        self.write_masked(addr, mask, v) catch |e| switch (e) {
            error.Unmapped => @panic("Masked write to unmapped memory address"),
            error.OutOfRange => @panic("Masked write out of range"),
            error.ReadOnly => @panic("Masked write to read-only memory"),
        };
    }

    fn device_check_exit(ctx: *anyopaque) ?u8 {
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

test "MemorySpace: detects overlapping segments" {
    const testing = std.testing;

    var ram1_storage = io.RAM.Static(16){};
    var ram2_storage = io.RAM.Static(16){};
    const ram1 = ram1_storage.device();
    const ram2 = ram2_storage.device();

    const segs = [_]Segment{
        .{ .at = 0x10, .size = 12, .backend = ram1 },
        .{ .at = 0x18, .size = 12, .backend = ram2 }, // overlaps 0x1A..0x1B
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    try testing.expectError(error.OverlappingSegments, MemorySpace.init(alloc, &segs));
}

test "MemorySpace: basic read/write across segments" {
    const testing = std.testing;

    var io_storage = io.RAM.Static(32){}; // stand-in for IO range (no side effects)
    var sram_storage = io.RAM.Static(64){};
    const io_dev = io_storage.device();
    const sram_dev = sram_storage.device();

    const segs = [_]Segment{
        .{ .at = 0x0000, .size = 0x20, .backend = io_dev },
        .{ .at = 0x0020, .size = 0x40, .backend = sram_dev },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try MemorySpace.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Write to IO region and SRAM region via MemorySpace
    try ms.write8(0x0005, 0xAA);
    try ms.write8(0x0025, 0xCC);

    try testing.expectEqual(@as(u8, 0xAA), io_dev.read8(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), sram_dev.read8(0x0005)); // 0x25 - 0x20 = 0x5

    // Read back via MemorySpace
    try testing.expectEqual(@as(u8, 0xAA), try ms.read8(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), try ms.read8(0x0025));
}
