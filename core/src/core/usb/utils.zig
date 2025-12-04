const std = @import("std");
const descriptor = @import("descriptor.zig");
const types = @import("types.zig");

pub const BosConfig = struct {
    const DESC_OFFSET_LEN = 0;
    const DESC_OFFSET_TYPE = 1;

    pub fn get_desc_len(bos_cfg: []const u8) u8 {
        return bos_cfg[DESC_OFFSET_LEN];
    }

    pub fn get_desc_type(bos_cfg: []const u8) ?descriptor.Type {
        return @enumFromInt(bos_cfg[DESC_OFFSET_TYPE]);
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
        const desc_fld = @typeInfo(T).@"struct".fields[1];
        std.debug.assert(std.mem.eql(u8, "descriptor_type", desc_fld.name));
        const exp_desc_type = @as(*const desc_fld.type, @ptrCast(desc_fld.default_value_ptr.?)).*;
        const cfg_desc_type = bos_cfg[DESC_OFFSET_TYPE];
        if (cfg_desc_type != @intFromEnum(exp_desc_type)) {
            return null;
        } else {
            return @ptrCast(@constCast(bos_cfg.ptr));
        }
    }

    pub fn get_desc_next(bos_cfg: []const u8) []const u8 {
        const len = bos_cfg[DESC_OFFSET_LEN];
        return bos_cfg[len..];
    }
};

test "Test try_get_desc_as" {
    const cfg = [_]u8{ 7, 5, 129, 3, 8, 0, 16 };
    try std.testing.expect(BosConfig.try_get_desc_as(types.EndpointDescriptor, cfg[0..]) != null);
}
