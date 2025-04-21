const std = @import("std");
const microzig = @import("microzig.zig");

const Alignment = std.mem.Alignment;

/// The number of free lists we maintain.
const free_list_count: usize = 6;

/// The free lists
var free_lists: [free_list_count]?*Chunk = undefined;

var low_boundary: usize = undefined;
var high_boundary: usize = undefined;

var mutex: microzig.hal.mutex.Mutex = .{};

/// Set up the initial heap computing a low and high boundary and adding all
/// available memory to the free list as a single chunk.
///
/// Parameters:
/// - `heap`: The heap to allocate from.
pub fn initialize(heap: []u8) void {
    // Get the low and high boundaries aligned to match Chunk.
    low_boundary = Chunk.alignment.forward(@intFromPtr(heap.ptr));
    high_boundary = Chunk.alignment.backward(@intFromPtr(heap.ptr + heap.len) - Chunk.header_size);

    // Create the initial chunk with all the space as free memory.

    const init_chunk: *Chunk = @ptrFromInt(low_boundary);

    init_chunk.previous_size = 0;
    init_chunk._size = high_boundary - low_boundary;
    init_chunk.next_free = null;
    init_chunk.prior_free = null;

    free_lists[freeIndexForSize(init_chunk.size())] = init_chunk;
}

/// Returns the total amount of free memory in the heap.
pub fn freeHeap() usize {
    mutex.lock();
    defer mutex.unlock();

    var total: usize = 0;
    for (0..free_list_count) |i| {
        var c = free_lists[i];
        while (c) |chunk| {
            total += chunk.size() - Chunk.header_size;
            c = chunk.next_free;
        }
    }
    return total;
}

/// Returns the largest length that can be currently allocated.
pub fn maxAllocSize() usize {
    mutex.lock();
    defer mutex.unlock();

    var maximum: usize = 0;
    for (0..free_list_count) |i| {
        var c = free_lists[i];
        while (c) |chunk| {
            maximum = @max(maximum, chunk.size() - Chunk.header_size);
            c = chunk.next_free;
        }
    }
    return maximum;
}

/// The allocator instance.  This allocator can be used in a multicore environment,
/// and can be safely used in an interrupt service routine.
pub const allocator: std.mem.Allocator = .{
    .ptr = undefined,
    .vtable = &vtable,
};

/// The allocator's virtual table
const vtable: std.mem.Allocator.VTable =
    .{
        .alloc = alloc,
        .resize = resize,
        .remap = std.mem.Allocator.noRemap,
        .free = free,
    };

/// Allocate memory
///
/// Parameters:
/// - `len`      : The length of the memory to allocate
/// - `alignment`: The alignment of the memory to allocate (log2 of byte alignment)
///
/// Returns:
/// - `?[*]u8`: A pointer to the allocated memory, or null if insufficient memory is available
fn alloc(_: *anyopaque, len: usize, alignment: Alignment, _: usize) ?[*]u8 {
    mutex.lock();
    defer mutex.unlock();

    // std.log.debug( "\n *** Allocating {} bytes of memory with alignment {d}\n", .{ len, alignment.toByteUnits() } );

    var free_index = freeIndexForSize(len + Chunk.header_size);

    while (free_index < free_list_count) {
        var maybe_chunk = free_lists[free_index];

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
                    data_addr = alignment.forward(data_addr);
                    offset += alignment.toByteUnits();
                }

                available -= offset;
                trim_leading = true;
            }

            if (available >= len) {
                // OK, We have enough space to fit the requested memory, unlink the chunk.

                c.unlink();
                var our_chunk = c;

                // Trim off leading bytes
                if (trim_leading) {
                    our_chunk = @ptrCast(@alignCast(@as(*u8, @ptrFromInt(data_addr - Chunk.header_size))));
                    our_chunk.previous_size = data_addr - @intFromPtr(c.data());
                    our_chunk._size = (available + Chunk.header_size) | 0x01;

                    c._size = our_chunk.previous_size;
                    c.combineAndFree();
                }

                // See if there is trailing space that we can trim off.

                const trim_addr = Chunk.alignment.forward(data_addr + len);
                const next_addr = @intFromPtr(our_chunk.next());

                if (trim_addr + Chunk.min_size < next_addr) {
                    const our_address = @intFromPtr(our_chunk);

                    const our_new_size = trim_addr - our_address;

                    our_chunk._size = our_new_size | 0x01;

                    const trim_chunk: *Chunk = @ptrFromInt(trim_addr);
                    trim_chunk._size = next_addr - trim_addr;
                    trim_chunk.previous_size = our_new_size;

                    trim_chunk.combineAndFree();
                }

                our_chunk._size |= 0x01;
                return our_chunk.data();
            }

            maybe_chunk = c.next_free;
        }

        free_index += 1;
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
fn resize(_: *anyopaque, memory: []u8, _: Alignment, new_len: usize, _: usize) bool {
    mutex.lock();
    defer mutex.unlock();

    // std.log.debug( "\n *** Resizing {} bytes of memory at 0x{x} to {d} bytes\n", .{ @intFromPtr( memory.ptr ), memory.len, new_len } );

    var chunk = Chunk.fromData(memory);

    if (new_len > chunk.size() - Chunk.header_size) {
        // We need to grow the chunk, which means the next chunk must be free.

        if (!chunk.next().isFree()) return false;

        const target_size = new_len + Chunk.header_size;
        const combined_size = chunk.size() + chunk.next().size();

        // We can't grow the chunk if there isn't enough space.

        if (combined_size < target_size) return false;

        // OK, we can grow the chunk.

        chunk.next().unlink();

        chunk._size = target_size;
    }

    // See if there is trailing space that we can trim off.

    const data_addr = @intFromPtr(chunk.data());
    const trim_addr = Chunk.alignment.forward(data_addr + new_len);
    const next_addr = @intFromPtr(chunk.next());

    if (trim_addr + Chunk.min_size < next_addr) {
        const our_address = @intFromPtr(chunk);

        const our_new_size = trim_addr - our_address;

        chunk._size = our_new_size | 0x01;

        const trim_chunk: *Chunk = @ptrFromInt(trim_addr);
        trim_chunk._size = next_addr - trim_addr;
        trim_chunk.previous_size = our_new_size;

        trim_chunk.combineAndFree();
    }

    return true;
}

/// Free memory
///
/// Parameters:
/// - `memory`   : The memory to free
fn free(_: *anyopaque, memory: []u8, _: Alignment, _: usize) void {
    mutex.lock();
    defer mutex.unlock();

    Chunk.fromData(memory).combineAndFree();
}

/// Return the index of the first free list that can hold a chunk of the
/// given size.
///
///  Parameters:
/// - `size`: The size of the chunk
///
/// Returns:
/// - `usize`: The index of the free list
fn freeIndexForSize(size: usize) usize {
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
const Chunk = extern struct {
    previous_size: usize = 0,
    _size: usize = 0, // chunk size and in-use flag
    next_free: ?*Chunk = null,
    prior_free: ?*Chunk = null,

    const header_size = 2 * @sizeOf(usize);
    const min_size = header_size + 2 * @sizeOf(?*Chunk);
    const alignment = Alignment.fromByteUnits(@alignOf(@This()));

    /// Returns a pointer to the chunk that contains the given data.
    pub fn fromData(data_slice: []u8) *Chunk {
        // If we are built with .Debug or .ReleaseSafe, we need to do a slow
        // search to make sure the slice is valid.
        std.debug.assert( blk: {
            var chunk: *Chunk = @ptrFromInt(low_boundary);
            while (@intFromPtr(chunk) < high_boundary) {
                if (data_slice.ptr == chunk.data()) {
                    break :blk true;
                }
                chunk = chunk.next();
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
    /// of the size value is clear. An out of range Chunk pointer will return
    /// not free.
    pub fn isFree(self: *Chunk) bool {
        const addr: usize = @intFromPtr(self);
        if (addr < low_boundary or addr >= high_boundary) return false;

        return (self._size & 0x01) == 0;
    }

    /// Returns a pointer to the previous chunk in the heap.
    /// Note: this can return an out of range Chunk pointer.
    pub fn prior(self: *Chunk) *Chunk {
        return @ptrFromInt(@intFromPtr(self) - self.previous_size);
    }

    /// Returns a pointer to the next chunk in the heap.
    /// Note: this can return an out of range Chunk pointer.
    pub fn next(self: *Chunk) *Chunk {
        return @ptrFromInt(@intFromPtr(self) + self.size());
    }

    /// Combine this chunk with any neighboring free chunks and
    /// add the result to the appropriate free list.
    pub fn combineAndFree(self: *Chunk) void {
        var chunk = self;

        if (chunk.next().isFree()) {
            chunk.next().unlink();
            chunk._size += chunk.next().size();
        }

        if (chunk.prior().isFree()) {
            const our_size = chunk.size();

            chunk = chunk.prior();
            chunk.unlink();
            chunk._size += our_size;
        }

        const free_index = freeIndexForSize(chunk.size());
        const list = free_lists[free_index];

        chunk.prior_free = null;
        chunk.next_free = list;

        chunk._size &= ~@as(usize, 0x01);

        if (list) |head| head.prior_free = chunk;
        free_lists[free_index] = chunk;
    }

    /// Unlink the chunk from the free list.
    pub fn unlink(self: *Chunk) void {
        if (!self.isFree()) return;

        if (self.prior_free) |p| {
            p.next_free = self.next_free;
        } else {
            free_lists[freeIndexForSize(self.size())] = self.next_free;
        }

        if (self.next_free) |n| n.prior_free = self.prior_free;
    }
};
