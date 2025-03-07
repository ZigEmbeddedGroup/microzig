const std = @import("std");
const microzig = @import("microzig.zig");

/// A helper class that allows operating on a slice of slices
/// with similar operations to those of a slice.
pub fn Slice_Vector(comptime Slice: type) type {
    const type_info = @typeInfo(Slice);
    if (type_info != .Pointer)
        @compileError("Slice must have a slice type!");
    if (type_info.Pointer.size != .Slice)
        @compileError("Slice must have a slice type!");

    const item_ptr_info: std.builtin.Type = .{
        .Pointer = .{
            .alignment = @min(type_info.Pointer.alignment, @alignOf(type_info.Pointer.child)),
            .size = .One,
            .child = type_info.Pointer.child,
            .address_space = type_info.Pointer.address_space,
            .is_const = type_info.Pointer.is_const,
            .is_volatile = type_info.Pointer.is_volatile,
            .is_allowzero = type_info.Pointer.is_allowzero,
            .sentinel = null,
        },
    };

    return struct {
        const Vector = @This();

        pub const Item = type_info.Pointer.child;
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

pub fn max_enum_tag(T: type) @typeInfo(T).Enum.tag_type {
    if (@typeInfo(T) != .Enum) @compileError("expected an enum type");

    const tag_type = @typeInfo(T).Enum.tag_type;
    var max_tag: tag_type = std.math.minInt(tag_type);
    for (@typeInfo(T).Enum.fields) |field| {
        if (field.value > max_tag) {
            max_tag = field.value;
        }
    }
    return max_tag;
}

pub fn GenerateInterruptEnum(TagType: type) type {
    if (@typeInfo(TagType) != .Int) @compileError("expected an int type");

    if (microzig.chip.interrupts.len == 0) return enum {};

    var fields: [microzig.chip.interrupts.len]std.builtin.Type.EnumField = undefined;

    for (&fields, microzig.chip.interrupts) |*field, interrupt| {
        field.* = .{
            .name = interrupt.name,
            .value = interrupt.index,
        };
    }

    return @Type(.{ .Enum = .{
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
        if (@typeInfo(source.InterruptEnum) != .Enum) @compileError("expected an enum type");
        if (@typeInfo(source.HandlerFn) != .Fn) @compileError("expected a function type");

        for (@typeInfo(source.InterruptEnum).Enum.fields) |enum_field| {
            ret_fields = ret_fields ++ .{.{
                .name = enum_field.name,
                .type = ?source.HandlerFn,
                .default_value = @as(*const anyopaque, @ptrCast(&@as(?source.HandlerFn, null))),
                .is_comptime = false,
                .alignment = @alignOf(?source.HandlerFn),
            }};
        }
    }

    return @Type(.{
        .Struct = .{
            .layout = .auto,
            .fields = ret_fields,
            .decls = &.{},
            .is_tuple = false,
        },
    });
}

test Slice_Vector {
    const vec = Slice_Vector([]const u8).init(&.{
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

test "Slice_Vector.init" {
    const vec_strip_head = Slice_Vector([]const u8).init(&.{
        &.{},
        &.{},
        &.{},
        &.{},
        "hello",
    });
    try std.testing.expectEqual(1, vec_strip_head.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_head.slices[0]);

    const vec_strip_tail = Slice_Vector([]const u8).init(&.{
        "hello",
        &.{},
        &.{},
        &.{},
        &.{},
    });
    try std.testing.expectEqual(1, vec_strip_tail.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_tail.slices[0]);

    const vec_strip_both = Slice_Vector([]const u8).init(&.{
        &.{},
        &.{},
        "hello",
        &.{},
        &.{},
    });
    try std.testing.expectEqual(1, vec_strip_both.slices.len);
    try std.testing.expectEqualStrings("hello", vec_strip_both.slices[0]);

    const vec_keep_center = Slice_Vector([]const u8).init(&.{
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

test "Slice_Vector.iterator" {
    const vec = Slice_Vector([]const u8).init(&.{
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

test "Slice_Vector.iterator (mutable)" {
    var buffer: [8]u8 = undefined;
    const expected = "01234567";

    const vec = Slice_Vector([]u8).init(&.{
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

test "Slice_Vector.Iterator.next_chunk" {
    const vec = Slice_Vector([]const u8).init(&.{
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
