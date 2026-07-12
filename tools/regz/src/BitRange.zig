const std = @import("std");
const xml = @import("xml");

const BitRange = @This();

offset: u8,
width: u8,

pub fn lsb_msb(lsb: u8, msb: u8) !BitRange {
    return if (msb < lsb)
        error.InvalidRange
    else
        .{
            .offset = lsb,
            .width = msb - lsb + 1,
        };
}

pub fn parse_xml(node: xml.Node) !BitRange {
    if (try node.get_attribute_int(u8, "lsb")) |lsb| {
        if (try node.get_attribute_int(u8, "msb")) |msb| {
            return .lsb_msb(lsb, msb);
        }
    }
    if (try node.get_attribute_int(u8, "bitOffset")) |offset| {
        if (try node.get_attribute_int(u8, "bitWidth")) |width| {
            return .{
                .offset = offset,
                .width = width,
            };
        }
    }
    if (node.get_value("bitRange")) |bit_range_str| {
        var it = std.mem.tokenizeAny(u8, bit_range_str, "[:]");
        const msb = try std.fmt.parseInt(u8, it.next() orelse return error.NoMsb, 0);
        const lsb = try std.fmt.parseInt(u8, it.next() orelse return error.NoLsb, 0);

        return .lsb_msb(lsb, msb);
    }
    if (try node.get_attribute_int(u8, "width")) |width_bits| {
        if (try node.get_attribute_int(u8, "end")) |end_bit| {
            return .{
                .offset = end_bit,
                .width = width_bits,
            };
        }
    }
    return error.InvalidRange;
}
