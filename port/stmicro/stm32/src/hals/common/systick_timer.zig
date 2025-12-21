const microzig = @import("microzig");
const cpu_systick = @import("systick.zig");
const Clock_Device = microzig.drivers.base.Clock_Device;
const time = microzig.drivers.time;
const vtable: Clock_Device.VTable = .{ .get_time_since_boot = get_time_since_boot };

const Error = error{
    CpuSystickNotInitialized,
};

pub fn get_time_since_boot(_: *anyopaque) time.Absolute {
    const us = cpu_systick.get_time_since_boot();
    return @enumFromInt(us);
}

pub fn clock_device() Error!Clock_Device {
    if (!cpu_systick.is_initialized()) {
        return Error.CpuSystickNotInitialized;
    }
    return .{
        .ptr = undefined,
        .vtable = &vtable,
    };
}
