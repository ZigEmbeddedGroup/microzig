const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");

pub fn num(comptime n: u3) Port {
    return @enumFromInt(n);
}

pub const Port = enum(u3) {
    _,

    pub fn init(comptime port: Port) void {
        const tag = switch (@intFromEnum(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
            4 => .PORT4,
            // 5 => .PORT5,
            else => unreachable
        };

        syscon.peripheral_reset_release(tag);
        syscon.module_enable_clock(tag);
    }

    pub fn get_gpio(comptime port: Port, comptime pin: u5) gpio.GPIO {
        return gpio.num(@intFromEnum(port), pin);
    }
};
