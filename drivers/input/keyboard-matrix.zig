//!
//! Implements a N*M keyboard matrix that will be scanned in column-major order.
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Keyboard_Matrix_Options = struct {
    /// How many rows does the keyboard matrix have?
    rows: usize,

    /// How many columns does the keyboard matrix have?
    columns: usize,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

/// Keyboard matrix implementation via GPIOs that scans columns and checks rows.
///
/// Will use the columns as matrix drivers (outputs) and the rows as matrix readers (inputs).
pub fn Keyboard_Matrix(comptime options: Keyboard_Matrix_Options) type {
    if (options.columns > 256 or options.rows > 256)
        @compileError("cannot encode more than 256 rows or columns!");
    return struct {
        const Matrix = @This();

        const Digital_IO: type = options.Digital_IO;
        const col_count: usize = options.columns;
        const row_count: usize = options.rows;

        /// Number of keys in this matrix.
        pub const key_count = col_count * row_count;

        /// Returns the index for the given key. Assumes that `key` is valid.
        pub fn index(key: Key) usize {
            return key.column() * row_count + key.row();
        }

        /// A set that can store if each key is set or not.
        pub const Set = struct {
            pressed: std.StaticBitSet(key_count) = std.StaticBitSet(key_count).initEmpty(),

            /// Adds a key to the set.
            pub fn add(set: *Set, key: Key) void {
                set.pressed.set(index(key));
            }

            /// Checks if a key is pressed.
            pub fn is_pressed(set: Set, key: Key) bool {
                return set.pressed.isSet(index(key));
            }

            /// Returns if any key is pressed.
            pub fn any(set: Set) bool {
                return (set.pressed.count() > 0);
            }
        };

        cols: [col_count]Digital_IO,
        rows: [row_count]Digital_IO,

        /// Initializes all GPIOs of the matrix and returns a new instance.
        pub fn init(
            cols: [col_count]Digital_IO,
            rows: [row_count]Digital_IO,
        ) !Matrix {
            var mat = Matrix{
                .cols = cols,
                .rows = rows,
            };
            for (cols) |c| {
                try c.set_direction(.output);
            }
            for (rows) |r| {
                try r.set_direction(.input);
                try r.set_bias(.high);
            }
            try mat.set_all_to(.high);
            return mat;
        }

        /// Scans the matrix and returns a set of all pressed keys.
        pub fn scan(matrix: Matrix) !Set {
            var result = Set{};

            try matrix.set_all_to(.high);

            for (matrix.cols, 0..) |c_pin, c_index| {
                try c_pin.write(.low);
                busyloop(10);

                for (matrix.rows, 0..) |r_pin, r_index| {
                    const state = try r_pin.read();
                    if (state == .low) {
                        // someone actually pressed a key!
                        result.add(Key.new(
                            @as(u8, @truncate(r_index)),
                            @as(u8, @truncate(c_index)),
                        ));
                    }
                }

                try c_pin.write(.high);
                busyloop(100);
            }

            try matrix.set_all_to(.high);

            return result;
        }

        fn set_all_to(matrix: Matrix, value: mdf.base.Digital_IO.State) !void {
            for (matrix.cols) |c| {
                try c.write(value);
            }
        }
    };
}

/// A single key in a 2D keyboard matrix.
///
/// NOTE: This type assumes there are not more than 256 rows and columns in a keyboard matrix.
pub const Key = enum(u16) {
    // we just assume we have enough encoding space and not more than 256 cols/rows
    _,

    pub fn new(r: u8, c: u8) Key {
        return Encoding.to_key(.{
            .row = r,
            .column = c,
        });
    }

    pub fn row(key: Key) u8 {
        return Encoding.from_key(key).row;
    }

    pub fn column(key: Key) u8 {
        return Encoding.from_key(key).column;
    }

    const Encoding = packed struct(u16) {
        column: u8,
        row: u8,

        pub fn from_key(key: Key) Encoding {
            const int: u16 = @intFromEnum(key);
            return @bitCast(int);
        }

        pub fn to_key(enc: Encoding) Key {
            const int: u16 = @bitCast(enc);
            return @enumFromInt(int);
        }
    };
};

inline fn busyloop(comptime N: comptime_int) void {
    for (0..N) |_| {
        // wait some cycles so the physics does its magic and convey
        // the electrons
        asm volatile ("" ::: "memory");
    }
}

test Keyboard_Matrix {
    const key_tl = Key.new(0, 0);
    const key_tr = Key.new(0, 1);
    const key_bl = Key.new(1, 0);
    const key_br = Key.new(1, 1);

    // Those are "drivers", so we initialize them inverse
    // to what we'd expect them to be
    var col_pins = [_]mdf.base.Digital_IO.TestDevice{
        mdf.base.Digital_IO.TestDevice.init(.input, .low),
        mdf.base.Digital_IO.TestDevice.init(.input, .low),
    };

    // Those are "inputs", so we have to check the
    // direction init, but not the state change:
    var row_pins = [_]mdf.base.Digital_IO.TestDevice{
        mdf.base.Digital_IO.TestDevice.init(.output, .high),
        mdf.base.Digital_IO.TestDevice.init(.output, .high),
    };

    const row_drivers = [_]mdf.base.Digital_IO{
        row_pins[0].digital_io(),
        row_pins[1].digital_io(),
    };

    const col_drivers = [_]mdf.base.Digital_IO{
        col_pins[0].digital_io(),
        col_pins[1].digital_io(),
    };

    const Matrix = Keyboard_Matrix(.{
        .rows = 2,
        .columns = 2,
    });

    var matrix = try Matrix.init(col_drivers, row_drivers);

    // Check if rows are properly initialized:
    for (row_pins) |pin| {
        try std.testing.expectEqual(.input, pin.dir);
    }

    // Check if columns are properly initialized:
    for (col_pins) |pin| {
        try std.testing.expectEqual(.output, pin.dir);
        try std.testing.expectEqual(.high, pin.state);
    }

    {
        // by default, the matrix should be "unset" as long as our inputs are
        // high:
        const set = try matrix.scan();
        try std.testing.expectEqual(false, set.any());
    }

    {
        // Test that if we set the top row to low, both "top" keys must be
        // pressed, but the "bottom" keys must not:
        row_pins[0].state = .low;
        defer row_pins[0].state = .high;

        const set = try matrix.scan();
        try std.testing.expectEqual(true, set.any());
        try std.testing.expectEqual(true, set.is_pressed(key_tl));
        try std.testing.expectEqual(true, set.is_pressed(key_tr));
        try std.testing.expectEqual(false, set.is_pressed(key_bl));
        try std.testing.expectEqual(false, set.is_pressed(key_br));
    }

    {
        // Test that if we set the bottom row to low, both "bottom" keys must be
        // pressed, but the "top" keys must not:
        row_pins[1].state = .low;
        defer row_pins[1].state = .high;

        const set = try matrix.scan();
        try std.testing.expectEqual(true, set.any());
        try std.testing.expectEqual(false, set.is_pressed(key_tl));
        try std.testing.expectEqual(false, set.is_pressed(key_tr));
        try std.testing.expectEqual(true, set.is_pressed(key_bl));
        try std.testing.expectEqual(true, set.is_pressed(key_br));
    }
}
