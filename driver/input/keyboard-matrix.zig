//!
//! Implements a N*M keyboard matrix that will be scanned in column-major order.
//!

const std = @import("std");
const mdf = @import("../framework.zig");

/// A single key in a 2D keyboard matrix.
pub const Key = enum(u16) {
    // we just assume we have enough encoding space and not more than 256 cols/rows
    _,

    pub fn new(r: u8, c: u8) Key {
        return @as(Key, @enumFromInt((@as(u16, r) << 8) + c));
    }

    pub fn row(key: Key) u8 {
        return @as(u8, @truncate(@intFromEnum(key) >> 8));
    }

    pub fn column(key: Key) u8 {
        return @as(u8, @truncate(@intFromEnum(key)));
    }
};

/// Keyboard matrix implementation via GPIOs that scans columns and checks rows.
///
/// Will use `cols` as matrix drivers (outputs) and `rows` as matrix readers (inputs).
pub fn KeyboardMatrix(comptime col_count: usize, comptime row_count: usize) type {
    return KeyboardMatrix_Generic(mdf.base.DigitalIO, col_count, row_count);
}

pub fn KeyboardMatrix_Generic(comptime Pin: type, comptime col_count: usize, comptime row_count: usize) type {
    if (col_count > 256 or row_count > 256) @compileError("cannot encode more than 256 rows or columns!");
    return struct {
        const Matrix = @This();

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
            pub fn isPressed(set: Set, key: Key) bool {
                return set.pressed.isSet(index(key));
            }

            /// Returns if any key is pressed.
            pub fn any(set: Set) bool {
                return (set.pressed.count() > 0);
            }
        };

        cols: [col_count]Pin,
        rows: [row_count]Pin,

        /// Initializes all GPIOs of the matrix and returns a new instance.
        pub fn init(
            cols: [col_count]Pin,
            rows: [row_count]Pin,
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
                    const state = r_pin.read();
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

        fn set_all_to(matrix: Matrix, value: mdf.base.DigitalIO.State) !void {
            for (matrix.cols) |c| {
                try c.write(value);
            }
        }
    };
}

inline fn busyloop(comptime N: comptime_int) void {
    for (0..N) |_| {
        // wait some cycles so the physics does its magic and convey
        // the electrons
        asm volatile ("" ::: "memory");
    }
}

test KeyboardMatrix {
    var matrix_pins = [_]mdf.base.DigitalIO.TestDevice{
        mdf.base.DigitalIO.TestDevice.init(.output, .high),
        mdf.base.DigitalIO.TestDevice.init(.output, .high),
        mdf.base.DigitalIO.TestDevice.init(.output, .high),
        mdf.base.DigitalIO.TestDevice.init(.output, .high),
    };
    const rows = [_]mdf.base.DigitalIO{
        matrix_pins[0].digital_io(),
        matrix_pins[1].digital_io(),
    };
    const cols = [_]mdf.base.DigitalIO{
        matrix_pins[2].digital_io(),
        matrix_pins[3].digital_io(),
    };

    var matrix = try KeyboardMatrix(2, 2).init(&cols, &rows);

    const set = try matrix.scan();
    _ = set;
}
