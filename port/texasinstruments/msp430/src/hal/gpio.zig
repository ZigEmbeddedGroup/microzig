const std = @import("std");
const microzig = @import("microzig");
const cpu = microzig.cpu;
const peripherals = microzig.chip.peripherals;

pub fn num(port: u3, n: u3) Pin {
    return Pin{
        .port = port,
        .num = n,
    };
}

pub const Direction = enum {
    input,
    output,
};

pub const Pin = struct {
    port: u3,
    num: u3,

    fn get_reg(comptime periph_name: []const u8, comptime register_name: []const u8) *volatile u8 {
        if (!@hasDecl(peripherals, periph_name))
            @panic("missing peripheral " ++ periph_name);

        const periph = @field(peripherals, periph_name);
        if (!@hasField(@typeInfo(@TypeOf(periph)).pointer.child, register_name))
            @panic("missing register " ++ register_name);

        return &@field(periph, register_name).raw;
    }

    inline fn out(p: Pin) *volatile u8 {
        return switch (p.port) {
            1 => get_reg("Port_1_2", "P1OUT"),
            2 => get_reg("Port_1_2", "P2OUT"),
            3 => get_reg("Port_3_4", "P3OUT"),
            4 => get_reg("Port_3_4", "P4OUT"),
            5 => get_reg("Port_5_6", "P5OUT"),
            6 => get_reg("Port_5_6", "P6OUT"),
            else => unreachable,
        };
    }

    pub inline fn set_direction(p: Pin, dir: Direction) void {
        const dir_reg: *volatile u8 = switch (p.port) {
            1 => get_reg("Port_1_2", "P1DIR"),
            2 => get_reg("Port_1_2", "P2DIR"),
            3 => get_reg("Port_3_4", "P3DIR"),
            4 => get_reg("Port_3_4", "P4DIR"),
            5 => get_reg("Port_5_6", "P5DIR"),
            6 => get_reg("Port_5_6", "P6DIR"),
            else => unreachable,
        };

        switch (dir) {
            .input => dir_reg.* &= ~(@as(u8, 1) << p.num),
            .output => dir_reg.* |= @as(u8, 1) << p.num,
        }
    }

    pub inline fn toggle(p: Pin) void {
        p.out().* ^= @as(u8, 1) << p.num;
    }

    pub inline fn put(p: Pin, value: u1) void {
        switch (value) {
            0 => p.out().* &= ~(@as(u8, 1) << p.num),
            1 => p.out().* |= @as(u8, 1) << p.num,
        }
    }
};
