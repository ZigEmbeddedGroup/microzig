const std = @import("std");
const xml = @import("xml.zig");
const Peripheral = @import("Peripheral.zig");
const Register = @import("Register.zig");
const Field = @import("Field.zig");

const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

pub fn parsePeripheral(arena: *ArenaAllocator, node: *xml.Node) !Peripheral {
    const allocator = arena.allocator();
    return Peripheral{
        .name = try allocator.dupe(u8, xml.getAttribute(node, "name") orelse return error.NoName),
        .version = if (xml.getAttribute(node, "version")) |version|
            try allocator.dupe(u8, version)
        else
            null,
        .description = if (xml.getAttribute(node, "caption")) |caption|
            try allocator.dupe(u8, caption)
        else
            null,
        // TODO: make sure this is always null
        .base_addr = null,
    };
}

pub fn parseRegister(
    arena: *ArenaAllocator,
    node: *xml.Node,
    register_group_offset: ?usize,
    has_fields: bool,
) !Register {
    const allocator = arena.allocator();
    return Register{
        .name = try allocator.dupe(u8, xml.getAttribute(node, "name") orelse return error.NoName),
        .description = if (xml.getAttribute(node, "caption")) |caption|
            try allocator.dupe(u8, caption)
        else
            null,
        .addr_offset = if (xml.getAttribute(node, "offset")) |reg_offset_str| addr_offset: {
            const reg_offset = try std.fmt.parseInt(usize, reg_offset_str, 0);
            break :addr_offset if (register_group_offset) |group_offset|
                group_offset + reg_offset
            else
                reg_offset;
        } else return error.NoAddrOffset,
        .size = if (xml.getAttribute(node, "size")) |size_str| blk: {
            const full_size = 8 * try std.fmt.parseInt(u16, size_str, 0);
            if (!has_fields) {
                const mask = try std.fmt.parseInt(u64, xml.getAttribute(node, "mask") orelse break :blk full_size, 0);

                // ensure it starts at bit 0
                if (mask & 0x1 == 0)
                    break :blk full_size;

                var cursor: u7 = 0;
                while ((mask & (@as(u64, 1) << @intCast(u6, cursor))) != 0 and cursor < @bitSizeOf(u64)) : (cursor += 1) {}

                // we now have width, make sure that the mask is contiguous
                const width = cursor;
                while (cursor < @bitSizeOf(u64)) : (cursor += 1) {
                    if ((mask & (@as(u64, 1) << @intCast(u6, cursor))) != 0) {
                        break :blk full_size;
                    }
                } else break :blk width;
            }

            break :blk full_size;
        } else return error.NoSize, // if this shows up then we need to determine the default size of a register
        // TODO: ATDF register access
        .access = .read_write,
        // TODO: ATDF reset_value
        .reset_value = null,
        // TODO: ATDF reset_mask
        .reset_mask = null,
    };
}

pub fn parseField(arena: *ArenaAllocator, node: *xml.Node) !Field {
    const allocator = arena.allocator();
    const name = try allocator.dupe(u8, xml.getAttribute(node, "name") orelse return error.NoName);
    const mask = try std.fmt.parseInt(u64, xml.getAttribute(node, "mask") orelse return error.NoMask, 0);

    var offset: u7 = 0;
    while ((mask & (@as(u64, 1) << @intCast(u6, offset))) == 0 and offset < @bitSizeOf(usize)) : (offset += 1) {}

    var cursor: u7 = offset;
    while ((mask & (@as(u64, 1) << @intCast(u6, cursor))) != 0 and cursor < @bitSizeOf(u64)) : (cursor += 1) {}

    const width = cursor - offset;
    while (cursor < @bitSizeOf(u64)) : (cursor += 1)
        if ((mask & (@as(u64, 1) << @intCast(u6, cursor))) != 0) {
            std.log.warn("found mask with discontinuous bits: {s}, ignoring", .{name});
            return error.InvalidMask;
        };

    return Field{
        .name = name,
        .description = if (xml.getAttribute(node, "caption")) |caption|
            try allocator.dupe(u8, caption)
        else
            null,
        .offset = offset,
        .width = width,
        // TODO: does atdf have a field level access?
        .access = null,
    };
}
