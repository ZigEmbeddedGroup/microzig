const microzig = @import("microzig");
const syscon = @import("./syscon.zig");
const gpio = @import("./gpio.zig");

pub fn num(comptime n: u2) Port {
    return @enumFromInt(n);
}

pub const Port = enum(u2) {
    _,

    pub fn init(comptime port: Port) void {
        const tag = switch (@intFromEnum(port)) {
            0 => .PORT0,
            1 => .PORT1,
            2 => .PORT2,
            3 => .PORT3,
        };

        syscon.reset_release(tag);
        syscon.enable_clock(tag);
    }

    pub fn get_gpio(comptime port: Port, comptime pin: u5) gpio.GPIO {
        return gpio.num(@intFromEnum(port), pin);
    }
};
