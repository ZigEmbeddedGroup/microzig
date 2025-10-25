const std = @import("std");

pub const ElisionMode = enum {
    none,
    zeros,
    duplicates,
};

pub fn hexdump(
    reader: anytype,
    base_addr: anytype,
    size: usize,
    options: struct {
        elide: ElisionMode = .zeros,
        label: ?[]const u8 = null,
        row_width: usize = 16,
        show_ascii: bool = true,
    },
) void {
    // Ensure the reader has a read method
    const ReaderType = @TypeOf(reader);
    if (!@hasDecl(ReaderType, "read")) {
        @compileError("reader must have a 'read' method");
    }

    // Print header if label provided
    if (options.label) |label| {
        const end_addr = base_addr + @as(@TypeOf(base_addr), @intCast(size - 1));
        std.debug.print("\n{s} (0x{X:0>4}-0x{X:0>4}, {d} bytes):\n", .{
            label,
            base_addr,
            end_addr,
            size,
        });
    }

    const row_width = options.row_width;
    var prev_row: ?[256]u8 = null; // Max possible row width
    var prev_len: usize = 0;
    var elided = false;

    var i: usize = 0;
    while (i < size) : (i += @min(row_width, size - i)) {
        const row_len: usize = @min(row_width, size - i);
        var cur_row: [256]u8 = undefined;

        // Read current row
        var j: usize = 0;
        while (j < row_len) : (j += 1) {
            const addr = base_addr + @as(@TypeOf(base_addr), @intCast(i + j));
            cur_row[j] = reader.read(addr);
        }

        // Determine if we should elide this row
        const should_elide = switch (options.elide) {
            .none => false,
            .zeros => blk: {
                // Check if all zeros
                const is_all_zeros = for (cur_row[0..row_len]) |byte| {
                    if (byte != 0) break false;
                } else true;

                const same_as_prev = if (prev_row) |prev|
                    prev_len == row_len and std.mem.eql(u8, prev[0..prev_len], cur_row[0..row_len])
                else
                    false;

                break :blk is_all_zeros and same_as_prev;
            },
            .duplicates => blk: {
                if (prev_row) |prev| {
                    break :blk prev_len == row_len and std.mem.eql(u8, prev[0..prev_len], cur_row[0..row_len]);
                }
                break :blk false;
            },
        };

        if (should_elide) {
            elided = true;
        } else {
            // Print elision marker if we skipped rows
            if (elided) {
                std.debug.print("*\n", .{});
                elided = false;
            }

            // Print address
            const addr = base_addr + @as(@TypeOf(base_addr), @intCast(i));
            std.debug.print("0x{X:0>4}: ", .{addr});

            // Print hex bytes
            j = 0;
            while (j < row_len) : (j += 1) {
                std.debug.print("{X:0>2} ", .{cur_row[j]});
            }

            // Pad hex area for short rows to align ASCII column
            if (options.show_ascii and row_len < row_width) {
                var pad: usize = row_width - row_len;
                while (pad > 0) : (pad -= 1) {
                    std.debug.print("   ", .{});
                }
            }

            // Print ASCII representation
            if (options.show_ascii) {
                std.debug.print(" |", .{});
                j = 0;
                while (j < row_len) : (j += 1) {
                    const b = cur_row[j];
                    if (b >= 32 and b <= 126) {
                        std.debug.print("{c}", .{b});
                    } else {
                        std.debug.print(".", .{});
                    }
                }
                std.debug.print("|", .{});
            }

            std.debug.print("\n", .{});

            // Store as previous row
            if (prev_row == null) {
                prev_row = [_]u8{0} ** 256;
            }
            @memcpy(prev_row.?[0..row_len], cur_row[0..row_len]);
            prev_len = row_len;
        }
    }

    // Print final elision marker if needed
    if (elided) {
        std.debug.print("*\n", .{});
    }
}
