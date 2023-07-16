const std = @import("std");

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
/// Uses `Pin` as the pin type (currently trimmed for the RP2040 package).
/// Will use `cols` as matrix drivers (outputs) and `rows` as matrix readers (inputs).
pub fn KeyboardMatrix(comptime Pin: type, comptime cols: []const Pin, comptime rows: []const Pin) type {
    if (cols.len > 256 or rows.len > 256) @compileError("cannot encode more than 256 rows or columns!");
    return struct {
        const LOW = 0;
        const HIGH = 1;

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
        pub fn init() Matrix {
            var mat = Matrix{};
            for (cols) |c| {
                c.set_function(.sio);
                c.set_direction(.out);
            }
            for (rows) |r| {
                r.set_function(.sio);
                r.set_pull(.up);
                r.set_direction(.in);
            }
            mat.setAllTo(HIGH);
            return mat;
        }

        /// Scans the matrix and returns a set of all pressed keys.
        pub fn scan(matrix: Matrix) Set {
            var result = Set{};

            matrix.setAllTo(HIGH);

            for (cols, 0..) |c_pin, c_index| {
                c_pin.put(LOW);
                busyloop(10);

                for (rows, 0..) |r_pin, r_index| {
                    const state = r_pin.read();
                    if (state == LOW) {
                        // someone actually pressed a key!
                        result.add(Key.new(
                            @as(u8, @truncate(r_index)),
                            @as(u8, @truncate(c_index)),
                        ));
                    }
                }

                c_pin.put(HIGH);
                busyloop(100);
            }

            matrix.setAllTo(HIGH);

            return result;
        }

        fn setAllTo(matrix: Matrix, value: u1) void {
            _ = matrix;
            for (cols) |c| {
                c.put(value);
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
