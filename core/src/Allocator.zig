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
fallback: ?*std.mem.Allocator = null,

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
/// var heap_allocator = microzig.Allocator.init_with_heap(1024);
///
/// // Get the std.mem.Allocator from the heap allocator.
/// const allocator : std.mem.Allocator = heap_allocator.allocator();
/// ```
///
/// Parameters:
/// - `reserve`: The number of bytes to omit at the end of the heap.
///
pub fn init_with_heap(reserve: usize) Alloc {
    return init_with_buffer(heap(reserve));
}

/// Set up an allocator using the supplied buffer.
///
/// Example of use:
/// ```
/// const buffer: [4096]u8 = undefined;
///
/// // Get a buffer allocator instance reserving 1024 bytes for the stack.
/// var buffer_allocator = microzig.Allocator.init_with_buffer(buffer);
///
/// // Get the std.mem.Allocator from the buffer allocator.
/// const allocator : std.mem.Allocator = buffer_allocator.allocator();
/// ```
///
/// Parameters:
/// - `buffer`: The buffer to use for allocation.
///
pub fn init_with_buffer(buffer: []u8) Alloc {
    var self = Alloc{
        .low_boundary = Chunk.alignment.forward(@intFromPtr(buffer.ptr)),
        .high_boundary = Chunk.alignment.backward(@intFromPtr(buffer.ptr + buffer.len) - Chunk.header_size),
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

                if (trim_addr + Chunk.min_size < next_addr) {
                    const our_address = @intFromPtr(our_chunk);

                    const our_new_size = trim_addr - our_address;

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

    if (trim_addr + Chunk.min_size < next_addr) {
        const our_address = @intFromPtr(chunk);

        const our_new_size = trim_addr - our_address;

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

    const header_size = 2 * @sizeOf(usize);
    const min_size = header_size + 2 * @sizeOf(?*Chunk);
    const alignment = Alignment.fromByteUnits(@alignOf(Alloc));

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
                std.log.debug("  0x{x:08} {d:6} {x:08} {x:08} ", .{ @intFromPtr(chunk), chunk.size(), @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free) });
            } else {
                std.log.debug("  0x{x:08} {d:6} {x:08} {x:08} <NOT FREE>", .{ @intFromPtr(chunk), chunk.size(), @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free) });
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
            std.log.debug("{d:6}  {x:08} {d:6} {d:6} {x:08} {x:08}; ", .{ idx, @intFromPtr(chunk), chunk.size(), chunk.previous_size, @intFromPtr(chunk.prior_free), @intFromPtr(chunk.next_free) });
        } else {
            std.log.debug("{d:6}  {x:08} {d:6} {d:6}; ", .{ idx, @intFromPtr(chunk), chunk.size(), chunk.previous_size });
        }

        address += chunk.size();
        idx += 1;
    }
}

/// Check the integrity of the allocator memory pool.
/// This function is intended for use in a debug build.
/// It will log any errors to the debug log.
pub fn dbg_integrity_check(self: *Alloc) bool {
    var valid: bool = true;

    var previous_size: usize = 0;

    // If we skip over memory based on chunk size we should end up exactly at the end of the heap.
    // Also, each previous_size should match the size of prior chunk.

    // We mark each chunk here by setting the low order bit of the previous size to 1.

    var address: usize = self.low_boundary;
    while (address < self.high_boundary) {
        const chunk: *Chunk = @ptrFromInt(address);

        if (chunk.previous_size != previous_size) {
            valid = false;
            std.log.debug("Chunk list integrity check failed: chunk 0x{x:08} previous_size {d} != {d}\n", .{ @intFromPtr(chunk), chunk.previous_size, previous_size });
        }

        previous_size = chunk.size();
        address += chunk.size();

        chunk.previous_size |= 0x01;
    }

    if (address > self.high_boundary) {
        valid = false;
        std.log.debug("Chunk list integrity check failed: address 0x{x:08} > high_boundary 0x{x:08}\n", .{ address, self.high_boundary });
    }

    // Every chunk on one of the fre lists should be marked free and should be a valid chunk
    // reachable by skipping over memory based on chunk size.

    // We clear the low order bit of the previous size to 0 for any free chunks.

    for (0..free_list_count) |i| {
        var chunks = self.free_lists[i];

        if (chunks == null) continue;

        while (chunks) |chunk| {
            if (!chunk.is_free(self)) {
                valid = false;
                std.log.debug("Chunk free list integrity check failed: chunk on free list 0x{x:08} is not free\n", .{@intFromPtr(chunk)});
            }

            var found: bool = false;

            var test_address: usize = self.low_boundary;
            while (test_address < self.high_boundary) {
                const test_chunk: *Chunk = @ptrFromInt(test_address);
                test_address += test_chunk.size();

                if (chunk == test_chunk) {
                    found = true;
                    break;
                }
            }

            if (!found) {
                valid = false;
                std.log.debug("Chunk free list integrity check failed: chunk on free list 0x{x:08} is not in the chunk list\n", .{@intFromPtr(chunk)});
            }

            chunk.previous_size &= ~@as(usize, 0x01);

            chunks = chunk.next_free;
        }
    }

    // Make sure any chunk with the low order bit of the previous size set also has the
    // low order bit of the size set.

    //  Unmark each chunk here by clearing the low order bit of the previous size to 0.

    address = self.low_boundary;
    while (address < self.high_boundary) {
        const chunk: *Chunk = @ptrFromInt(address);
        if (chunk.previous_size & 0x01 != 0 and chunk._size & 0x01 == 0) {
            valid = false;
            std.log.debug("Chunk integrity check failed: Chunk 0x{x:08} in-use chunk marked as free\n", .{@intFromPtr(chunk)});
        }
        chunk.previous_size &= ~@as(usize, 0x01);
        address += chunk.size();
    }

    return valid;
}
