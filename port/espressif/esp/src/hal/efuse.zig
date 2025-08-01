const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const EFUSE = peripherals.EFUSE;

pub fn read_mac() [6]u8 {
    var mac: [6]u8 = undefined;
    for (items.mac, 0..) |item, i| {
        mac[i] = read(item);
    }
    return mac;
}

pub fn read(comptime what: Item) @Type(.{ .int = .{ .bits = what.bit_length, .signedness = .unsigned } }) {
    const OutputType = @Type(.{ .int = .{ .bits = what.bit_length, .signedness = .unsigned } });

    const block_byte_offsets = [_]u8{ 0x2C, 0x44, 0x5C };
    if (what.block >= block_byte_offsets.len) @compileError("invalid block");

    const start_word = what.bit_offset / 32;
    const start_bit_offset_in_word = what.bit_offset % 32;

    const end_bit = what.bit_offset + what.bit_length - 1;
    const end_word = end_bit / 32;
    const end_bit_offset_in_word = end_bit % 32;

    var result: OutputType = 0;
    comptime var current_bit = 0;

    inline for (start_word..end_word + 1) |word| {
        const word_offset = block_byte_offsets[what.block] + word * 4;

        var value = @as(*volatile u32, @ptrFromInt(@intFromPtr(EFUSE) + word_offset)).*;

        comptime var increment = 32;
        comptime var pre_shift = 0;

        if (word == start_word) {
            value >>= start_bit_offset_in_word;
            increment -= start_bit_offset_in_word;
            pre_shift = start_bit_offset_in_word;
        }

        if (word == end_word) {
            const shift = 31 - (end_bit_offset_in_word - pre_shift);
            const mask = ~@as(u32, 0) <<| shift >> shift;

            value &= mask;
            increment -= 31 - end_bit_offset_in_word;
        }

        result |= @as(OutputType, @intCast(value)) << current_bit;
        current_bit += increment;
    }

    comptime std.debug.assert(current_bit == what.bit_length);

    return result;
}

pub const Item = struct {
    block: u8,
    bit_offset: u8,
    bit_length: u8,
};

// Using a separate namespace here to make it easy to port to other chips.
pub const items = struct {
    // Bytes are in inverse order.
    pub const mac: []const Item = &.{
        .{
            .block = 1,
            .bit_offset = 40,
            .bit_length = 8,
        },
        .{
            .block = 1,
            .bit_offset = 32,
            .bit_length = 8,
        },
        .{
            .block = 1,
            .bit_offset = 24,
            .bit_length = 8,
        },
        .{
            .block = 1,
            .bit_offset = 16,
            .bit_length = 8,
        },
        .{
            .block = 1,
            .bit_offset = 8,
            .bit_length = 8,
        },
        .{
            .block = 1,
            .bit_offset = 0,
            .bit_length = 8,
        },
    };

    pub const blk_version_minor: Item = .{
        .block = 1,
        .bit_offset = 120,
        .bit_length = 3,
    };

    pub const blk_version_major: Item = .{
        .block = 1,
        .bit_offset = 128,
        .bit_length = 2,
    };

    pub const adc1_init_code: []const Item = &.{
        .{
            .block = 2,
            .bit_offset = 148,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 158,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 168,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 178,
            .bit_length = 10,
        },
    };

    pub const adc1_cal_voltage: []const Item = &.{
        .{
            .block = 2,
            .bit_offset = 188,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 198,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 208,
            .bit_length = 10,
        },
        .{
            .block = 2,
            .bit_offset = 218,
            .bit_length = 10,
        },
    };
};
