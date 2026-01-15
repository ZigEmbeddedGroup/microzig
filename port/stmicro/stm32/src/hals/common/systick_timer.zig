const microzig = @import("microzig");
const cpu_systick = @import("systick.zig");
const Clock_Device = microzig.drivers.base.Clock_Device;
const time = microzig.drivers.time;

const Self = @This();

interface: Clock_Device = .{ .vtable = &.{ .get_time_since_boot = get_time_since_boot } },

const Error = error{
    CpuSystickNotInitialized,
};

pub fn get_time_since_boot(_: *Clock_Device) time.Absolute {
    const us = cpu_systick.get_time_since_boot();
    return @enumFromInt(us);
}

pub fn init() Error!Self {
    if (!cpu_systick.is_initialized()) {
        return Error.CpuSystickNotInitialized;
    }
    return .{};
}

pub fn clock_device(self: *Self) *Clock_Device {
    return &self.interface;
}
