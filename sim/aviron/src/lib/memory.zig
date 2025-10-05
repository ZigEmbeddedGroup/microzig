const std = @import("std");
const io = @import("io.zig");

/// Unified byte-addressable backend interface for RAM and IO.
/// - RAM: read/write bytes by index
/// - IO: read/write bytes with side effects; never exposes slices
pub const Backend = struct {
    ctx: *anyopaque,
    vtable: *const VTable,

    pub const VTable = struct {
        read8: *const fn (ctx: *anyopaque, idx: usize) ReadError!u8,
        write8: *const fn (ctx: *anyopaque, idx: usize, v: u8) WriteError!void,
        write_masked: ?*const fn (ctx: *anyopaque, idx: usize, mask: u8, v: u8) WriteError!void = null,

        // Optional contiguous views (not used initially). All adapters return null for safety.
        slice_ro: *const fn (ctx: *anyopaque) ?[]const u8,
        slice_rw: *const fn (ctx: *anyopaque) ?[]u8,
    };

    pub const ReadError = error{OutOfRange};
    pub const WriteError = error{ OutOfRange, ReadOnly };

    pub fn read8(self: *const Backend, idx: usize) ReadError!u8 {
        return self.vtable.read8(self.ctx, idx);
    }

    pub fn write8(self: *const Backend, idx: usize, v: u8) WriteError!void {
        return self.vtable.write8(self.ctx, idx, v);
    }

    pub fn writeMasked(self: *const Backend, idx: usize, mask: u8, v: u8) WriteError!void {
        if (self.vtable.write_masked) |f| {
            return f(self.ctx, idx, mask, v);
        }
        // Default: emulate via read-modify-write
        const old = self.read8(idx) catch |e| switch (e) {
            error.OutOfRange => return error.OutOfRange,
        };
        const new_value: u8 = (old & ~mask) | (v & mask);
        return self.write8(idx, new_value);
    }

    pub fn sliceRO(self: *const Backend) ?[]const u8 {
        return self.vtable.slice_ro(self.ctx);
    }

    pub fn sliceRW(self: *const Backend) ?[]u8 {
        return self.vtable.slice_rw(self.ctx);
    }

    /// Adapter for RAM backends (read-write, byte-indexed)
    pub fn fromRAM(ram: *io.RAM) Backend {
        return .{ .ctx = ram, .vtable = &ram_vtable };
    }

    /// Adapter for IO backends (read-write with side effects). Index is treated as IO address.
    pub fn fromIO(io_mem: *io.IO) Backend {
        return .{ .ctx = io_mem, .vtable = &io_vtable };
    }
};

// ---- VTable singletons and adapter fns ----

fn ram_read8(ctx: *anyopaque, idx: usize) Backend.ReadError!u8 {
    const r: *io.RAM = @ptrCast(@alignCast(ctx));
    return r.read(@intCast(idx));
}

fn ram_write8(ctx: *anyopaque, idx: usize, v: u8) Backend.WriteError!void {
    const r: *io.RAM = @ptrCast(@alignCast(ctx));
    r.write(@intCast(idx), v);
}

fn ram_slice_ro(_: *anyopaque) ?[]const u8 {
    return null;
}
fn ram_slice_rw(_: *anyopaque) ?[]u8 {
    return null;
}

const ram_vtable = Backend.VTable{
    .read8 = &ram_read8,
    .write8 = &ram_write8,
    .write_masked = null,
    .slice_ro = &ram_slice_ro,
    .slice_rw = &ram_slice_rw,
};

fn io_read8(ctx: *anyopaque, idx: usize) Backend.ReadError!u8 {
    const m: *io.IO = @ptrCast(@alignCast(ctx));
    return m.read(@intCast(idx));
}

fn io_write8(ctx: *anyopaque, idx: usize, v: u8) Backend.WriteError!void {
    const m: *io.IO = @ptrCast(@alignCast(ctx));
    m.write(@intCast(idx), v);
}

fn io_write_masked(ctx: *anyopaque, idx: usize, mask: u8, v: u8) Backend.WriteError!void {
    const m: *io.IO = @ptrCast(@alignCast(ctx));
    m.write_masked(@intCast(idx), mask, v);
}

fn io_slice_ro(_: *anyopaque) ?[]const u8 {
    return null;
}
fn io_slice_rw(_: *anyopaque) ?[]u8 {
    return null;
}

const io_vtable = Backend.VTable{
    .read8 = &io_read8,
    .write8 = &io_write8,
    .write_masked = &io_write_masked,
    .slice_ro = &io_slice_ro,
    .slice_rw = &io_slice_rw,
};

/// A mapping entry within a MemorySpace.
pub const Segment = struct {
    /// Base address within the enclosing memory space.
    at: usize,
    /// Size in bytes of the mapped range.
    size: usize,
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

    pub fn read8(self: *const Self, addr: usize) AccessError!u8 {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        return seg.backend.read8(idx) catch |e| switch (e) {
            error.OutOfRange => return e,
        };
    }

    pub fn write8(self: *const Self, addr: usize, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        return seg.backend.write8(idx, v) catch |e| switch (e) {
            error.ReadOnly => return error.ReadOnly,
            error.OutOfRange => return error.OutOfRange,
        };
    }

    pub fn write_masked(self: *const Self, addr: usize, mask: u8, v: u8) AccessError!void {
        const seg = self.find(addr) orelse return error.Unmapped;
        const idx = addr - seg.at;
        if (idx >= seg.size) return error.OutOfRange;
        return seg.backend.writeMasked(idx, mask, v) catch |e| switch (e) {
            error.ReadOnly => return error.ReadOnly,
            error.OutOfRange => return error.OutOfRange,
        };
    }

    fn find(self: *const Self, addr: usize) ?*const Segment {
        // Linear scan is fine initially; segments are sorted.
        for (self.segments) |*s| {
            if (addr >= s.at and addr < s.at + s.size) return s;
        }
        return null;
    }
};

test "MemorySpace: detects overlapping segments" {
    const testing = std.testing;

    var ram1_storage = io.RAM.Static(16){};
    var ram2_storage = io.RAM.Static(16){};
    var ram1 = ram1_storage.memory();
    var ram2 = ram2_storage.memory();

    const segs = [_]Segment{
        .{ .at = 0x10, .size = 12, .backend = Backend.fromRAM(&ram1) },
        .{ .at = 0x18, .size = 12, .backend = Backend.fromRAM(&ram2) }, // overlaps 0x1A..0x1B
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
    var io_ram = io_storage.memory();
    var sram = sram_storage.memory();

    const segs = [_]Segment{
        .{ .at = 0x0000, .size = 0x20, .backend = Backend.fromRAM(&io_ram) },
        .{ .at = 0x0020, .size = 0x40, .backend = Backend.fromRAM(&sram) },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const ms = try MemorySpace.init(alloc, &segs);
    defer ms.deinit(alloc);

    // Write to IO region and SRAM region via MemorySpace
    try ms.write8(0x0005, 0xAA);
    try ms.write8(0x0025, 0xCC);

    try testing.expectEqual(@as(u8, 0xAA), io_ram.read(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), sram.read(0x0005)); // 0x25 - 0x20 = 0x5

    // Read back via MemorySpace
    try testing.expectEqual(@as(u8, 0xAA), try ms.read8(0x0005));
    try testing.expectEqual(@as(u8, 0xCC), try ms.read8(0x0025));
}
