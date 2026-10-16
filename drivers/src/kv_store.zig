const std = @import("std");
const assert = std.debug.assert;
const alignForward = std.mem.alignForward;
const alignBackward = std.mem.alignBackward;
const isAligned = std.mem.isAlignedGeneric;

const log = std.log.scoped(.drivers_storage);

// TODO: support huge items that don't fit in a sector
// TODO: caching

pub const Options = struct {
    max_write_attempts: usize = 2,
    max_erase_attempts: usize = 2,
    max_read_attempts: usize = 2,
};

pub const Error = error{
    InvalidRange,
    EraseFailed,
    WriteFailed,
    InvalidWrite,
    ReadFailed,
    Corrupted,
    OutOfMemory,
};

/// A generic storage implementation that can be used with any flash device.
/// Items are stored sequentially in sectors (inspired by the rust crate
/// [sequential storage](https://crates.io/crates/sequential-storage)). It
/// should be resilient to power loss and flash corruption, but if any sector
/// becomes bad it is game over.
///
/// Storage layout:
///
/// [locked_sector] [locked_sector] [active_sector] [erased_sector] [locked_sector] [erased_or_locked_sectors...]
///
/// Sector layout:
///
/// [sector_tag] [item_tag] [item_header_padded] [key_padded] [value_padded] [next_items ...]
///  0x00||0xFF  0x00||0xFF
///
/// * padded to a write page
///
pub fn Generic(Flash: type, Key: type, options: Options) type {
    if (!is_type_allowed(Key)) @compileError("invalid key type " ++ @typeName(Key));

    return struct {
        const Storage = @This();

        const WRITE_SIZE = Flash.WRITE_SIZE;
        const ERASE_SIZE = Flash.ERASE_SIZE;

        comptime {
            assert(std.math.isPowerOfTwo(WRITE_SIZE));
            assert(std.math.isPowerOfTwo(ERASE_SIZE));
        }

        const TAG_OFFSET = 0;
        const HEADER_OFFSET = TAG_OFFSET + WRITE_SIZE;
        const KEY_OFFSET = HEADER_OFFSET + alignForward(u16, @sizeOf(ItemHeader), WRITE_SIZE);
        const VALUE_OFFSET = KEY_OFFSET + alignForward(u16, @sizeOf(Key), WRITE_SIZE);
        const MAX_ITEM_LEN = ERASE_SIZE - WRITE_SIZE; // don't forget the sector tag

        flash: Flash,
        range_start: u32,
        range_end: u32,
        current_offset: u32,
        active_sector_offset: u32,
        last_sector_offset: u32,

        /// Initialize the storage with the given flash device and range. The
        /// range must be aligned to the erase size and must contain at least
        /// two sectors.
        pub fn init(flash: Flash, range_start: u32, range_end: u32) Error!Storage {
            if (range_start >= range_end) {
                return error.InvalidRange;
            }
            if (!isAligned(u32, range_start, ERASE_SIZE)) {
                return error.InvalidRange;
            }
            if (!isAligned(u32, range_end, ERASE_SIZE)) {
                return error.InvalidRange;
            }

            // find the first non locked page this is where we left off
            var storage: Storage = .{
                .flash = flash,
                .range_start = range_start,
                .range_end = range_end,
                .current_offset = undefined,
                .active_sector_offset = undefined,
                .last_sector_offset = undefined,
            };

            var sector_offset = range_start;
            var active_sector_offset: u32 = find_sector: while (sector_offset < range_end) : (sector_offset += ERASE_SIZE) {
                const tag = storage.read_tag(sector_offset) catch |err| switch (err) {
                    error.Corrupted => Tag.locked,
                    else => return err,
                };
                if (tag == .in_use) {
                    break :find_sector sector_offset;
                }
            } else return error.Corrupted;

            // we got interrupted while advancing to the next sector at wraparound! ik.. one in a million
            if (active_sector_offset == range_start) {
                const prev_sector_offset = storage.get_prev_sector(active_sector_offset);
                const prev_sector_tag = storage.read_tag(prev_sector_offset) catch |err| switch (err) {
                    error.Corrupted => Tag.locked,
                    else => return err,
                };
                if (prev_sector_tag == .in_use and !try storage.is_sector_erased(prev_sector_offset)) {
                    active_sector_offset = prev_sector_offset;
                }
            }

            storage.active_sector_offset = active_sector_offset;

            // verify the reserved sector. it must be erased!
            const reserved_sector_offset = storage.get_next_sector(active_sector_offset);
            storage.erase_sector_retrying(reserved_sector_offset) catch |err| {
                log.warn("failed to erase reserved sector at 0x{X}: {}", .{ reserved_sector_offset, err });
            };

            // if the sector after the reserved one is erased, we haven't wrapped around
            const last_sector_offset = storage.get_next_sector(reserved_sector_offset);
            storage.last_sector_offset = if (try storage.is_sector_erased(last_sector_offset))
                range_start
            else
                last_sector_offset;

            var item_it: ItemIterator = .init(&storage, active_sector_offset);

            while (try item_it.next()) |item| {
                if (item.tag == .freed) continue;
                if (item.key == .corrupted) {
                    storage.clear_tag(item.offset) catch |err| {
                        log.warn("failed to free corrupted item at 0x{X}: {}", .{ item.offset, err });
                    };
                }
            }
            storage.current_offset = item_it.next_offset;

            if (item_it.corrupted_header_flag) {
                try storage.advance_to_next_sector();
            }

            return storage;
        }

        /// Fetch the value for the given key. Asserts the item has type T.
        /// Returns null if the key is not found.
        pub fn fetch(storage: *Storage, key: Key, comptime T: type) Error!?T {
            if (comptime !is_type_allowed(T)) @compileError("invalid value type " ++ @typeName(T));

            if (try storage.fetch_item_internal(key, storage.last_sector_offset)) |item| {
                var value: T = undefined;
                try storage.read_retrying(item.offset + VALUE_OFFSET, std.mem.asBytes(&value));
                return value;
            } else return null;
        }

        /// Store the given key and value. If the key already exists, it will
        /// be overwritten.
        pub fn store(storage: *Storage, key: Key, value: anytype) Error!void {
            if (comptime !is_type_allowed(@TypeOf(value))) @compileError("invalid value type " ++ @typeName(@TypeOf(value)));

            const item_len: u16 = comptime VALUE_OFFSET + @sizeOf(@TypeOf(value));
            const item_stride = comptime alignForward(u16, item_len, WRITE_SIZE);
            if (item_stride > MAX_ITEM_LEN) {
                @compileError(std.fmt.comptimePrint("storage item value too big: max size is {} bytes, got {} bytes", .{
                    MAX_ITEM_LEN, item_stride,
                }));
            }

            var recursive_limit: u32 = (storage.range_end - storage.range_start) / ERASE_SIZE;
            to_next_sector: while (recursive_limit > 0) : ({
                try storage.advance_to_next_sector();
                recursive_limit -= 1;
            }) {
                to_next_slot: while (storage.current_offset + item_stride <= storage.active_sector_offset + ERASE_SIZE) : ({
                    storage.current_offset += item_stride;
                }) {
                    var crc: std.hash.crc.@"CRC-32/CKSUM" = .init();
                    crc.update(std.mem.asBytes(&key));
                    crc.update(std.mem.asBytes(&value));

                    var header: ItemHeader = .init(crc.final(), item_len);

                    storage.write_retrying_aligned(storage.current_offset + HEADER_OFFSET, std.mem.asBytes(&header)) catch |err| switch (err) {
                        error.InvalidWrite => continue :to_next_sector,
                        else => return err,
                    };
                    storage.write_retrying_aligned(storage.current_offset + KEY_OFFSET, std.mem.asBytes(&key)) catch |err| switch (err) {
                        error.InvalidWrite => continue :to_next_slot,
                        else => return err,
                    };
                    storage.write_retrying_aligned(storage.current_offset + VALUE_OFFSET, std.mem.asBytes(&value)) catch |err| switch (err) {
                        error.InvalidWrite => continue :to_next_slot,
                        else => return err,
                    };

                    errdefer comptime unreachable; // we have written the item successfully

                    // because we call it before updating current_offset, we
                    // skip the last added item
                    storage.remove(key) catch {};

                    storage.current_offset += item_stride;

                    return;
                } else continue :to_next_sector;
            } else return error.OutOfMemory;
        }

        /// Remove the given key from storage.
        pub fn remove(storage: *Storage, key: Key) Error!void {
            var current_sector_offset = storage.active_sector_offset;
            while (true) : (current_sector_offset = storage.get_prev_sector(current_sector_offset)) {
                var item_it: ItemIterator = .init(storage, current_sector_offset);
                while (try item_it.next()) |item| {
                    if (item.tag == .freed) continue;
                    switch (item.key) {
                        .ok => |item_key| {
                            if (std.mem.eql(u8, std.mem.asBytes(&key), std.mem.asBytes(&item_key))) {
                                storage.clear_tag(item.offset) catch |err| {
                                    log.warn("failed to mark old item as free at 0x{X}: {}", .{ item.offset, err });
                                };
                            }
                        },
                        .corrupted => continue,
                    }
                }
                if (current_sector_offset == storage.last_sector_offset) {
                    break;
                }
            }
        }

        fn advance_to_next_sector(storage: *Storage) !void {
            // if there is only one sector for space, there is nothing we can do
            if ((storage.range_end - storage.range_start) / ERASE_SIZE == 1) {
                return error.OutOfMemory;
            }

            const active_sector_offset = storage.active_sector_offset;
            const reserved_sector_offset = storage.get_next_sector(active_sector_offset);
            const to_be_erased_sector_offset = storage.get_next_sector(reserved_sector_offset);

            var new_sector_offset: u32 = reserved_sector_offset + WRITE_SIZE;

            try storage.erase_sector_retrying(reserved_sector_offset);

            const last_sector_offset =
                if (storage.last_sector_offset == to_be_erased_sector_offset)
                    storage.get_next_sector(storage.last_sector_offset)
                else
                    storage.last_sector_offset;

            var item_it: ItemIterator = .init(storage, to_be_erased_sector_offset);
            while (try item_it.next()) |item| {
                if (item.tag == .freed) continue;
                switch (item.key) {
                    .ok => |item_key| {
                        if (try storage.fetch_item_internal(item_key, last_sector_offset) == null) {
                            var src_offset = item.offset + HEADER_OFFSET;
                            const src_end = item_it.next_offset;
                            const item_new_start = new_sector_offset;
                            var dst_offset = item_new_start + HEADER_OFFSET;

                            while (try storage.read_buf_retrying(src_offset, src_end)) |data| : ({
                                src_offset += @truncate(data.len);
                                dst_offset += @truncate(data.len);
                            }) {
                                // if this fails there is something seriously
                                // wrong with the page, so we can't proceed
                                try storage.write_retrying_aligned(dst_offset, data);
                            }

                            new_sector_offset = item_new_start + (src_end - item.offset);
                        }
                    },
                    .corrupted => continue,
                }
            }

            // lock the current sector
            try storage.clear_tag(active_sector_offset);

            // we are done with the critical parts, update state
            storage.current_offset = new_sector_offset;
            storage.active_sector_offset = reserved_sector_offset;
            storage.last_sector_offset = last_sector_offset;

            errdefer comptime unreachable;

            storage.erase_sector_retrying(to_be_erased_sector_offset) catch |err| {
                log.warn("failed to erase the new reserved sector at 0x{X}: {}", .{ to_be_erased_sector_offset, err });
            };
        }

        fn fetch_item_internal(storage: *Storage, key: Key, last_sector_offset: u32) !?Item {
            var current_sector_offset = storage.active_sector_offset;
            while (true) : (current_sector_offset = storage.get_prev_sector(current_sector_offset)) {
                var item_it: ItemIterator = .init(storage, current_sector_offset);
                var maybe_item: ?Item = null;
                while (try item_it.next()) |item| {
                    if (item.tag == .freed) continue;
                    switch (item.key) {
                        .ok => |item_key| {
                            if (std.mem.eql(u8, std.mem.asBytes(&key), std.mem.asBytes(&item_key))) {
                                maybe_item = item;
                            }
                        },
                        .corrupted => continue,
                    }
                }
                if (maybe_item) |item| {
                    return item;
                }

                if (current_sector_offset == last_sector_offset) {
                    return null;
                }
            }
        }

        pub fn print_all_items(storage: *Storage) !void {
            var current_sector_offset = storage.active_sector_offset;
            while (true) : (current_sector_offset = storage.get_prev_sector(current_sector_offset)) {
                var item_it: ItemIterator = .init(storage, current_sector_offset);
                while (try item_it.next()) |item| {
                    log.info("found item, sector={}, offset={}, tag={}, key={}", .{
                        current_sector_offset,
                        item.offset,
                        item.tag,
                        item.key,
                    });
                }
                if (current_sector_offset == storage.last_sector_offset) {
                    break;
                }
            }
        }

        fn get_next_sector(storage: *Storage, sector_offset: u32) u32 {
            assert(isAligned(u32, sector_offset, ERASE_SIZE));
            return if (sector_offset == storage.range_end - ERASE_SIZE)
                storage.range_start
            else
                sector_offset + ERASE_SIZE;
        }

        fn get_prev_sector(storage: *Storage, sector_offset: u32) u32 {
            assert(isAligned(u32, sector_offset, ERASE_SIZE));
            return if (sector_offset == storage.range_start)
                storage.range_end - ERASE_SIZE
            else
                sector_offset - ERASE_SIZE;
        }

        const Tag = enum {
            in_use,
            freed,

            pub const locked: Tag = .freed; // alias for sector tags
        };

        fn read_tag(storage: *Storage, offset: u32) !Tag {
            var tag: u8 = undefined;
            try storage.read_retrying(offset, (&tag)[0..1]);
            return if (tag == std.math.maxInt(u8)) .in_use else .freed;
        }

        fn clear_tag(storage: *Storage, offset: u32) !void {
            const tag: [WRITE_SIZE]u8 = @splat(0);
            try storage.write_retrying_aligned(offset, &tag);
        }

        fn read_retrying(storage: *Storage, offset: u32, data: []u8) !void {
            var attempts_remaining: usize = options.max_read_attempts;
            while (attempts_remaining > 0) : (attempts_remaining -= 1) {
                return storage.flash.read(offset, data) catch |err| switch (err) {
                    error.Corrupted => return error.Corrupted,
                    else => continue,
                };
            } else return error.ReadFailed;
        }

        fn read_buf_retrying(storage: *Storage, offset: u32, end: u32) !?[]const u8 {
            var attempts_remaining: usize = options.max_read_attempts;
            while (attempts_remaining > 0) : (attempts_remaining -= 1) {
                return storage.flash.read_buf(offset, end) catch |err| switch (err) {
                    error.Corrupted => return error.Corrupted,
                    else => continue,
                };
            } else return error.ReadFailed;
        }

        fn write_retrying_aligned(storage: *Storage, offset: u32, data: []const u8) !void {
            if (comptime WRITE_SIZE == 1) {
                try storage.write_retrying(offset, data);
            } else {
                const aligned_count = alignBackward(usize, data.len, WRITE_SIZE);
                if (aligned_count > 0) {
                    try storage.write_retrying(offset, data[0..aligned_count]);
                }

                if (aligned_count != data.len) {
                    var remaining_buf: [WRITE_SIZE]u8 = @splat(0xFF);
                    std.mem.copyForwards(u8, remaining_buf[0 .. data.len - aligned_count], data[aligned_count..]);
                    try storage.write_retrying(offset + @as(u32, @truncate(aligned_count)), &remaining_buf);
                }
            }
        }

        fn write_retrying(storage: *Storage, offset: u32, data: []const u8) !void {
            var attempts_remaining: usize = options.max_write_attempts;
            while (attempts_remaining > 0) : (attempts_remaining -= 1) {
                storage.flash.write(offset, data) catch continue;
                break;
            }

            var current_offset = offset;
            var data_offset: usize = 0;
            const end = current_offset + @as(u32, @truncate(data.len));
            while (storage.read_buf_retrying(current_offset, end) catch |err| switch (err) {
                error.Corrupted => return error.InvalidWrite,
                else => return err,
            }) |flash_data| : ({
                current_offset += @truncate(flash_data.len);
                data_offset += flash_data.len;
            }) {
                if (!std.mem.eql(u8, flash_data, data[data_offset..][0..flash_data.len])) {
                    return error.InvalidWrite;
                }
            }
        }

        fn erase_sector_retrying(storage: *Storage, offset: u32) !void {
            if (try storage.is_sector_erased(offset)) {
                return;
            }
            var attempts_remaining: usize = options.max_erase_attempts;
            attempts: while (attempts_remaining > 0) : (attempts_remaining -= 1) {
                storage.flash.erase(offset, ERASE_SIZE) catch continue :attempts;
                if (try storage.is_sector_erased(offset)) {
                    break :attempts;
                } else {
                    continue :attempts;
                }
            } else return error.EraseFailed;
        }

        fn is_sector_erased(storage: *Storage, offset: u32) !bool {
            var current_offset = offset;
            const end = current_offset + ERASE_SIZE;
            while (storage.read_buf_retrying(current_offset, end) catch |err| switch (err) {
                error.Corrupted => return false,
                else => return err,
            }) |data| : (current_offset += @truncate(data.len)) {
                if (!std.mem.allEqual(u8, data, 0xFF)) {
                    return false;
                }
            } else return true;
        }

        const Item = struct {
            offset: u32,
            tag: Tag,
            header: ItemHeader,
            key: union(enum) {
                ok: Key,
                corrupted,

                pub fn format(self: *const @This(), writer: *std.Io.Writer) std.Io.Writer.Error!void {
                    switch (self.*) {
                        .ok => |key| try writer.print("{f}", .{key}),
                        .corrupted => try writer.writeAll("corrupted"),
                    }
                }
            },
        };

        const ItemIterator = struct {
            storage: *Storage,
            next_offset: u32,
            end_offset: u32,
            corrupted_header_flag: bool = false,

            pub fn init(storage: *Storage, sector_offset: u32) ItemIterator {
                return .{
                    .storage = storage,
                    .next_offset = sector_offset + WRITE_SIZE, // don't forget the sector tag
                    .end_offset = if (sector_offset == storage.active_sector_offset)
                        storage.current_offset
                    else
                        sector_offset + ERASE_SIZE,
                };
            }

            pub fn next(it: *ItemIterator) !?Item {
                const current_offset = it.next_offset;

                // if there is not enough space for an item to fit
                if (current_offset + VALUE_OFFSET > it.end_offset) {
                    return null;
                }

                var header: ItemHeader = undefined;
                it.storage.read_retrying(current_offset + HEADER_OFFSET, std.mem.asBytes(&header)) catch |err| switch (err) {
                    error.Corrupted => {
                        it.corrupted_header_flag = true;
                        return null;
                    },
                    else => return err,
                };

                if (header.is_uninitialized()) {
                    // we reached the end of the sector, we can continue from here
                    return null;
                }

                if (!header.is_valid()) {
                    it.corrupted_header_flag = true;
                    return null;
                }

                const next_offset = current_offset + alignForward(u32, header.len, WRITE_SIZE);
                if (next_offset > it.end_offset) {
                    it.corrupted_header_flag = true;
                    return null;
                }

                defer it.next_offset = next_offset;

                // if the tag is unreadable .in_use is the safe default
                const tag = it.storage.read_tag(current_offset) catch |err| switch (err) {
                    error.Corrupted => .in_use,
                    else => return err,
                };

                var key: Key = undefined;
                it.storage.read_retrying(current_offset + KEY_OFFSET, std.mem.asBytes(&key)) catch |err| switch (err) {
                    error.Corrupted => return .{
                        .offset = current_offset,
                        .tag = tag,
                        .header = header,
                        .key = .corrupted,
                    },
                    else => return err,
                };

                if (tag == .in_use) {
                    var crc: std.hash.crc.@"CRC-32/CKSUM" = .init();

                    crc.update(std.mem.asBytes(&key));

                    var check_offset = current_offset + VALUE_OFFSET;
                    const value_end = current_offset + header.len;
                    while (it.storage.read_buf_retrying(check_offset, value_end) catch |err| switch (err) {
                        error.Corrupted => return .{
                            .offset = current_offset,
                            .tag = tag,
                            .header = header,
                            .key = .corrupted,
                        },
                        else => return err,
                    }) |data| : (check_offset += @truncate(data.len)) {
                        crc.update(data);
                    }

                    if (header.data_crc != crc.final()) {
                        return .{
                            .offset = current_offset,
                            .tag = tag,
                            .header = header,
                            .key = .corrupted,
                        };
                    }
                }

                return .{
                    .offset = current_offset,
                    .tag = tag,
                    .header = header,
                    .key = .{ .ok = key },
                };
            }
        };
    };
}

const ItemHeader = packed struct(u64) {
    data_crc: u32,
    len: u16,
    len_flipped: u16,

    pub fn init(data_crc: u32, len: u16) ItemHeader {
        return .{
            .data_crc = data_crc,
            .len = len,
            .len_flipped = ~len,
        };
    }

    pub fn is_uninitialized(self: ItemHeader) bool {
        return @as(u64, @bitCast(self)) == std.math.maxInt(u64);
    }

    pub fn is_valid(self: ItemHeader) bool {
        return @as(u16, @bitCast(self.len)) == ~self.len_flipped;
    }
};

pub const MockFlashOptions = struct {
    write_size: u32,
    erase_size: u32,
};

pub fn MockFlash(options: MockFlashOptions) type {
    return struct {
        const Self = @This();

        pub const WRITE_SIZE = options.write_size;
        pub const ERASE_SIZE = options.erase_size;

        buf: []u8,

        corruption_tripwire: ?u32 = null,
        power_loss_tripwire: ?u32 = null,
        power_loss_tripped: bool = false,

        pub fn init(buf: []u8) Self {
            assert(buf.len % options.write_size == 0);
            assert(buf.len % options.erase_size == 0);
            return .{
                .buf = buf,
            };
        }

        pub fn erase(self: *Self, offset: u32, size: u32) error{InvalidRange}!void {
            if (offset + size > self.buf.len) {
                return error.InvalidRange;
            }
            if (!isAligned(u32, offset, ERASE_SIZE)) {
                return error.InvalidRange;
            }
            if (!isAligned(u32, size, ERASE_SIZE)) {
                return error.InvalidRange;
            }

            if (self.power_loss_tripped) {
                return;
            }

            var erase_offset: u32 = 0;
            while (erase_offset < size) : (erase_offset += WRITE_SIZE) {
                const page_id = (offset + erase_offset) / WRITE_SIZE;

                if (self.corruption_tripwire == page_id) {
                    self.corruption_tripwire = null;
                }

                if (self.power_loss_tripwire == page_id) {
                    self.power_loss_tripwire = null;
                    self.power_loss_tripped = true;
                    break;
                }

                @memset(self.buf[offset..][erase_offset..][0..WRITE_SIZE], 0xFF);
            }
        }

        pub fn read_buf(self: *Self, offset: u32, end: u32) error{ InvalidRange, ReadFailed, Corrupted }!?[]const u8 {
            if (offset > self.buf.len or end > self.buf.len) return error.InvalidRange;

            if (self.corruption_tripwire) |corruption_tripwire| {
                const start_page_id = alignBackward(u32, offset, WRITE_SIZE) / WRITE_SIZE;
                const end_page_id = alignForward(u32, end, WRITE_SIZE) / WRITE_SIZE;
                if (start_page_id <= corruption_tripwire and
                    corruption_tripwire < end_page_id)
                {
                    return error.Corrupted;
                }
            }

            if (offset < end) {
                return self.buf[offset..end];
            } else {
                return null;
            }
        }

        pub fn read(self: *Self, offset: u32, data: []u8) error{ InvalidRange, ReadFailed, Corrupted }!void {
            if (offset + data.len > self.buf.len) return error.InvalidRange;

            if (self.corruption_tripwire) |corruption_tripwire| {
                const start_page_id = alignBackward(u32, offset, WRITE_SIZE) / WRITE_SIZE;
                const end_page_id = alignForward(u32, offset + @as(u32, @truncate(data.len)), WRITE_SIZE) / WRITE_SIZE;
                if (start_page_id <= corruption_tripwire and corruption_tripwire < end_page_id) {
                    return error.Corrupted;
                }
            }

            std.mem.copyForwards(u8, data, self.buf[offset..][0..data.len]);
        }

        pub fn write(self: *Self, offset: u32, data: []const u8) error{ InvalidRange, WriteFailed }!void {
            if (offset + data.len > self.buf.len) {
                return error.InvalidRange;
            }
            if (!isAligned(u32, offset, WRITE_SIZE)) {
                return error.InvalidRange;
            }
            if (!isAligned(usize, data.len, WRITE_SIZE)) {
                return error.InvalidRange;
            }

            if (self.power_loss_tripped) {
                return;
            }

            var copy_offset: u32 = 0;
            while (copy_offset < @as(u32, @truncate(data.len))) : (copy_offset += WRITE_SIZE) {
                const page_id = (offset + copy_offset) / WRITE_SIZE;

                if (self.power_loss_tripwire == page_id) {
                    self.power_loss_tripwire = null;
                    self.power_loss_tripped = true;
                    break;
                }

                std.mem.copyForwards(u8, self.buf[offset..][copy_offset..][0..WRITE_SIZE], data[copy_offset..][0..WRITE_SIZE]);
            }
        }
    };
}

fn is_type_allowed(T: type) bool {
    return switch (@typeInfo(T)) {
        .@"struct" => |info| info.layout == .@"extern" or info.layout == .@"packed",
        .@"enum" => |info| is_type_allowed(info.tag_type),
        .int => |info| info.bits % 8 == 0,
        .array => |info| is_type_allowed(info.child),
        else => false,
    };
}

const testing = std.testing;

comptime {
    for (&.{ 1, 2, 4, 16, 32 }) |write_size| {
        _ = GenerateTests(.{ .write_size = write_size, .erase_size = 1024 });
    }
}

pub fn GenerateTests(comptime flash_options: MockFlashOptions) type {
    return struct {
        const TestFlash = MockFlash(flash_options);
        const TestStorage = Generic(TestFlash, u32, .{});
        const FLASH_SIZE = 4 * 1024; // 4 sectors

        test "store then fetch roundtrip" {
            const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
            defer testing.allocator.free(buf);
            @memset(buf, 0xFF);

            var s: TestStorage = try .init(TestFlash.init(buf), 0, FLASH_SIZE);

            try s.store(1, @as(u32, 111));
            try s.store(2, @as(u32, 222));
            try testing.expectEqual(@as(?u32, 111), try s.fetch(1, u32));
            try testing.expectEqual(@as(?u32, 222), try s.fetch(2, u32));
            try testing.expectEqual(@as(?u32, null), try s.fetch(3, u32));
        }

        test "overwrite an existing item" {
            const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
            defer testing.allocator.free(buf);
            @memset(buf, 0xFF);

            var s: TestStorage = try .init(TestFlash.init(buf), 0, FLASH_SIZE);

            try s.store(1, @as(u32, 111));
            try s.store(1, @as(u32, 999));
            try testing.expectEqual(@as(?u32, 999), try s.fetch(1, u32));
        }

        test "sector wraparound and reinit" {
            const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
            defer testing.allocator.free(buf);
            @memset(buf, 0xFF);

            {
                var s: TestStorage = try .init(TestFlash.init(buf), 0, FLASH_SIZE);
                // write enough small items to force several sector rotations
                var i: u32 = 0;
                while (i < 100) : (i += 1) {
                    try s.store(i % 20, i);
                }
            }

            {
                // reinit from the same buffer, as if we just power-cycled cleanly
                var s = try TestStorage.init(TestFlash.init(buf), 0, FLASH_SIZE);
                var k: u32 = 0;
                while (k < 20) : (k += 1) {
                    try testing.expect((try s.fetch(k, u32)) != null);
                }
            }
        }

        test "single sector range cannot advance" {
            const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
            defer testing.allocator.free(buf);
            @memset(buf, 0xFF);

            var s: TestStorage = try .init(TestFlash.init(buf), 0, 1024);

            // fill the single sector until it can't fit another item
            var i: u32 = 0;
            while (true) : (i += 1) {
                s.store(i, i) catch |err| {
                    try testing.expectEqual(error.OutOfMemory, err);
                    break;
                };
                if (i > 1000) return error.NeverRanOutOfMemory;
            }
        }

        test "normal out of memory error" {
            const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
            defer testing.allocator.free(buf);
            @memset(buf, 0xFF);

            var s: TestStorage = try .init(TestFlash.init(buf), 0, FLASH_SIZE);
            // write enough small items to force several sector rotations
            var i: u32 = 0;
            while (true) : (i += 1) {
                s.store(i, i) catch |err| {
                    try testing.expectEqual(error.OutOfMemory, err);
                    break;
                };
                if (i > 1000) return error.NeverRanOutOfMemory;
            }
        }
    };
}

test "fuzz" {
    try testing.fuzz({}, do_fuzz, .{});
}

fn do_fuzz(_: void, smith: *testing.Smith) !void {
    const TestFlash = MockFlash(.{
        .write_size = 4,
        .erase_size = 1024,
    });
    const Storage = Generic(TestFlash, u32, .{});
    const Value = u32;

    const FLASH_SIZE = 4 * 1024;

    const buf: []u8 = try testing.allocator.alloc(u8, FLASH_SIZE);
    defer testing.allocator.free(buf);
    @memset(buf, 0xFF);

    var storage: Storage = try .init(TestFlash.init(buf), 0, FLASH_SIZE);

    var oracle: std.array_hash_map.Auto(u32, Value) = .empty;
    defer oracle.deinit(testing.allocator);

    const Action = enum {
        store,
        fetch,
    };

    for (0..10000) |_| {
        switch (smith.value(Action)) {
            .store => {
                const key = smith.value(u32);
                const value = smith.value(Value);
                try oracle.put(testing.allocator, key, value);
                storage.store(key, value) catch |err| switch (err) {
                    error.OutOfMemory => break,
                    else => return err,
                };
            },
            .fetch => {
                const key_index = smith.index(oracle.keys().len + 1);
                const key = if (key_index < oracle.keys().len)
                    oracle.keys()[key_index]
                else
                    smith.value(u32);
                const expected = oracle.get(key);
                const actual = try storage.fetch(key, Value);
                try testing.expectEqual(expected, actual);
            },
        }
    }
}
