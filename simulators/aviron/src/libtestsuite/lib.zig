const std = @import("std");

pub inline fn exit(code: u8) noreturn {
    asm volatile (
        \\out 0x00, %[code]
        :
        : [code] "r" (code),
    );

    unreachable;
}

pub inline fn assert(b: bool) void {
    if (!b)
        exit(1);
}

pub const Channel = enum(u8) {
    stdout = 0x01,
    stderr = 0x02,
};

pub inline fn write(comptime chan: Channel, string: []const u8) void {
    for (string) |c| {
        asm volatile (
            \\out %[port], %[code]
            :
            : [code] "r" (c),
              [port] "i" (@intFromEnum(chan)),
        );
    }
}
