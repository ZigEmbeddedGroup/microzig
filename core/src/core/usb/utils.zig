const std = @import("std");
const types = @import("types.zig");

pub const BosConfig = struct {
    pub inline fn get_desc_len(bos_cfg: []const u8) u8 {
        return bos_cfg[0];
    }

    pub fn get_desc_type(bos_cfg: []const u8) u8 {
        return bos_cfg[1];
    }

    pub fn get_data_u8(bos_cfg: []const u8, offset: u16) u8 {
        return bos_cfg[offset];
    }

    pub fn get_data_u16(bos_cfg: []const u8, offset: u16) u16 {
        const low_byte: u16 = bos_cfg[offset];
        const high_byte: u16 = bos_cfg[offset + 1];
        return (high_byte << 8) | low_byte;
    }

    /// Only for temporal u8 fields use as u16 fields will have wrong values because BOS endianness
    pub fn get_desc_as(comptime T: type, bos_cfg: []const u8) *const T {
        return @ptrCast(@constCast(bos_cfg.ptr));
    }

    /// Only for temporal u8 fields use as u16 fields will have wrong values because BOS endianness
    pub fn try_get_desc_as(comptime T: type, bos_cfg: []const u8) ?*const T {
        if (bos_cfg.len == 0) return null;
        const exp_desc_type = @field(T, "const_descriptor_type");
        if (get_desc_type(bos_cfg) != @intFromEnum(exp_desc_type)) {
            return null;
        } else {
            return @constCast(@ptrCast(bos_cfg.ptr));
        }
    }

    pub fn get_desc_next(bos_cfg: []const u8) []const u8 {
        return bos_cfg[get_desc_len(bos_cfg)..];
    }
};

test "Test try_get_desc_as" {
    const cfg = [_]u8{ 7, 5, 129, 3, 8, 0, 16 };
    try std.testing.expect(BosConfig.try_get_desc_as(types.EndpointDescriptor, cfg[0..]) != null);
}
