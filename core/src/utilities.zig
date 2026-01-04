const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig.zig");

/// Fills .bss with zeroes and *maybe* copies .data from flash into ram. May be
/// called by the cpu module at startup.
pub inline fn initialize_system_memories(which: enum {
    /// Decides between .all and .bss_only based on whether we are in a RAM
    /// image or not. `initialize_system_memories(.auto)` is equivalent to:
    /// ```zig
    /// if (!microzig.config.ram_image) {
    ///     microzig.utilities.initialize_system_memories(.all);
    /// } else {
    ///     microzig.utilities.initialize_system_memories(.bss_only);
    /// }
    /// ```
    pub const auto: @This() = if (!microzig.config.ram_image) .all else .bss_only;

    all,
    bss_only,
}) void {

    // Contains references to the microzig .data and .bss sections, also
    // contains the initial load address for .data if it is in flash.
    const sections = struct {
        extern var microzig_data_start: anyopaque;
        extern var microzig_data_end: anyopaque;
        extern var microzig_bss_start: anyopaque;
        extern var microzig_bss_end: anyopaque;
        extern const microzig_data_load_start: anyopaque;
    };

    // fill .bss with zeroes
    {
        const bss_start: [*]u8 = @ptrCast(&sections.microzig_bss_start);
        const bss_end: [*]u8 = @ptrCast(&sections.microzig_bss_end);
        const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss_start);

        @memset(bss_start[0..bss_len], 0);
    }

    // load .data from flash
    if (which != .bss_only) {
        const data_start: [*]u8 = @ptrCast(&sections.microzig_data_start);
        const data_end: [*]u8 = @ptrCast(&sections.microzig_data_end);
        const data_len = @intFromPtr(data_end) - @intFromPtr(data_start);
        const data_src: [*]const u8 = @ptrCast(&sections.microzig_data_load_start);

        @memcpy(data_start[0..data_len], data_src[0..data_len]);
    }
}

/// A helper class that allows operating on a slice of slices
/// with similar operations to those of a slice.
pub fn SliceVector(comptime Slice: type) type {
    const type_info = @typeInfo(Slice);
    if (type_info != .pointer)
        @compileError("Slice must have a slice type!");
    if (type_info.pointer.size != .slice)
        @compileError("Slice must have a slice type!");

    const item_ptr_info: std.builtin.Type = .{
        .pointer = .{
            .alignment = @min(type_info.pointer.alignment, @alignOf(type_info.pointer.child)),
            .size = .one,
            .child = type_info.pointer.child,
            .address_space = type_info.pointer.address_space,
            .is_const = type_info.pointer.is_const,
            .is_volatile = type_info.pointer.is_volatile,
            .is_allowzero = type_info.pointer.is_allowzero,
            .sentinel_ptr = null,
        },
    };

    return struct {
        const Vector = @This();

        pub const Item = type_info.pointer.child;
        pub const ItemPtr = @Type(item_ptr_info);

        /// The slice of slices. The first and the last slice of this slice must
        /// be non-empty or the slice-of-slices must be empty.
        ///
        /// Use `init()` to ensure this.
        slices: []const Slice,

        /// Initializes a new vector with the given slice of slices.
        /// Optimizes the `slices` array by removing all empty slices from the start and the end.
        pub fn init(slices: []const Slice) Vector {
            var view = slices;

            // trim start:
            while (view.len > 0) {
                if (view[0].len > 0)
                    break;
                view = view[1..];
            }

            // trail end:
            while (view.len > 0) {
                if (view[view.len - 1].len > 0)
                    break;
                view = view[0 .. view.len - 1];
            }

            if (view.len > 0) {
                std.debug.assert(view[0].len > 0);
                std.debug.assert(view[view.len - 1].len > 0);
            }

            return .{ .slices = view };
        }

        /// Returns the total length of all contained slices.
        pub fn size(vec: Vector) usize {
            var len: usize = 0;
            for (vec.slices) |slice| {
                len += slice.len;
            }
            return len;
        }

        ///
        /// Returns the element at `index`.
        ///
        /// NOTE: Will iterate over the contained slices.
        pub fn at(vec: Vector, index: usize) Item {
            var offset: usize = 0;
            for (vec.slices) |slice| {
                const rel = index - offset;
                if (rel < slice.len)
                    return slice[rel];
                offset += slice.len;
            }
            @panic("index out of bounds");
        }

        /// Returns an iterator for the slices.
        pub fn iterator(vec: Vector) Iterator {
            return .{ .slices = vec.slices };
        }

        pub const Iterator = struct {
            slices: []const Slice,
            slice_index: usize = 0,
            slice_offset: usize = 0,
            element_index: usize = 0,

            // Advances the iterator by a single element.
            pub fn next_element(iter: *Iterator) ?Element {
                const ptr = iter.next_element_ptr() orelse return null;
                return .{
                    .last = ptr.last,
                    .first = ptr.first,
                    .index = ptr.index,
                    .value = ptr.value_ptr.*,
                };
            }

            // Advances the iterator by a single element.
            pub fn next_element_ptr(iter: *Iterator) ?ElementPtr {
                if (iter.slice_index >= iter.slices.len)
                    return null;

                var current_slice = iter.slices[iter.slice_index];
                std.debug.assert(iter.slice_offset < current_slice.len);

                const first = (iter.slice_index == 0) and (iter.slice_offset == 0);
                const last = (iter.slice_index == (iter.slices.len - 1)) and (iter.slice_offset == (iter.slices[iter.slices.len - 1].len - 1));

                const element: ElementPtr = .{
                    .first = first,
                    .last = last,
                    .index = iter.element_index,
                    .value_ptr = &current_slice[iter.slice_offset],
                };

                iter.element_index += 1;
                iter.slice_offset += 1;
                while (iter.slice_offset >= current_slice.len) {
                    iter.slice_offset = 0;
                    iter.slice_index += 1;

                    if (iter.slice_index >= iter.slices.len) {
                        break;
                    }
                    current_slice = iter.slices[iter.slice_index];
                }

                return element;
            }

            /// Returns the next available chunk of data.
            ///
            /// If `max_length` is given, that chunk never exceeds `max_length` elements.
            pub fn next_chunk(iter: *Iterator, max_length: ?usize) ?Slice {
                if (iter.slice_index >= iter.slices.len)
                    return null;

                var current_slice = iter.slices[iter.slice_index];
                std.debug.assert(iter.slice_offset < current_slice.len);

                const rest = current_slice[iter.slice_offset..];

                const chunk: Slice = if (max_length) |limit|
                    rest[0..@min(rest.len, limit)]
                else
                    rest;

                iter.slice_offset += chunk.len;
                std.debug.assert(iter.slice_offset <= current_slice.len);

                while (iter.slice_offset == current_slice.len) {
                    iter.slice_offset = 0;
                    iter.slice_index += 1;
                    if (iter.slice_index >= iter.slices.len)
                        break;
                    current_slice = iter.slices[iter.slice_index];
                }

                return chunk;
            }

            pub const Element = struct {
                first: bool,
                last: bool,
                index: usize,
                value: Item,
            };

            pub const ElementPtr = struct {
                first: bool,
                last: bool,
                index: usize,
                value_ptr: ItemPtr,
            };
        };
    };
}

pub fn max_enum_tag(T: type) @typeInfo(T).@"enum".tag_type {
    if (@typeInfo(T) != .@"enum") @compileError("expected an enum type");

    const tag_type = @typeInfo(T).@"enum".tag_type;
    var max_tag: tag_type = std.math.minInt(tag_type);
    for (@typeInfo(T).@"enum".fields) |field| {
        if (field.value > max_tag) {
            max_tag = field.value;
        }
    }
    return max_tag;
}

pub fn GenerateInterruptEnum(TagType: type) type {
    if (@typeInfo(TagType) != .int) @compileError("expected an int type");

    if (microzig.chip.interrupts.len == 0) return enum {};

    var fields: [microzig.chip.interrupts.len]std.builtin.Type.EnumField = undefined;

    for (&fields, microzig.chip.interrupts) |*field, interrupt| {
        field.* = .{
            .name = interrupt.name,
            .value = interrupt.index,
        };
    }

    return @Type(.{ .@"enum" = .{
        .tag_type = TagType,
        .fields = &fields,
        .decls = &.{},
        .is_exhaustive = true,
    } });
}

pub const Source = struct {
    InterruptEnum: type,
    HandlerFn: type,
};

pub fn GenerateInterruptOptions(sources: []const Source) type {
    var ret_fields: []const std.builtin.Type.StructField = &.{};

    for (sources) |source| {
        if (@typeInfo(source.InterruptEnum) != .@"enum") @compileError("expected an enum type");

        for (@typeInfo(source.InterruptEnum).@"enum".fields) |enum_field| {
            ret_fields = ret_fields ++ .{std.builtin.Type.StructField{
                .name = enum_field.name,
                .type = ?source.HandlerFn,
                .default_value_ptr = @as(*const anyopaque, @ptrCast(&@as(?source.HandlerFn, null))),
                .is_comptime = false,
                .alignment = @alignOf(?source.HandlerFn),
            }};
        }
    }

    return @Type(.{
        .@"struct" = .{
            .layout = .auto,
            .fields = ret_fields,
            .decls = &.{},
            .is_tuple = false,
        },
    });
}

test SliceVector {
    const vec = SliceVector([]const u8).init(&.{
        "Hello,",
        " ",
        "World!",
    });

    try std.testing.expectEqual(u8, @TypeOf(vec).Item);
    try std.testing.expectEqual(*const u8, @TypeOf(vec).ItemPtr);

    try std.testing.expectEqual(13, vec.size());

    for ("Hello, World!", 0..) |char, index| {
        try std.testing.expectEqual(char, vec.at(index));
    }
}

test "SliceVector.init" {
    const vec_strip_head = SliceVector([]const u8).init(&.{
        &.{},
        &.{},
        &.{},
        &.{},
        "hello",
    });
    try std.testing.expectEqual(1, vec_strip_head.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_head.slices[0]);

    const vec_strip_tail = SliceVector([]const u8).init(&.{
        "hello",
        &.{},
        &.{},
        &.{},
        &.{},
    });
    try std.testing.expectEqual(1, vec_strip_tail.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_tail.slices[0]);

    const vec_strip_both = SliceVector([]const u8).init(&.{
        &.{},
        &.{},
        "hello",
        &.{},
        &.{},
    });
    try std.testing.expectEqual(1, vec_strip_both.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_both.slices[0]);

    const vec_keep_center = SliceVector([]const u8).init(&.{
        &.{},
        "hello",
        &.{},
        &.{},
        "world",
        &.{},
    });
    try std.testing.expectEqual(4, vec_keep_center.slices.len);
    try std.testing.expectEqualStrings("hello", vec_keep_center.slices[0]);
    try std.testing.expectEqualStrings("", vec_keep_center.slices[1]);
    try std.testing.expectEqualStrings("", vec_keep_center.slices[2]);
    try std.testing.expectEqualStrings("world", vec_keep_center.slices[3]);
}

test "SliceVector.iterator" {
    const vec = SliceVector([]const u8).init(&.{
        &.{},
        &.{},
        "Hello,",
        &.{},
        " ",
        &.{},
        "World!",
        &.{},
        &.{},
    });

    const expected = "Hello, World!";

    {
        var index: usize = 0;
        var iter = vec.iterator();
        while (iter.next_element()) |element| : (index += 1) {
            try std.testing.expectEqual(index, element.index);
            try std.testing.expectEqual((index == 0), element.first);
            try std.testing.expectEqual((index == expected.len - 1), element.last);
            try std.testing.expectEqual(expected[index], element.value);
        }
    }
    {
        var index: usize = 0;
        var iter = vec.iterator();
        while (iter.next_element_ptr()) |element| : (index += 1) {
            try std.testing.expectEqual(index, element.index);
            try std.testing.expectEqual((index == 0), element.first);
            try std.testing.expectEqual((index == expected.len - 1), element.last);
            try std.testing.expectEqual(expected[index], element.value_ptr.*);
        }
    }
}

test "SliceVector.iterator (mutable)" {
    var buffer: [8]u8 = undefined;
    const expected = "01234567";

    const vec = SliceVector([]u8).init(&.{
        &.{},
        &.{},
        buffer[0..3],
        &.{},
        buffer[3..5],
        &.{},
        buffer[5..8],
        &.{},
        &.{},
    });

    {
        var index: usize = 0;
        var iter = vec.iterator();
        while (iter.next_element_ptr()) |element| : (index += 1) {
            element.value_ptr.* = expected[index];
        }
    }

    try std.testing.expectEqualStrings(expected, &buffer);
}

test "SliceVector.Iterator.next_chunk" {
    const vec = SliceVector([]const u8).init(&.{
        &.{},
        &.{},
        "Hello,",
        &.{},
        "0123456789",
        &.{},
        " ",
        &.{},
        "World!",
        &.{},
        &.{},
    });

    // Unlimited:
    {
        const expected = [_][]const u8{
            "Hello,",
            "0123456789",
            " ",
            "World!",
        };
        var index: usize = 0;
        var iter = vec.iterator();
        while (iter.next_chunk(null)) |chunk| : (index += 1) {
            try std.testing.expectEqualStrings(expected[index], chunk);
        }
    }

    // Limited:
    {
        const expected = [_][]const u8{
            "Hello",
            ",",
            "01234",
            "56789",
            " ",
            "World",
            "!",
        };
        var index: usize = 0;
        var iter = vec.iterator();
        while (iter.next_chunk(5)) |chunk| : (index += 1) {
            try std.testing.expectEqualStrings(expected[index], chunk);
        }
    }
}

pub fn dump_stack_trace(trace: *std.builtin.StackTrace) usize {
    const frame_count = @min(trace.index, trace.instruction_addresses.len);

    var frame_index: usize = 0;
    var frames_left: usize = frame_count;
    while (frames_left != 0) : ({
        frames_left -= 1;
        frame_index = (frame_index + 1) % trace.instruction_addresses.len;
    }) {
        const address = trace.instruction_addresses[frame_index];
        std.log.err("{d: >3}: 0x{X:0>8}", .{ frame_index, address });
    }

    return frame_count;
}

pub fn get_end_of_stack() *const anyopaque {
    if (microzig.config.end_of_stack.address) |address| {
        return @ptrFromInt(address);
    } else if (microzig.config.end_of_stack.symbol_name) |sym_name| {
        return @extern(*const anyopaque, .{ .name = sym_name });
    } else {
        @panic("expected at least one of end_of_stack.address or end_of_stack.symbol_name to be set");
    }
}

/// A naive circular buffer implementation. At time of writing, it's intended
/// to fill in where the deleted std.fifo.LinearFifo was used, so the API might
/// seem unfinished.
pub fn CircularBuffer(comptime T: type, comptime len: usize) type {
    return struct {
        items: [len]T,
        start: usize,
        end: usize,
        full: bool,

        const Self = @This();
        pub const empty: Self = .{
            .items = undefined,
            .start = 0,
            .end = 0,
            .full = false,
        };

        fn assert_valid(buffer: *const Self) void {
            assert(buffer.start < len);
            assert(buffer.end < len);
        }

        pub fn get_writable_len(buffer: *const Self) usize {
            buffer.assert_valid();
            return len - buffer.get_readable_len();
        }

        pub fn is_empty(buffer: *const Self) bool {
            return !buffer.full and (buffer.start == buffer.end);
        }

        pub fn get_readable_len(buffer: *const Self) usize {
            buffer.assert_valid();
            if (buffer.full)
                return len;
            return if (buffer.start <= buffer.end)
                buffer.end - buffer.start
            else
                len - buffer.start + buffer.end;
        }

        fn increment_end(buffer: *Self) void {
            increment(&buffer.end);
        }

        fn increment_start(buffer: *Self) void {
            increment(&buffer.start);
        }

        fn increment(counter: *usize) void {
            if (counter.* >= (len - 1)) {
                counter.* = 0;
            } else {
                counter.* += 1;
            }
        }

        pub fn write_assume_capacity(buffer: *Self, values: []const T) void {
            buffer.assert_valid();
            defer buffer.assert_valid();

            var first = true;
            for (values) |value| {
                if (first) {
                    first = false;
                } else {
                    assert(buffer.start != buffer.end);
                }

                buffer.items[buffer.end] = value;
                buffer.increment_end();
            }

            if (buffer.start == buffer.end)
                buffer.full = true;
        }

        pub fn read(buffer: *Self, out: []u8) usize {
            buffer.assert_valid();
            defer buffer.assert_valid();

            var count: usize = 0;
            while (!buffer.is_empty() and count < out.len) {
                out[count] = buffer.pop().?;
                count += 1;
            }

            return count;
        }

        pub fn write(buffer: *Self, data: []const u8) error{Full}!void {
            buffer.assert_valid();
            defer buffer.assert_valid();

            for (data) |d| {
                if (buffer.full)
                    return error.Full;

                buffer.items[buffer.end] = d;
                buffer.increment_end();
            }
        }

        /// Pop item from front of buffer. Return null if empty
        pub fn pop(buffer: *Self) ?T {
            buffer.assert_valid();
            defer buffer.assert_valid();

            if (buffer.is_empty())
                return null;

            defer {
                buffer.increment_start();
                if (buffer.full) {
                    buffer.full = false;
                }
            }
            return buffer.items[buffer.start];
        }

        pub fn reset(buffer: *Self) void {
            buffer.assert_valid();
            defer buffer.assert_valid();

            buffer.start = 0;
            buffer.end = 0;
            buffer.full = false;
        }
    };
}

test "CircularBuffer bounds" {
    const expectEqual = std.testing.expectEqual;
    const bufsize: usize = 64;
    const FIFO = CircularBuffer(u8, bufsize);
    var fifo: FIFO = .empty;
    try expectEqual(bufsize, fifo.get_writable_len());
    const one_data: [1]u8 = .{42};
    try fifo.write(one_data[0..]);
    try expectEqual(bufsize - 1, fifo.get_writable_len());

    var big_data: [100]u8 = undefined;
    @memset(big_data[0..], 42);

    const maybe_err = fifo.write(big_data[0..]);

    try std.testing.expectError(error.Full, maybe_err);
}
