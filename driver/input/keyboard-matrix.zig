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
pub fn KeyboardMatrix(comptime cols: []const mdf.base.DigitalIO, comptime rows: []const mdf.base.DigitalIO) type {
    return KeyboardMatrix_Generic(mdf.base.DigitalIO, cols, rows);
}

pub fn KeyboardMatrix_Generic(comptime Pin: type, comptime cols: []const Pin, comptime rows: []const Pin) type {
    if (cols.len > 256 or rows.len > 256) @compileError("cannot encode more than 256 rows or columns!");
    return struct {
        const Matrix = @This();

        /// Number of keys in this matrix.
        pub const key_count = cols.len * rows.len;

        /// Returns the index for the given key. Assumes that `key` is valid.
        pub fn index(key: Key) usize {
            return key.column() * rows.len + key.row();
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

        /// Initializes all GPIOs of the matrix and returns a new instance.
        pub fn init() !Matrix {
            var mat = Matrix{};
            for (cols) |c| {
                try c.setDirection(.output);
            }
            for (rows) |r| {
                try r.setDirection(.input);
                try r.setBias(.high);
            }
            try mat.setAllTo(.high);
            return mat;
        }

        /// Scans the matrix and returns a set of all pressed keys.
        pub fn scan(matrix: Matrix) !Set {
            var result = Set{};

            try matrix.setAllTo(.high);

            for (cols, 0..) |c_pin, c_index| {
                try c_pin.write(.low);
                busyloop(10);

                for (rows, 0..) |r_pin, r_index| {
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

            try matrix.setAllTo(.high);

            return result;
        }

        fn setAllTo(matrix: Matrix, value: mdf.base.DigitalIO.State) !void {
            _ = matrix;
            for (cols) |c| {
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
