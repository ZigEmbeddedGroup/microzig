const std = @import("std");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");

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

    const _port: u3 = std.fmt.parseInt(u3, spec[1..index], 10) catch @compileError(invalid_format_msg);
    const _pin: u5 = std.fmt.parseInt(u5, spec[index + 1 ..], 10) catch @compileError(invalid_format_msg);

    const _regs = struct {
        const name_suffix = std.fmt.comptimePrint("{d}", .{_port});

        const dir = @field(registers.GPIO, "DIR" ++ name_suffix);
        const pin = @field(registers.GPIO, "PIN" ++ name_suffix);
        const set = @field(registers.GPIO, "SET" ++ name_suffix);
        const clr = @field(registers.GPIO, "CLR" ++ name_suffix);
        const mask = @field(registers.GPIO, "MASK" ++ name_suffix);
    };

    return struct {
        pub const port = _port;
        pub const pin = _pin;
        pub const regs = _regs;
        const gpio_mask: u32 = (1 << pin);
    };
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        pin.regs.dir.raw |= pin.gpio_mask;
    }
    pub fn setInput(comptime pin: type) void {
        pin.regs.dir.raw &= ~pin.gpio_mask;
    }

    pub fn read(comptime pin: type) u1 {
        return if ((pin.regs.pin.raw & pin.gpio_mask) != 0)
            @as(u1, 1)
        else
            0;
    }

    pub fn write(comptime pin: type, state: u1) void {
        if (state == 1) {
            pin.regs.set.raw = pin.gpio_mask;
        } else {
            pin.regs.clr.raw = pin.gpio_mask;
        }
    }
};

// pub const GPIO = extern struct {
//     dir: u32, // 0x00
//     pad: [3]u32,
//     mask: u32, // 0x10
//     pin: u32, // 0x14,
//     set: u32, // 0x18,
//     clr: u32, // 0x1C,
// };

// pub const gpio_base = 0x2009_C000;
