const std = @import("std");
const microzig = @import("microzig.zig");

const Alignment = std.mem.Alignment;

extern var microzig_heap_start: u8;
extern var microzig_heap_end: u8;

/// The number of free lists we maintain.
const free_list_count: usize = 6;

const Alloc = @This();

/// The lists of free chunks.
free_lists: [free_list_count]?*Chunk = @splat(null),

/// The beginning address of the memory region that can be allocated from.
low_boundary: usize,

/// The next address beyond the highest address of the memory region can allocated from.
high_boundary: usize,

/// An optional fallback allocator that is used when the allocator runs out of memory.
/// This allows allocation from multiple disjoint memory regions.
fallback: ?*Alloc = null,

/// A mutex used to protect access to the allocator.
mutex: microzig.interrupt.Mutex = .{},

/// Return a []u8 slice that contains the memory located between the
/// microzig_heap_start and microzig_heap_end.  This is the RAM that
/// is not used by any static allocations. It relies on the linker script
/// to define the microzig_heap_start and microzig_heap_end symbols
///
/// In the default configurations, the stack will occupy the end of this
/// memory area. The `reserve` parameter is used to reduce the size of the
/// returned slice to reserve some memory for the stack's exclusive use.
///
/// Parameters:
/// - `reserve`: The number of bytes to omit at the end of the heap.
///
pub fn heap(reserve: usize) []u8 {
    const heapPtr: [*]u8 = @ptrCast(&microzig_heap_start);
    const heap_len: usize = @intFromPtr(&microzig_heap_end) - @intFromPtr(&microzig_heap_start) - reserve;
    return heapPtr[0..heap_len];
}

pub const Error = error{BufferTooSmall};

/// Set up an allocator by adding all the memory that is not otherwise used by the program.
///
/// In normal configurations, the heap allocations will grow down from the start of the heap to
/// the end of memory, while the stack will grow from up from the end of memory.  To help prevent
/// the heap and stack from overlapping, the allocator can reserve a small amount of memory at the
/// end of the heap for the stack's exclusive use.
///
/// Example of use:
/// ```
/// // Get a heap allocator instance reserving 1024 bytes for the stack.
/// var heap_allocator = microzig.Allocator.init_with_heap(1024) catch unreachable;
///
/// // Get the std.mem.Allocator from the heap allocator.
/// const allocator : std.mem.Allocator = heap_allocator.allocator();
/// ```
///
/// Parameters:
/// - `reserve`: The number of bytes to omit at the end of the heap.
///
pub fn init_with_heap(reserve: usize) Error!Alloc {
    return init_with_buffer(heap(reserve));
}

/// Set up an allocator using the supplied buffer.
///
/// Example of use:
/// ```
/// const buffer: [4096]u8 = undefined;
///
/// // Get a buffer allocator instance reserving 1024 bytes for the stack.
/// var buffer_allocator = microzig.Allocator.init_with_buffer(buffer) catch unreachable;
///
/// // Get the std.mem.Allocator from the buffer allocator.
/// const allocator : std.mem.Allocator = buffer_allocator.allocator();
/// ```
///
/// Parameters:
/// - `buffer`: The buffer to use for allocation.
///
pub fn init_with_buffer(buffer: []u8) Error!Alloc {
    // Check if buffer is large enough for the header calculation
    if (buffer.len < Chunk.header_size) {
        return error.BufferTooSmall;
    }

    const low_boundary = Chunk.alignment.forward(@intFromPtr(buffer.ptr));
    const high_boundary = Chunk.alignment.backward(@intFromPtr(buffer.ptr) + buffer.len - Chunk.header_size);

    // Check if we have enough space after alignment
    if (high_boundary <= low_boundary or high_boundary - low_boundary < Chunk.min_size) {
        return error.BufferTooSmall;
    }

    var self = Alloc{
        .low_boundary = low_boundary,
        .high_boundary = high_boundary,
    };

    // Create the initial chunk with all the space as free memory.

    const init_chunk: *Chunk = @ptrFromInt(self.low_boundary);

    init_chunk.previous_size = 0;
    init_chunk._size = self.high_boundary - self.low_boundary;
    init_chunk.next_free = null;
    init_chunk.prior_free = null;

    self.free_lists[free_index_for_size(init_chunk.size())] = init_chunk;

    return self;
}

/// Returns a std.mem.Allocator for the allocator
pub fn allocator(self: *Alloc) std.mem.Allocator {
    return .{
        .ptr = self,
        .vtable = &vtable,
    };
}

/// Returns the total amount of free memory in the heap.
pub fn free_heap(self: *Alloc) usize {
    self.mutex.lock();
    defer self.mutex.unlock();

    var total: usize = 0;
    for (0..free_list_count) |i| {
        var c = self.free_lists[i];
        while (c) |chunk| {
            total += chunk.size() - Chunk.header_size;
            c = chunk.next_free;
        }
    }
    return total;
}

/// Returns the largest length that can be currently allocated.
pub fn max_alloc_size(self: *Alloc) usize {
    self.mutex.lock();
    defer self.mutex.unlock();

    var maximum: usize = 0;
    for (0..free_list_count) |i| {
        var c = self.free_lists[i];
        while (c) |chunk| {
            maximum = @max(maximum, chunk.size() - Chunk.header_size);
            c = chunk.next_free;
        }
    }
    return maximum;
}

/// The allocator's virtual table
const vtable: std.mem.Allocator.VTable =
    .{
        .alloc = do_alloc,
        .resize = do_resize,
        .remap = std.mem.Allocator.noRemap,
        .free = do_free,
    };

/// Allocate memory
///
/// Parameters:
/// - `len`      : The length of the memory to allocate
/// - `alignment`: The alignment of the memory to allocate (log2 of byte alignment)
///
/// Returns:
/// - `?[*]u8`: A pointer to the allocated memory, or null if insufficient memory is available
fn do_alloc(ptr: *anyopaque, len: usize, alignment: Alignment, pc: usize) ?[*]u8 {
    const self: *Alloc = @ptrCast(@alignCast(ptr));

    self.mutex.lock();
    defer self.mutex.unlock();

    const needed = @max(len, @sizeOf(Chunk) - Chunk.header_size);

    var free_index = free_index_for_size(needed);

    while (free_index < free_list_count) {
        var maybe_chunk = self.free_lists[free_index];

        while (maybe_chunk) |c| {
            var data_addr: usize = @intFromPtr(c.data());
            var available = c.size() - Chunk.header_size;
            var trim_leading = false;

            // Force data_addr alignment by trimming off leading bytes
            // of at least Chunk.min_size bytes.

            if (!alignment.check(data_addr)) {
                data_addr = alignment.forward(data_addr);
                var offset = data_addr - @intFromPtr(c.data());

                while (offset < Chunk.min_size) {
                    data_addr += alignment.toByteUnits();
                    offset += alignment.toByteUnits();
                }

                available = if (offset > available) 0 else available - offset;
                trim_leading = true;
            }

            if (available >= needed) {
                // OK, We have enough space to fit the requested memory, unlink the chunk.

                c.unlink(self);
                var our_chunk = c;

                // Trim off leading bytes
                if (trim_leading) {
                    const next_chunk: *Chunk = c.get_next();

                    our_chunk = @ptrCast(@alignCast(@as(*u8, @ptrFromInt(data_addr - Chunk.header_size))));
                    our_chunk.previous_size = data_addr - @intFromPtr(c.data());
                    our_chunk._size = (available + Chunk.header_size);

                    c._size = our_chunk.previous_size;

                    if (@intFromPtr(next_chunk) < self.high_boundary) {
                        next_chunk.previous_size = our_chunk._size;
                    }

                    our_chunk._size |= 0x01; // so we don't recombine it

                    c.combine_and_free(self);
                }

                // See if there is trailing space that we can trim off.

                const trim_addr = Chunk.alignment.forward(data_addr + needed);
                const next_addr = @intFromPtr(our_chunk.get_next());
                const our_address = @intFromPtr(our_chunk);
                const our_new_size = trim_addr - our_address;

                // Only trim if both the shrunk chunk and the new trim chunk are at least min_size
                if (our_new_size >= Chunk.min_size and trim_addr + Chunk.min_size <= next_addr) {
                    our_chunk._size = our_new_size | 0x01;

                    const trim_chunk: *Chunk = @ptrFromInt(trim_addr);
                    trim_chunk._size = next_addr - trim_addr;
                    trim_chunk.previous_size = our_new_size;

                    trim_chunk.combine_and_free(self);
                }

                our_chunk._size |= 0x01;

                return our_chunk.data();
            }

            maybe_chunk = c.next_free;
        }

        free_index += 1;
    }

    if (self.fallback) |f| {
        return do_alloc(f, len, alignment, pc);
    }

    return null;
}

/// Resize memory.  This function attempts to resize the memory in place.
///
/// Parameters:
/// - `memory`   : The memory to resize
/// - `new_len`  : The new length of the memory to resize
///
/// Returns:
/// - `bool`: True if the resize was successful, false otherwise
fn do_resize(ptr: *anyopaque, memory: []u8, _: Alignment, new_len: usize, _: usize) bool {
    const self: *Alloc = @ptrCast(@alignCast(ptr));

    self.mutex.lock();
    defer self.mutex.unlock();

    var chunk = Chunk.from_data(memory, self);

    if (new_len > chunk.size() - Chunk.header_size) {
        // We need to grow the chunk, which means the next chunk must be free.

        if (!chunk.get_next().is_free(self)) return false;

        const target_size = new_len + Chunk.header_size;
        const combined_size = chunk.size() + chunk.get_next().size();

        // We can't grow the chunk if there isn't enough space.

        if (combined_size < target_size) return false;

        // OK, we can grow the chunk.

        chunk.get_next().unlink(self);

        chunk._size = combined_size;
        chunk.get_next().previous_size = combined_size;
    }

    // See if there is trailing space that we can trim off.

    const data_addr = @intFromPtr(chunk.data());
    const trim_addr = Chunk.alignment.forward(data_addr + new_len);
    const next_addr = @intFromPtr(chunk.get_next());
    const our_address = @intFromPtr(chunk);
    const our_new_size = trim_addr - our_address;

    // Only trim if both the shrunk chunk and the new trim chunk are at least min_size
    if (our_new_size >= Chunk.min_size and trim_addr + Chunk.min_size <= next_addr) {
        chunk._size = our_new_size | 0x01;

        const trim_chunk: *Chunk = @ptrFromInt(trim_addr);
        trim_chunk._size = next_addr - trim_addr;
        trim_chunk.previous_size = our_new_size;

        trim_chunk.combine_and_free(self);
    }

    return true;
}

/// Free memory
///
/// Parameters:
/// - `memory`   : The memory to free
fn do_free(ptr: *anyopaque, memory: []u8, alignment: Alignment, pc: usize) void {
    const self: *Alloc = @ptrCast(@alignCast(ptr));

    const addr = @intFromPtr(memory.ptr);
    if (addr < self.low_boundary or addr >= self.high_boundary) {
        if (self.fallback) |f| {
            do_free(f, memory, alignment, pc);
            return;
        }

        @panic("free - address is not in range");
    }

    self.mutex.lock();
    defer self.mutex.unlock();

    Chunk.from_data(memory, self).combine_and_free(self);
}

/// Return the index of the first free list that can hold a chunk of the
/// given size.
///
///  Parameters:
/// - `size`: The size of the chunk
///
/// Returns:
/// - `usize`: The index of the free list
fn free_index_for_size(size: usize) usize {
    var test_size: usize = Chunk.min_size;
    for (0..free_list_count - 1) |i| {
        if (test_size >= size) return i;
        test_size *= 2;
    }

    return free_list_count - 1;
}

/// The heap consists of a number of contiguous, variable length chunks.
/// Each chunk has a header that contains metadata about the chunk.
///
/// A chunk is either allocated or free.
///
/// An allocated chunk has the following layout:
///
///     [previous_size][size+1][data]
///
/// A free chunk has the following layout:
///
///     [previous_size][size][next_free][prior_free][unused]
///
/// Since the actual size of a chunk is always even, we can use the least
/// significant bit of the size field to mark the chunk as in use.
pub const Chunk = extern struct {
    previous_size: usize = 0,
    _size: usize = 0, // chunk size and in-use flag
    prior_free: ?*Chunk = null,
    next_free: ?*Chunk = null,

    /// Size of the chunk header (previous_size and _size fields).
    /// This is the overhead present in every chunk, both allocated and free.
    const header_size = @offsetOf(Chunk, "prior_free");

    /// Minimum size of a chunk. Must be large enough to hold the complete
    /// Chunk struct so that when freed, there's room for the free list pointers.
    const min_size = @sizeOf(Chunk);

    /// Required alignment for chunk addresses and sizes.
    const alignment = Alignment.fromByteUnits(@alignOf(Chunk));

    /// Returns a pointer to the chunk that contains the given data.
    pub fn from_data(data_slice: []u8, alloc: *Alloc) *Chunk {
        // If we are built with .Debug or .ReleaseSafe, we need to do a slow
        // search to make sure the slice is valid.
        std.debug.assert(blk: {
            var chunk: *Chunk = @ptrFromInt(alloc.low_boundary);
            while (@intFromPtr(chunk) < alloc.high_boundary) {
                if (data_slice.ptr == chunk.data()) {
                    break :blk true;
                }
                chunk = chunk.get_next();
            }
            break :blk false;
        });

        // Otherwise, just go for it.
        return @as(*Chunk, @ptrCast(@alignCast(data_slice.ptr - header_size)));
    }

    /// Return a data slice that maps the chunk's memory the user can use.
    pub fn data(self: *Chunk) [*]u8 {
        return @as([*]u8, @ptrCast(self)) + header_size;
    }

    /// Returns the size of the chunk in bytes.
    pub fn size(self: *Chunk) usize {
        return self._size & ~@as(usize, 0x01);
    }

    /// Returns true of the chunk is marked as free.  That is the low order bit
    /// of the size value is clear.
    ///
    /// An out-of-range Chunk pointer will return `false` (not free).
    pub fn is_free(self: *Chunk, alloc: *Alloc) bool {
        const addr: usize = @intFromPtr(self);
        if (addr < alloc.low_boundary or addr >= alloc.high_boundary) return false;

        return (self._size & 0x01) == 0;
    }

    /// Returns a pointer to the previous chunk in the heap.
    /// Note: this can return an out of range Chunk pointer.
    pub fn get_prior(self: *Chunk) *Chunk {
        return @ptrFromInt(@intFromPtr(self) - self.previous_size);
    }

    /// Returns a pointer to the next chunk in the heap.
    /// Note: this can return an out of range Chunk pointer.
    pub fn get_next(self: *Chunk) *Chunk {
        return @ptrFromInt(@intFromPtr(self) + self.size());
    }

    /// Combine this chunk with any neighboring free chunks and
    /// add the result to the appropriate free list.
    pub fn combine_and_free(self: *Chunk, alloc: *Alloc) void {
        var chunk = self;

        chunk._size &= ~@as(usize, 0x01); // Make sure the chunk is marked free.

        var next = chunk.get_next();
        if (next.is_free(alloc)) {

            // combine the chunks
            next.unlink(alloc);
            chunk._size += next._size;

            // update the next pointer
            next = next.get_next();
        }

        if (chunk.previous_size != 0) {
            const prior = chunk.get_prior();
            if (prior.is_free(alloc)) {

                // combine the chunks
                const our_size = chunk._size;
                chunk = prior;
                chunk.unlink(alloc);
                chunk._size += our_size;
            }
        }

        // set next chunk's previous size
        if (@intFromPtr(next) < alloc.high_boundary) {
            next.previous_size = chunk._size;
        }

        const free_index = free_index_for_size(chunk.size());
        const list = alloc.free_lists[free_index];

        chunk.prior_free = null;
        chunk.next_free = list;

        if (list) |head| head.prior_free = chunk;
        alloc.free_lists[free_index] = chunk;
    }

    /// Unlink the chunk from the free list.
    pub fn unlink(self: *Chunk, alloc: *Alloc) void {
        if (!self.is_free(alloc)) @panic("unlink - Chunk is not free");

        if (self.prior_free) |p| {
            p.next_free = self.next_free;
        } else {
            const free_list = free_index_for_size(self.size());
            alloc.free_lists[free_list] = self.next_free;
        }

        if (self.next_free) |n| n.prior_free = self.prior_free;
    }
};

//------------------------------------------------------------------------------
// Debugging Functions

/// Displays free chunk chains.
///
/// All chunks show address, size, and  prior and next free chunks addresses.
///
/// This function is intended for use in a debug build.
/// It writes to the debug log.
pub fn dbg_log_free_chains(self: *Alloc) void {
    std.log.debug("", .{});

    for (0..free_list_count) |i| {
        var chunks = self.free_lists[i];

        if (chunks == null) continue;

        std.log.debug("Free list {d}: ", .{i});

        while (chunks) |chunk| {
            if (chunk.is_free(self)) {
                std.log.debug(
                    "  0x{x:08} {d:6} {x:08} {x:08} ",
                    .{
                        @intFromPtr(chunk),            chunk.size(),
                        @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free),
                    },
                );
            } else {
                std.log.debug(
                    "  0x{x:08} {d:6} {x:08} {x:08} <NOT FREE>",
                    .{
                        @intFromPtr(chunk),            chunk.size(),
                        @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free),
                    },
                );
            }

            chunks = chunk.next_free;
        }
    }
}

/// Displays the chunk list.
/// All chunks show address, size and previous chunk size.
/// Free chunks show prior and next free chunks addresses.
///
/// This function is intended for use in a debug build.
/// It writes to the debug log.
pub fn dbg_log_chunk_list(self: *Alloc) void {
    var address: usize = self.low_boundary;
    var idx: usize = 0;

    std.log.debug("", .{});
    std.log.debug("   idx      addr   size   prev    prior     next", .{});
    std.log.debug("   ---      ----   ----   ----    -----     ----", .{});

    while (address < self.high_boundary) {
        const chunk: *Chunk = @ptrFromInt(address);

        if (chunk.is_free(self)) {
            std.log.debug(
                "{d:6}  {x:08} {d:6} {d:6} {x:08} {x:08}; ",
                .{
                    idx,                 @intFromPtr(chunk),            chunk.size(),
                    chunk.previous_size, @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free),
                },
            );
        } else {
            std.log.debug(
                "{d:6}  {x:08} {d:6} {d:6}; ",
                .{ idx, @intFromPtr(chunk), chunk.size(), chunk.previous_size },
            );
        }

        address += chunk.size();
        idx += 1;
    }
}

/// Check the integrity of the allocator memory pool.
/// This function is intended for use in a debug build.
/// It will log any errors to the debug log.
pub fn dbg_integrity_check(self: *Alloc) bool {
    self.mutex.lock();
    defer self.mutex.unlock();

    var valid: bool = true;

    // Phase 1: Walk through all chunks linearly and verify basic structure.
    // We mark each chunk by setting bit 0 of previous_size to 1.

    var previous_size: usize = 0;
    var address: usize = self.low_boundary;
    var chunk_count: usize = 0;

    while (address < self.high_boundary) {
        const chunk: *Chunk = @ptrFromInt(address);
        chunk_count += 1;

        // Check address alignment
        if (!Chunk.alignment.check(address)) {
            valid = false;
            std.log.debug("Integrity check failed: chunk 0x{x:08} is not properly aligned\n", .{address});
        }

        const chunk_size = chunk.size();

        // Check for zero size (would cause infinite loop)
        if (chunk_size == 0) {
            valid = false;
            std.log.debug("Integrity check failed: chunk 0x{x:08} has zero size\n", .{address});
            break; // Can't continue - would loop forever
        }

        // Check minimum chunk size
        if (chunk_size < Chunk.min_size) {
            valid = false;
            std.log.debug(
                "Integrity check failed: chunk 0x{x:08} size {d} < min_size {d}\n",
                .{ address, chunk_size, Chunk.min_size },
            );
        }

        // Check size alignment
        if (!Chunk.alignment.check(chunk_size)) {
            valid = false;
            std.log.debug(
                "Integrity check failed: chunk 0x{x:08} size {d} is not properly aligned\n",
                .{ address, chunk_size },
            );
        }

        // Verify previous_size chain
        if (chunk.previous_size != previous_size) {
            valid = false;
            std.log.debug(
                "Integrity check failed: chunk 0x{x:08} previous_size {d} != expected {d}\n",
                .{ address, chunk.previous_size, previous_size },
            );
        }

        previous_size = chunk_size;
        address += chunk_size;

        // Mark this chunk as visited
        chunk.previous_size |= 0x01;
    }

    // Check that we ended exactly at high_boundary (not before, not after)
    if (address != self.high_boundary) {
        valid = false;
        std.log.debug(
            "Integrity check failed: chunk traversal ended at 0x{x:08}, expected 0x{x:08}\n",
            .{ address, self.high_boundary },
        );
    }

    // Phase 2: Verify free lists integrity.
    // - Each chunk on a free list must be marked as free
    // - Each chunk must exist in the chunk list (was visited in phase 1)
    // - Doubly-linked list pointers must be consistent
    // - Chunks must be in the correct size bin
    // We clear the marker bit for chunks we find on free lists.

    for (0..free_list_count) |i| {
        var prev_in_list: ?*Chunk = null;
        var chunk_in_list = self.free_lists[i];

        while (chunk_in_list) |chunk| {
            // Verify chunk is marked as free
            if (!chunk.is_free(self)) {
                valid = false;
                std.log.debug(
                    "Integrity check failed: chunk 0x{x:08} on free list {d} is not marked free\n",
                    .{ @intFromPtr(chunk), i },
                );
            }

            // Verify chunk is in the correct size bin
            const expected_bin = free_index_for_size(chunk.size());
            if (expected_bin != i) {
                valid = false;
                std.log.debug(
                    "Integrity check failed: chunk 0x{x:08} size {d} in bin {d}, expected bin {d}\n",
                    .{ @intFromPtr(chunk), chunk.size(), i, expected_bin },
                );
            }

            // Verify prior_free pointer is consistent
            if (chunk.prior_free != prev_in_list) {
                valid = false;
                std.log.debug(
                    "Integrity check failed: chunk 0x{x:08} prior_free 0x{x:08} != expected 0x{x:08}\n",
                    .{ @intFromPtr(chunk), @intFromPtr(chunk.prior_free), @intFromPtr(prev_in_list) },
                );
            }

            // Verify chunk exists in the heap (was visited in phase 1)
            // We check if the marker bit is set
            if (chunk.previous_size & 0x01 == 0) {
                valid = false;
                std.log.debug(
                    "Integrity check failed: chunk 0x{x:08} on free list not found in heap\n",
                    .{@intFromPtr(chunk)},
                );
            }

            // Clear the marker bit to indicate this chunk is on a free list
            chunk.previous_size &= ~@as(usize, 0x01);

            prev_in_list = chunk;
            chunk_in_list = chunk.next_free;
        }
    }

    // Phase 3: Final verification pass.
    // Any chunk still marked (bit 0 set) was not on any free list.
    // If such a chunk claims to be free (_size bit 0 clear), that's an error.
    // Clear all marker bits.

    address = self.low_boundary;
    while (address < self.high_boundary) {
        const chunk: *Chunk = @ptrFromInt(address);
        const chunk_size = chunk.size();

        // If still marked (not on free list) but claims to be free
        if (chunk.previous_size & 0x01 != 0 and chunk._size & 0x01 == 0) {
            valid = false;
            std.log.debug(
                "Integrity check failed: chunk 0x{x:08} is marked free but not on any free list\n",
                .{address},
            );
        }

        // Clear the marker bit
        chunk.previous_size &= ~@as(usize, 0x01);

        // Guard against zero size (shouldn't happen if phase 1 passed, but be safe)
        if (chunk_size == 0) break;
        address += chunk_size;
    }

    return valid;
}

// =============================================================================
// Unit Tests
// =============================================================================

const testing = std.testing;

// -----------------------------------------------------------------------------
// Category 1: Initialization Tests
// -----------------------------------------------------------------------------

test "init_with_buffer - minimum viable buffer" {
    // Minimum buffer must be at least Chunk.min_size + alignment overhead
    var buffer: [Chunk.min_size * 2]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);

    try testing.expect(alloc.low_boundary >= @intFromPtr(&buffer));
    try testing.expect(alloc.high_boundary <= @intFromPtr(&buffer) + buffer.len);
    try testing.expect(alloc.dbg_integrity_check());
}

test "init_with_buffer - alignment correction" {
    // Use unaligned buffer to test alignment adjustment
    var buffer: [256]u8 align(1) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);

    // Low boundary should be aligned
    try testing.expect(Chunk.alignment.check(alloc.low_boundary));
    try testing.expect(alloc.dbg_integrity_check());
}

test "init_with_buffer - initial free chunk setup" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);

    // There should be exactly one free chunk initially
    var free_count: usize = 0;
    for (0..free_list_count) |i| {
        var c = alloc.free_lists[i];
        while (c) |chunk| {
            free_count += 1;
            // The initial chunk should have previous_size = 0
            try testing.expectEqual(@as(usize, 0), chunk.previous_size);
            c = chunk.next_free;
        }
    }
    try testing.expectEqual(@as(usize, 1), free_count);
    try testing.expect(alloc.dbg_integrity_check());
}

test "init_with_buffer - buffer too small" {
    // Buffer too small to fit even a single chunk
    var tiny_buffer: [8]u8 align(16) = undefined;
    try testing.expectError(error.BufferTooSmall, Alloc.init_with_buffer(&tiny_buffer));

    // Buffer at header size but not enough for min_size after alignment
    var small_buffer: [Chunk.header_size]u8 align(16) = undefined;
    try testing.expectError(error.BufferTooSmall, Alloc.init_with_buffer(&small_buffer));
}

test "init_with_buffer - buffer large enough but allocation fails" {
    // Buffer large enough to initialize but too small for big allocations
    var buffer: [64]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);

    // Should initialize, but large allocations fail
    const a = alloc.allocator();
    const result = a.alloc(u8, 1000);
    try testing.expectError(error.OutOfMemory, result);
}

// -----------------------------------------------------------------------------
// Category 2: Basic Allocation Tests
// -----------------------------------------------------------------------------

test "alloc - single allocation" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alloc(u8, 64);
    try testing.expectEqual(@as(usize, 64), mem.len);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem);
    try testing.expect(alloc.dbg_integrity_check());
}

test "alloc - multiple sequential allocations" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 128);
    const mem3 = try a.alloc(u8, 32);

    try testing.expect(mem1.ptr != mem2.ptr);
    try testing.expect(mem2.ptr != mem3.ptr);
    try testing.expect(mem1.ptr != mem3.ptr);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem1);
    a.free(mem2);
    a.free(mem3);
    try testing.expect(alloc.dbg_integrity_check());
}

test "alloc - various sizes" {
    var buffer: [4096]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const sizes = [_]usize{ 1, 7, 8, 15, 16, 31, 32, 63, 64, 100, 200 };
    var allocations: [sizes.len][]u8 = undefined;

    for (sizes, 0..) |size, i| {
        allocations[i] = try a.alloc(u8, size);
        try testing.expectEqual(size, allocations[i].len);
    }

    try testing.expect(alloc.dbg_integrity_check());

    for (allocations) |mem| {
        a.free(mem);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

test "alloc - write and read back data" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alloc(u8, 256);

    // Write pattern
    for (mem, 0..) |*byte, i| {
        byte.* = @truncate(i);
    }

    // Read back and verify
    for (mem, 0..) |byte, i| {
        try testing.expectEqual(@as(u8, @truncate(i)), byte);
    }

    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

// -----------------------------------------------------------------------------
// Category 3: Alignment Tests
// -----------------------------------------------------------------------------

test "alloc - alignment 1" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alignedAlloc(u8, .@"1", 64);
    try testing.expect(@intFromPtr(mem.ptr) % 1 == 0);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "alloc - alignment 4" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alignedAlloc(u8, .@"4", 64);
    try testing.expect(@intFromPtr(mem.ptr) % 4 == 0);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "alloc - alignment 8" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alignedAlloc(u8, .@"8", 64);
    try testing.expect(@intFromPtr(mem.ptr) % 8 == 0);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "alloc - alignment 16" {
    var buffer: [2048]u8 align(32) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alignedAlloc(u8, .@"16", 64);
    try testing.expect(@intFromPtr(mem.ptr) % 16 == 0);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "alloc - alignment 32" {
    var buffer: [4096]u8 align(64) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alignedAlloc(u8, .@"32", 64);
    try testing.expect(@intFromPtr(mem.ptr) % 32 == 0);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "alloc - mixed alignments" {
    var buffer: [4096]u8 align(64) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alignedAlloc(u8, .@"4", 32);
    const mem2 = try a.alignedAlloc(u8, .@"16", 64);
    const mem3 = try a.alignedAlloc(u8, .@"8", 48);

    try testing.expect(@intFromPtr(mem1.ptr) % 4 == 0);
    try testing.expect(@intFromPtr(mem2.ptr) % 16 == 0);
    try testing.expect(@intFromPtr(mem3.ptr) % 8 == 0);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem1);
    a.free(mem2);
    a.free(mem3);
    try testing.expect(alloc.dbg_integrity_check());
}

// -----------------------------------------------------------------------------
// Category 4: Resize Tests
// -----------------------------------------------------------------------------

test "resize - grow in place when next chunk is free" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var mem = try a.alloc(u8, 64);
    const original_ptr = mem.ptr;

    // Should be able to grow since all remaining space is free
    const success = a.resize(mem, 128);
    try testing.expect(success);
    mem = mem.ptr[0..128];

    // Pointer should remain the same
    try testing.expectEqual(original_ptr, mem.ptr);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem);
}

test "resize - shrink releases trailing space" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var mem = try a.alloc(u8, 256);
    const original_free = alloc.free_heap();

    // Shrink the allocation
    const success = a.resize(mem, 64);
    try testing.expect(success);
    mem = mem.ptr[0..64];

    // Free space should have increased
    try testing.expect(alloc.free_heap() > original_free);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem);
}

test "resize - grow fails when next chunk is in use" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 64);

    // Cannot grow mem1 since mem2 is right after it
    const success = a.resize(mem1, 128);
    try testing.expect(!success);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem1);
    a.free(mem2);
}

test "resize - grow fails when not enough combined space" {
    var buffer: [512]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem = try a.alloc(u8, 64);

    // Try to grow beyond available space
    const success = a.resize(mem, 10000);
    try testing.expect(!success);
    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem);
}

test "resize - shrink to minimum" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var mem = try a.alloc(u8, 256);

    // Shrink to minimum size
    const success = a.resize(mem, 1);
    try testing.expect(success);
    mem = mem.ptr[0..1];

    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

// -----------------------------------------------------------------------------
// Category 5: Free & Coalescing Tests
// -----------------------------------------------------------------------------

test "free - coalesce with next free chunk" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 64);

    // Free mem2 first (next chunk becomes free)
    // Then free mem1 - should coalesce forward
    a.free(mem2);
    const free_before = alloc.free_heap();
    a.free(mem1);

    // Free heap should be larger than just mem1 + mem2 due to header savings
    try testing.expect(alloc.free_heap() >= free_before + 64);
    try testing.expect(alloc.dbg_integrity_check());
}

test "free - coalesce with prior free chunk" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 64);

    // Free mem1 first (prior chunk becomes free)
    a.free(mem1);
    const free_before = alloc.free_heap();

    // Then free mem2 - should coalesce backward
    a.free(mem2);

    try testing.expect(alloc.free_heap() >= free_before + 64);
    try testing.expect(alloc.dbg_integrity_check());
}

test "free - coalesce with both neighbors" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 64);
    const mem3 = try a.alloc(u8, 64);

    // Free first and third
    a.free(mem1);
    a.free(mem3);
    const free_before = alloc.free_heap();

    // Free middle - should coalesce with both neighbors
    a.free(mem2);

    try testing.expect(alloc.free_heap() >= free_before + 64);
    try testing.expect(alloc.dbg_integrity_check());
}

test "free - no coalescing when neighbors are in use" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const mem1 = try a.alloc(u8, 64);
    const mem2 = try a.alloc(u8, 64);
    const mem3 = try a.alloc(u8, 64);

    // Free middle - neighbors still in use, no coalescing
    a.free(mem2);

    try testing.expect(alloc.dbg_integrity_check());

    a.free(mem1);
    a.free(mem3);
    try testing.expect(alloc.dbg_integrity_check());
}

// -----------------------------------------------------------------------------
// Category 6: Fragmentation Tests
// -----------------------------------------------------------------------------

test "fragmentation - alternating alloc/free pattern" {
    var buffer: [4096]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var ptrs: [10][]u8 = undefined;

    // Allocate all
    for (&ptrs) |*p| {
        p.* = try a.alloc(u8, 64);
    }

    // Free odd indices
    var i: usize = 1;
    while (i < ptrs.len) : (i += 2) {
        a.free(ptrs[i]);
    }

    try testing.expect(alloc.dbg_integrity_check());

    // Allocate in freed slots
    i = 1;
    while (i < ptrs.len) : (i += 2) {
        ptrs[i] = try a.alloc(u8, 64);
    }

    try testing.expect(alloc.dbg_integrity_check());

    // Free all
    for (ptrs) |p| {
        a.free(p);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

test "fragmentation - recovery after full fragmentation" {
    var buffer: [4096]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    const initial_free = alloc.free_heap();

    // Create fragmentation
    var ptrs: [20][]u8 = undefined;
    for (&ptrs) |*p| {
        p.* = try a.alloc(u8, 32);
    }

    // Free every other allocation
    var i: usize = 0;
    while (i < ptrs.len) : (i += 2) {
        a.free(ptrs[i]);
    }

    try testing.expect(alloc.dbg_integrity_check());

    // Free remaining allocations
    i = 1;
    while (i < ptrs.len) : (i += 2) {
        a.free(ptrs[i]);
    }

    // Should recover most memory (within rounding)
    try testing.expect(alloc.free_heap() >= initial_free - Chunk.min_size);
    try testing.expect(alloc.dbg_integrity_check());
}

// -----------------------------------------------------------------------------
// Category 7: OOM Handling Tests
// -----------------------------------------------------------------------------

test "oom - returns null on exhaustion" {
    var buffer: [256]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Request more than available
    const result = a.alloc(u8, 10000);
    try testing.expectError(error.OutOfMemory, result);
    try testing.expect(alloc.dbg_integrity_check());
}

test "oom - near exhaustion still works" {
    var buffer: [512]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Allocate until near exhaustion
    var allocations: std.ArrayListUnmanaged([]u8) = .empty;
    defer allocations.deinit(testing.allocator);

    while (true) {
        const mem = a.alloc(u8, 32) catch break;
        try allocations.append(testing.allocator, mem);
    }

    try testing.expect(allocations.items.len > 0);
    try testing.expect(alloc.dbg_integrity_check());

    // Free all
    for (allocations.items) |mem| {
        a.free(mem);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

test "oom - allocation after oom still works" {
    var buffer: [512]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Cause OOM
    const too_big = a.alloc(u8, 10000);
    try testing.expectError(error.OutOfMemory, too_big);

    // Should still be able to allocate reasonable sizes
    const mem = try a.alloc(u8, 64);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

// -----------------------------------------------------------------------------
// Category 8: Free List Integrity Tests
// -----------------------------------------------------------------------------

test "free_list - correct binning by size" {
    var buffer: [8192]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Allocate various sizes and free them to populate different bins
    const small = try a.alloc(u8, 16);
    const medium = try a.alloc(u8, 128);
    const large = try a.alloc(u8, 512);

    a.free(small);
    a.free(medium);
    a.free(large);

    try testing.expect(alloc.dbg_integrity_check());

    // Verify free lists contain chunks
    var total_free_chunks: usize = 0;
    for (0..free_list_count) |i| {
        var c = alloc.free_lists[i];
        while (c) |chunk| {
            total_free_chunks += 1;
            // Verify chunk is actually free
            try testing.expect(chunk.is_free(&alloc));
            c = chunk.next_free;
        }
    }
    try testing.expect(total_free_chunks >= 1);
}

test "free_list - traversal consistency" {
    var buffer: [4096]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Create multiple free chunks
    var ptrs: [5][]u8 = undefined;
    for (&ptrs) |*p| {
        p.* = try a.alloc(u8, 64);
    }

    // Free every other one
    a.free(ptrs[0]);
    a.free(ptrs[2]);
    a.free(ptrs[4]);

    // Traverse all free lists and verify bidirectional links
    for (0..free_list_count) |i| {
        var c = alloc.free_lists[i];
        var prev: ?*Chunk = null;
        while (c) |chunk| {
            // Verify prior_free points to previous chunk in traversal
            try testing.expectEqual(prev, chunk.prior_free);
            prev = chunk;
            c = chunk.next_free;
        }
    }

    try testing.expect(alloc.dbg_integrity_check());

    a.free(ptrs[1]);
    a.free(ptrs[3]);
}

// -----------------------------------------------------------------------------
// Category 9: Edge Case Tests
// -----------------------------------------------------------------------------

test "edge - minimum allocation size" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Allocate minimum size
    const mem = try a.alloc(u8, 1);
    try testing.expectEqual(@as(usize, 1), mem.len);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem);
}

test "edge - zero length allocation" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Zero-length allocation behavior depends on std.mem.Allocator
    // It typically returns a valid slice with len=0
    const mem = try a.alloc(u8, 0);
    try testing.expectEqual(@as(usize, 0), mem.len);
    a.free(mem);
    try testing.expect(alloc.dbg_integrity_check());
}

test "edge - max single allocation" {
    var buffer: [4096]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Get max allocatable size
    const max_size = alloc.max_alloc_size();

    if (max_size > 0) {
        const mem = try a.alloc(u8, max_size);
        try testing.expect(alloc.dbg_integrity_check());
        a.free(mem);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

test "edge - exact fit allocation" {
    var buffer: [1024]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Allocate exact max size
    const max_size = alloc.max_alloc_size();
    if (max_size > 0) {
        const mem = try a.alloc(u8, max_size);
        try testing.expectEqual(max_size, mem.len);
        try testing.expect(alloc.dbg_integrity_check());
        a.free(mem);
    }
}

test "edge - boundary chunk handling" {
    var buffer: [Chunk.min_size * 4]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    // Allocate and free at boundaries
    const mem1 = try a.alloc(u8, 1);
    try testing.expect(alloc.dbg_integrity_check());
    a.free(mem1);

    // Allocate near max
    const max_size = alloc.max_alloc_size();
    if (max_size > 0) {
        const mem2 = try a.alloc(u8, max_size);
        try testing.expect(alloc.dbg_integrity_check());
        a.free(mem2);
    }

    try testing.expect(alloc.dbg_integrity_check());
}

// -----------------------------------------------------------------------------
// Category 10: Stress Tests
// -----------------------------------------------------------------------------

test "stress - random alloc/free pattern" {
    var buffer: [8192]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var prng = std.Random.DefaultPrng.init(12345);
    const random = prng.random();

    var allocations: std.ArrayListUnmanaged([]u8) = .empty;
    defer allocations.deinit(testing.allocator);

    // Perform random operations
    for (0..100) |_| {
        const action = random.intRangeAtMost(u8, 0, 2);

        if (action == 0 or allocations.items.len == 0) {
            // Allocate
            const size = random.intRangeAtMost(usize, 1, 128);
            if (a.alloc(u8, size)) |mem| {
                try allocations.append(testing.allocator, mem);
            } else |_| {}
        } else {
            // Free random allocation
            const idx = random.intRangeLessThan(usize, 0, allocations.items.len);
            a.free(allocations.items[idx]);
            _ = allocations.swapRemove(idx);
        }

        try testing.expect(alloc.dbg_integrity_check());
    }

    // Cleanup
    for (allocations.items) |mem| {
        a.free(mem);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

test "stress - rapid alloc/free cycles" {
    var buffer: [2048]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    for (0..50) |_| {
        const mem = try a.alloc(u8, 64);
        a.free(mem);
    }

    try testing.expect(alloc.dbg_integrity_check());

    // Should have recovered all memory
    const final_free = alloc.free_heap();
    const initial_free = alloc.high_boundary - alloc.low_boundary - Chunk.header_size;
    try testing.expect(final_free >= initial_free - Chunk.min_size);
}

test "stress - many small allocations" {
    var buffer: [8192]u8 align(16) = undefined;
    var alloc = try Alloc.init_with_buffer(&buffer);
    const a = alloc.allocator();

    var allocations: std.ArrayListUnmanaged([]u8) = .empty;
    defer allocations.deinit(testing.allocator);

    // Allocate many small chunks
    for (0..50) |_| {
        const mem = a.alloc(u8, 16) catch break;
        try allocations.append(testing.allocator, mem);
    }

    try testing.expect(allocations.items.len > 0);
    try testing.expect(alloc.dbg_integrity_check());

    // Free all
    for (allocations.items) |mem| {
        a.free(mem);
    }
    try testing.expect(alloc.dbg_integrity_check());
}

// -----------------------------------------------------------------------------
// Category 11: Fallback Allocator Tests
// -----------------------------------------------------------------------------

test "fallback - allocation delegates when primary exhausted" {
    var buffer1: [256]u8 align(16) = undefined;
    var buffer2: [256]u8 align(16) = undefined;

    var alloc1 = try Alloc.init_with_buffer(&buffer1);
    var alloc2 = try Alloc.init_with_buffer(&buffer2);

    // Chain allocators
    alloc1.fallback = &alloc2;

    const a = alloc1.allocator();

    // Exhaust primary
    var primary_allocations: std.ArrayListUnmanaged([]u8) = .empty;
    defer primary_allocations.deinit(testing.allocator);

    while (true) {
        const mem = a.alloc(u8, 64) catch break;
        try primary_allocations.append(testing.allocator, mem);
    }

    // Verify we got allocations from both buffers
    try testing.expect(primary_allocations.items.len > 0);

    // Cleanup
    for (primary_allocations.items) |mem| {
        a.free(mem);
    }
}

test "fallback - free delegates correctly" {
    var buffer1: [256]u8 align(16) = undefined;
    var buffer2: [512]u8 align(16) = undefined;

    var alloc1 = try Alloc.init_with_buffer(&buffer1);
    var alloc2 = try Alloc.init_with_buffer(&buffer2);

    alloc1.fallback = &alloc2;

    const a = alloc1.allocator();

    // Allocate from primary
    const mem1 = try a.alloc(u8, 32);

    // Exhaust primary to force fallback use
    var temp_allocs: std.ArrayListUnmanaged([]u8) = .empty;
    defer temp_allocs.deinit(testing.allocator);

    while (true) {
        const mem = a.alloc(u8, 32) catch break;
        try temp_allocs.append(testing.allocator, mem);
    }

    // Free in reverse order
    for (temp_allocs.items) |mem| {
        a.free(mem);
    }
    a.free(mem1);

    try testing.expect(alloc1.dbg_integrity_check());
    try testing.expect(alloc2.dbg_integrity_check());
}

test "fallback - chain of allocators" {
    var buffer1: [128]u8 align(16) = undefined;
    var buffer2: [128]u8 align(16) = undefined;
    var buffer3: [128]u8 align(16) = undefined;

    var alloc1 = try Alloc.init_with_buffer(&buffer1);
    var alloc2 = try Alloc.init_with_buffer(&buffer2);
    var alloc3 = try Alloc.init_with_buffer(&buffer3);

    // Create chain: alloc1 -> alloc2 -> alloc3
    alloc1.fallback = &alloc2;
    alloc2.fallback = &alloc3;

    const a = alloc1.allocator();

    var all_allocations: std.ArrayListUnmanaged([]u8) = .empty;
    defer all_allocations.deinit(testing.allocator);

    // Should be able to allocate from all three buffers
    while (true) {
        const mem = a.alloc(u8, 16) catch break;
        try all_allocations.append(testing.allocator, mem);
    }

    // Should have allocations spanning all three allocators
    try testing.expect(all_allocations.items.len > 0);

    // Cleanup
    for (all_allocations.items) |mem| {
        a.free(mem);
    }

    try testing.expect(alloc1.dbg_integrity_check());
    try testing.expect(alloc2.dbg_integrity_check());
    try testing.expect(alloc3.dbg_integrity_check());
}
