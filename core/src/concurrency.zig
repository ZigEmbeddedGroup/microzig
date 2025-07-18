/// Useful concurrency primitives based on atomics.
///
/// Note:
///     On some platforms with old ISA (like ARMv6-M i.e. RP2040)
///     atomic primitives are emulated using spinlocks and have to be exported in HAL
const std = @import("std");

pub const AtomicStaticBitSetError = error{NoAvailableBit};

/// Creates a statically sized BitSet type where operations are atomic.
/// Useful for managing a fixed pool of resources or flags concurrently.
/// `size` determines the number of bits available (0 to size-1).
pub fn AtomicStaticBitSet(comptime size: usize) type {
    return struct {
        const Size = size;
        const BlockType = usize;
        const BlockNum = (size + @bitSizeOf(BlockType) - 1) / @bitSizeOf(BlockType);
        const Bit = std.math.Log2Int(BlockType);
        const Self = @This();

        blocks: [BlockNum]std.atomic.Value(BlockType) = .{std.atomic.Value(BlockType){ .raw = 0 }} ** BlockNum,

        /// Sets the bit at `bit_index` to 1.
        ///
        /// Returns:
        ///   `true` if the bit was successfully changed from 0 to 1 by this call.
        ///   `false` if the bit was already 1.
        pub inline fn set(self: *Self, bit_index: usize) bool {
            std.debug.assert(bit_index < Size);
            return self.blocks[block_index(bit_index)].bitSet(bit_offset(bit_index), .seq_cst) == 0;
        }

        /// Resets (clears) the bit at `bit_index` to 0.
        ///
        /// Returns:
        ///   `true` if the bit was successfully changed from 1 to 0 by this call.
        ///   `false` if the bit was already 0.
        pub inline fn reset(self: *Self, bit_index: usize) bool {
            std.debug.assert(bit_index < Size);
            return self.blocks[block_index(bit_index)].bitReset(bit_offset(bit_index), .seq_cst) == 1;
        }

        /// Tests the value of the bit at `bit_index` without modifying it.
        ///
        /// Returns:
        ///   `u1`: Returns 1 if the bit is set, 0 if the bit is clear.
        pub inline fn test_bit(self: *Self, bit_index: usize) u1 {
            std.debug.assert(bit_index < Size);
            const mask: BlockType = @as(BlockType, 1) << bit_offset(bit_index);
            return @intFromBool(self.blocks[block_index(bit_index)].load(.seq_cst) & mask != 0);
        }

        /// Finds the first available (0) bit, sets it to 1, and returns its index.
        ///
        /// Returns:
        ///   The `usize` index of the bit that was successfully found and set.
        ///   Returns `BitSetError.NoAvailableBit` if all bits were already set.
        pub inline fn set_first_available(self: *Self) AtomicStaticBitSetError!usize {
            for (0..Size) |bit_index| {
                if (self.set(bit_index)) {
                    return bit_index;
                }
            }
            return AtomicStaticBitSetError.NoAvailableBit;
        }

        inline fn block_index(bit_index: usize) usize {
            return bit_index / @bitSizeOf(BlockType);
        }

        inline fn bit_offset(bit_index: usize) Bit {
            return @truncate(bit_index % @bitSizeOf(BlockType));
        }
    };
}

// Test suite for AtomicStaticBitSet
test "AtomicStaticBitSet basic operations" {
    const SetSize = 70; // Choose a size that spans multiple blocks (e.g., > 64)
    const BitSet = AtomicStaticBitSet(SetSize);
    var bs = BitSet{}; // Default initialization should have all bits zero

    // 1. Test Initialization and test_bit (initial state)
    var i_init: usize = 0;
    while (i_init < SetSize) : (i_init += 1) {
        try std.testing.expectEqual(@as(u1, 0), bs.test_bit(i_init));
    }

    // 2. Test set() and test_bit (after setting)
    const bit_to_set1: usize = 5;
    const bit_to_set2: usize = 65; // Test across block boundary (if usize=64)

    // Set bits that were 0
    try std.testing.expect(bs.set(bit_to_set1));
    try std.testing.expect(bs.set(bit_to_set2));

    // Verify they are set
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(bit_to_set1));
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(bit_to_set2));

    // Verify other bits remain unchanged
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(bit_to_set1 + 1));
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(0));

    // Try setting a bit that is already 1
    try std.testing.expect(!bs.set(bit_to_set1));
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(bit_to_set1));

    // 3. Test reset() and test_bit (after resetting)
    // Reset bits that were 1
    try std.testing.expect(bs.reset(bit_to_set1));
    try std.testing.expect(bs.reset(bit_to_set2));

    // Verify they are reset (0)
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(bit_to_set1));
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(bit_to_set2));

    // Try resetting a bit that is already 0
    const bit_already_zero: usize = 10;
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(bit_already_zero));
    try std.testing.expect(!bs.reset(bit_already_zero));
    try std.testing.expectEqual(@as(u1, 0), bs.test_bit(bit_already_zero));
}

test "AtomicStaticBitSet set_first_available" {
    const SetSize = 5; // Use a small size for exhaustive testing
    const BitSet = AtomicStaticBitSet(SetSize);
    var bs = BitSet{};

    // 1. Find first available in empty set
    var index = try bs.set_first_available();
    try std.testing.expectEqual(@as(usize, 0), index);
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(0));

    // 2. Manually set another bit and find next available
    _ = bs.set(3); // Set bit 3
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(3));

    index = try bs.set_first_available(); // Should find bit 1 next
    try std.testing.expectEqual(@as(usize, 1), index);
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(1));

    // 3. Fill the remaining bits
    index = try bs.set_first_available(); // Should find bit 2
    try std.testing.expectEqual(@as(usize, 2), index);
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(2));

    index = try bs.set_first_available(); // Should find bit 4
    try std.testing.expectEqual(@as(usize, 4), index);
    try std.testing.expectEqual(@as(u1, 1), bs.test_bit(4));

    // 4. Verify all bits are now set
    var i: usize = 0;
    while (i < SetSize) : (i += 1) {
        try std.testing.expectEqual(@as(u1, 1), bs.test_bit(i));
    }

    // 5. Try finding available in a full set - expect error
    const err = bs.set_first_available();
    try std.testing.expectError(AtomicStaticBitSetError.NoAvailableBit, err);
}

// TODO: docs + tests + someone please verify it
pub fn SPSC_Queue(Item: type, capacity: usize) type {
    return struct {
        const Self = @This();

        pub const empty: Self = .{
            .buf = undefined,
            .read_index = 0,
            .write_index = 0,
            .len = .init(0),
        };

        buf: [capacity]Item,
        read_index: usize,
        write_index: usize,
        len: std.atomic.Value(usize),

        pub fn enqueue(self: *Self, item: Item) error{NoSpace}!void {
            if (self.len.load(.acquire) < capacity) {
                self.buf[self.write_index] = item;
                self.write_index = (self.write_index + 1) % capacity;
                _ = self.len.fetchAdd(1, .acq_rel);
            } else {
                return error.NoSpace;
            }
        }

        pub fn dequeue(self: *Self) ?Item {
            if (self.len.load(.acquire) == 0) return null;

            const item = self.buf[self.read_index];
            self.read_index = (self.read_index + 1) % capacity;
            _ = self.len.fetchSub(1, .acq_rel);
            return item;
        }
    };
}
