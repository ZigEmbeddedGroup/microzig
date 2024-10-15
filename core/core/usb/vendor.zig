const std = @import("std");

const types = @import("types.zig");

pub const VendorClassDriver = struct {
    
    fn init(_: *anyopaque, _: types.UsbDevice) void {
    }

    fn open(_: *anyopaque, _: []const u8) !usize {
        return 0;
    }

    pub fn class_control(_: *anyopaque, _: types.ControlStage, _: *const types.SetupPacket) bool {
        return true;
    }

    pub fn driver(self: *@This()) types.UsbClassDriver {
        return .{
            .ptr = self,
            .fn_init = init,
            .fn_open = open,
            .fn_class_control = class_control
        };
    }
};