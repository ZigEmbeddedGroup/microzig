const std = @import("std");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
    micro_linker.MemoryRegion{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}.{Pin}\" scheme.";
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    const index = std.mem.indexOfScalar(u8, spec, '.') orelse @compileError(invalid_format_msg);

    return struct {
        pub const port: u3 = std.fmt.parseInt(u3, spec[1..index], 10) catch @compileError(invalid_format_msg);
        pub const pin: u5 = std.fmt.parseInt(u5, spec[index + 1 ..], 10) catch @compileError(invalid_format_msg);

        const gpio_register = @intToPtr(*volatile registers.GPIO, registers.gpio_base + 0x20 * @as(u32, port));
        const gpio_mask: u32 = (1 << pin);
    };
}

pub const gpio = struct {
    pub fn read(comptime pin: type) u1 {
        return if ((pin.gpio_register.pin & pin.gpio_mask) != 0)
            @as(u1, 1)
        else
            0;
    }

    pub fn write(comptime pin: type, state: u1) void {
        if (state == 1) {
            pin.gpio_register.set = pin.gpio_mask;
        } else {
            pin.gpio_register.clr = pin.gpio_mask;
        }
    }
};

pub const registers = struct {
    pub const GPIO = extern struct {
        dir: u32, // 0x00
        pad: [3]u32,
        mask: u32, // 0x10
        pin: u32, // 0x14,
        set: u32, // 0x18,
        clr: u32, // 0x1C,
    };

    pub const gpio_base = 0x2009_C000;
};
