const std = @import("std");
const assert = std.debug.assert;
const mem = std.mem;
const testing = std.testing;

/// A structure with an array and a length, that can be used as a slice.
///
/// Useful to pass around small arrays whose exact size is only known at
/// runtime, but whose maximum size is known at comptime, without requiring
/// an `Allocator`.
///
/// ```zig
/// var actual_size = 32;
/// var a = try BoundedArray(u8, 64).init(actual_size);
/// var slice = a.slice(); // a slice of the 64-byte array
/// var a_clone = a; // creates a copy - the structure doesn't use any internal pointers
/// ```
pub fn BoundedArray(comptime T: type, comptime buffer_capacity: usize) type {
    return BoundedArrayAligned(T, @alignOf(T), buffer_capacity);
}

/// A structure with an array, length and alignment, that can be used as a
/// slice.
///
/// Useful to pass around small explicitly-aligned arrays whose exact size is
/// only known at runtime, but whose maximum size is known at comptime, without
/// requiring an `Allocator`.
/// ```zig
//  var a = try BoundedArrayAligned(u8, 16, 2).init(0);
//  try a.append(255);
//  try a.append(255);
//  const b = @ptrCast(*const [1]u16, a.const_slice().ptr);
//  try testing.expectEqual(@as(u16, 65535), b[0]);
/// ```
pub fn BoundedArrayAligned(
    comptime T: type,
    comptime alignment: u29,
    comptime buffer_capacity: usize,
) type {
    return struct {
        const Self = @This();
        buffer: [buffer_capacity]T align(alignment) = undefined,
        len: usize = 0,

        /// Set the actual length of the slice.
        /// Returns error.Overflow if it exceeds the length of the backing array.
        pub fn init(len: usize) error{Overflow}!Self {
            if (len > buffer_capacity) return error.Overflow;
            return Self{ .len = len };
        }

        /// View the internal array as a slice whose size was previously set.
        pub fn slice(self: anytype) switch (@TypeOf(&self.buffer)) {
            *align(alignment) [buffer_capacity]T => []align(alignment) T,
            *align(alignment) const [buffer_capacity]T => []align(alignment) const T,
            else => unreachable,
        } {
            return self.buffer[0..self.len];
        }

        /// View the internal array as a constant slice whose size was previously set.
        pub fn const_slice(self: *const Self) []align(alignment) const T {
            return self.slice();
        }

        /// Adjust the slice's length to `len`.
        /// Does not initialize added items if any.
        pub fn resize(self: *Self, len: usize) error{Overflow}!void {
            if (len > buffer_capacity) return error.Overflow;
            self.len = len;
        }

        /// Remove all elements from the slice.
        pub fn clear(self: *Self) void {
            self.len = 0;
        }

        /// Copy the content of an existing slice.
        pub fn from_slice(m: []const T) error{Overflow}!Self {
            var list = try init(m.len);
            @memcpy(list.slice(), m);
            return list;
        }

        /// Return the element at index `i` of the slice.
        pub fn get(self: Self, i: usize) T {
            return self.const_slice()[i];
        }

        /// Set the value of the element at index `i` of the slice.
        pub fn set(self: *Self, i: usize, item: T) void {
            self.slice()[i] = item;
        }

        /// Return the maximum length of a slice.
        pub fn capacity(self: Self) usize {
            return self.buffer.len;
        }

        /// Check that the slice can hold at least `additional_count` items.
        pub fn ensure_unused_capacity(self: Self, additional_count: usize) error{Overflow}!void {
            if (self.len + additional_count > buffer_capacity) {
                return error.Overflow;
            }
        }

        /// Increase length by 1, returning a pointer to the new item.
        pub fn add_one(self: *Self) error{Overflow}!*T {
            try self.ensure_unused_capacity(1);
            return self.add_one_assume_capacity();
        }

        /// Increase length by 1, returning pointer to the new item.
        /// Asserts that there is space for the new item.
        pub fn add_one_assume_capacity(self: *Self) *T {
            assert(self.len < buffer_capacity);
            self.len += 1;
            return &self.slice()[self.len - 1];
        }

        /// Resize the slice, adding `n` new elements, which have `undefined` values.
        /// The return value is a pointer to the array of uninitialized elements.
        pub fn add_many_as_array(self: *Self, comptime n: usize) error{Overflow}!*align(alignment) [n]T {
            const prev_len = self.len;
            try self.resize(self.len + n);
            return self.slice()[prev_len..][0..n];
        }

        /// Resize the slice, adding `n` new elements, which have `undefined` values.
        /// The return value is a slice pointing to the uninitialized elements.
        pub fn add_many_as_slice(self: *Self, n: usize) error{Overflow}![]align(alignment) T {
            const prev_len = self.len;
            try self.resize(self.len + n);
            return self.slice()[prev_len..][0..n];
        }

        /// Remove and return the last element from the slice, or return `null` if the slice is empty.
        pub fn pop(self: *Self) ?T {
            if (self.len == 0) return null;
            const item = self.get(self.len - 1);
            self.len -= 1;
            return item;
        }

        /// Return a slice of only the extra capacity after items.
        /// This can be useful for writing directly into it.
        /// Note that such an operation must be followed up with a
        /// call to `resize()`
        pub fn unused_capacity_slice(self: *Self) []align(alignment) T {
            return self.buffer[self.len..];
        }

        /// Insert `item` at index `i` by moving `slice[n .. slice.len]` to make room.
        /// This operation is O(N).
        pub fn insert(
            self: *Self,
            i: usize,
            item: T,
        ) error{Overflow}!void {
            if (i > self.len) {
                return error.Overflow;
            }
            _ = try self.add_one();
            var s = self.slice();
            mem.copyBackwards(T, s[i + 1 .. s.len], s[i .. s.len - 1]);
            self.buffer[i] = item;
        }

        /// Insert slice `items` at index `i` by moving `slice[i .. slice.len]` to make room.
        /// This operation is O(N).
        pub fn insert_slice(self: *Self, i: usize, items: []const T) error{Overflow}!void {
            try self.ensure_unused_capacity(items.len);
            self.len += items.len;
            mem.copyBackwards(T, self.slice()[i + items.len .. self.len], self.const_slice()[i .. self.len - items.len]);
            @memcpy(self.slice()[i..][0..items.len], items);
        }

        /// Replace range of elements `slice[start..][0..len]` with `new_items`.
        /// Grows slice if `len < new_items.len`.
        /// Shrinks slice if `len > new_items.len`.
        pub fn replace_range(
            self: *Self,
            start: usize,
            len: usize,
            new_items: []const T,
        ) error{Overflow}!void {
            const after_range = start + len;
            var range = self.slice()[start..after_range];

            if (range.len == new_items.len) {
                @memcpy(range[0..new_items.len], new_items);
            } else if (range.len < new_items.len) {
                const first = new_items[0..range.len];
                const rest = new_items[range.len..];
                @memcpy(range[0..first.len], first);
                try self.insert_slice(after_range, rest);
            } else {
                @memcpy(range[0..new_items.len], new_items);
                const after_subrange = start + new_items.len;
                for (self.const_slice()[after_range..], 0..) |item, i| {
                    self.slice()[after_subrange..][i] = item;
                }
                self.len -= len - new_items.len;
            }
        }

        /// Extend the slice by 1 element.
        pub fn append(self: *Self, item: T) error{Overflow}!void {
            const new_item_ptr = try self.add_one();
            new_item_ptr.* = item;
        }

        /// Extend the slice by 1 element, asserting the capacity is already
        /// enough to store the new item.
        pub fn append_assume_capacity(self: *Self, item: T) void {
            const new_item_ptr = self.add_one_assume_capacity();
            new_item_ptr.* = item;
        }

        /// Remove the element at index `i`, shift elements after index
        /// `i` forward, and return the removed element.
        /// Asserts the slice has at least one item.
        /// This operation is O(N).
        pub fn ordered_remove(self: *Self, i: usize) T {
            const newlen = self.len - 1;
            if (newlen == i) return self.pop().?;
            const old_item = self.get(i);
            for (self.slice()[i..newlen], 0..) |*b, j| b.* = self.get(i + 1 + j);
            self.set(newlen, undefined);
            self.len = newlen;
            return old_item;
        }

        /// Remove the element at the specified index and return it.
        /// The empty slot is filled from the end of the slice.
        /// This operation is O(1).
        pub fn swap_remove(self: *Self, i: usize) T {
            if (self.len - 1 == i) return self.pop().?;
            const old_item = self.get(i);
            self.set(i, self.pop().?);
            return old_item;
        }

        /// Append the slice of items to the slice.
        pub fn append_slice(self: *Self, items: []const T) error{Overflow}!void {
            try self.ensure_unused_capacity(items.len);
            self.append_slice_assume_capacity(items);
        }

        /// Append the slice of items to the slice, asserting the capacity is already
        /// enough to store the new items.
        pub fn append_slice_assume_capacity(self: *Self, items: []const T) void {
            const old_len = self.len;
            self.len += items.len;
            @memcpy(self.slice()[old_len..][0..items.len], items);
        }

        /// Append a value to the slice `n` times.
        /// Allocates more memory as necessary.
        pub fn append_n_times(self: *Self, value: T, n: usize) error{Overflow}!void {
            const old_len = self.len;
            try self.resize(old_len + n);
            @memset(self.slice()[old_len..self.len], value);
        }

        /// Append a value to the slice `n` times.
        /// Asserts the capacity is enough.
        pub fn append_n_times_assume_capacity(self: *Self, value: T, n: usize) void {
            const old_len = self.len;
            self.len += n;
            assert(self.len <= buffer_capacity);
            @memset(self.slice()[old_len..self.len], value);
        }

        pub const Writer = if (T != u8)
            @compileError("The Writer interface is only defined for BoundedArray(u8, ...) " ++
                "but the given type is BoundedArray(" ++ @typeName(T) ++ ", ...)")
        else
            struct {
                ba: *Self,
                interface: std.Io.Writer,
                //std.io.Writer(*Self, error{Overflow}, appendWrite);
            };

        /// Initializes a writer which will write into the array.
        pub fn writer(self: *Self) Writer {
            return .{
                .ba = self,
                .interface = .{
                    .vtable = &.{
                        .drain = drain,
                    },
                    .buffer = &.{},
                },
            };
        }

        fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
            _ = splat;
            const w: *Writer = @fieldParentPtr("interface", io_w);
            var ret: usize = 0;
            for (data) |d| {
                const n = w.ba.append_write(d) catch return error.WriteFailed;
                ret += n;
                if (n != d.len)
                    break;
            }

            return ret;
        }

        /// Same as `append_slice` except it returns the number of bytes written, which is always the same
        /// as `m.len`. The purpose of this function existing is to match `std.io.Writer` API.
        fn append_write(self: *Self, m: []const u8) error{Overflow}!usize {
            try self.append_slice(m);
            return m.len;
        }
    };
}

test BoundedArray {
    var a = try BoundedArray(u8, 64).init(32);

    try testing.expectEqual(a.capacity(), 64);
    try testing.expectEqual(a.slice().len, 32);
    try testing.expectEqual(a.const_slice().len, 32);

    try a.resize(48);
    try testing.expectEqual(a.len, 48);

    const x = [_]u8{1} ** 10;
    a = try BoundedArray(u8, 64).from_slice(&x);
    try testing.expectEqualSlices(u8, &x, a.const_slice());

    var a2 = a;
    try testing.expectEqualSlices(u8, a.const_slice(), a2.const_slice());
    a2.set(0, 0);
    try testing.expect(a.get(0) != a2.get(0));

    try testing.expectError(error.Overflow, a.resize(100));
    try testing.expectError(error.Overflow, BoundedArray(u8, x.len - 1).from_slice(&x));

    try a.resize(0);
    try a.ensure_unused_capacity(a.capacity());
    (try a.add_one()).* = 0;
    try a.ensure_unused_capacity(a.capacity() - 1);
    try testing.expectEqual(a.len, 1);

    const uninitialized = try a.add_many_as_array(4);
    try testing.expectEqual(uninitialized.len, 4);
    try testing.expectEqual(a.len, 5);

    try a.append(0xff);
    try testing.expectEqual(a.len, 6);
    try testing.expectEqual(a.pop(), 0xff);

    a.append_assume_capacity(0xff);
    try testing.expectEqual(a.len, 6);
    try testing.expectEqual(a.pop(), 0xff);

    try a.resize(1);
    try testing.expectEqual(a.pop(), 0);
    try testing.expectEqual(a.pop(), null);
    var unused = a.unused_capacity_slice();
    @memset(unused[0..8], 2);
    unused[8] = 3;
    unused[9] = 4;
    try testing.expectEqual(unused.len, a.capacity());
    try a.resize(10);

    try a.insert(5, 0xaa);
    try testing.expectEqual(a.len, 11);
    try testing.expectEqual(a.get(5), 0xaa);
    try testing.expectEqual(a.get(9), 3);
    try testing.expectEqual(a.get(10), 4);

    try a.insert(11, 0xbb);
    try testing.expectEqual(a.len, 12);
    try testing.expectEqual(a.pop(), 0xbb);

    try a.append_slice(&x);
    try testing.expectEqual(a.len, 11 + x.len);

    try a.append_n_times(0xbb, 5);
    try testing.expectEqual(a.len, 11 + x.len + 5);
    try testing.expectEqual(a.pop(), 0xbb);

    a.append_n_times_assume_capacity(0xcc, 5);
    try testing.expectEqual(a.len, 11 + x.len + 5 - 1 + 5);
    try testing.expectEqual(a.pop(), 0xcc);

    try testing.expectEqual(a.len, 29);
    try a.replace_range(1, 20, &x);
    try testing.expectEqual(a.len, 29 + x.len - 20);

    try a.insert_slice(0, &x);
    try testing.expectEqual(a.len, 29 + x.len - 20 + x.len);

    try a.replace_range(1, 5, &x);
    try testing.expectEqual(a.len, 29 + x.len - 20 + x.len + x.len - 5);

    try a.append(10);
    try testing.expectEqual(a.pop(), 10);

    try a.append(20);
    const removed = a.ordered_remove(5);
    try testing.expectEqual(removed, 1);
    try testing.expectEqual(a.len, 34);

    a.set(0, 0xdd);
    a.set(a.len - 1, 0xee);
    const swapped = a.swap_remove(0);
    try testing.expectEqual(swapped, 0xdd);
    try testing.expectEqual(a.get(0), 0xee);

    const added_slice = try a.add_many_as_slice(3);
    try testing.expectEqual(added_slice.len, 3);
    try testing.expectEqual(a.len, 36);

    while (a.pop()) |_| {}
    var buffer_writer = a.writer();
    const w = &buffer_writer.interface;
    const s = "hello, this is a test string";
    try w.writeAll(s);
    try testing.expectEqualStrings(s, a.const_slice());
}

test "BoundedArrayAligned" {
    var a = try BoundedArrayAligned(u8, 16, 4).init(0);
    try a.append(0);
    try a.append(0);
    try a.append(255);
    try a.append(255);

    const b = @as(*const [2]u16, @ptrCast(a.const_slice().ptr));
    try testing.expectEqual(@as(u16, 0), b[0]);
    try testing.expectEqual(@as(u16, 65535), b[1]);
}
