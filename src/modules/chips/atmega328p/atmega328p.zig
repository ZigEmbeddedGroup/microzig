const std = @import("std");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}.{Pin}\" scheme.";

    if (spec.len != 3)
        @compileError(invalid_format_msg);
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    return struct {
        pub const port: u8 = std.ascii.toUpper(spec[1]) - 'A';
        pub const pin: u3 = @intCast(u3, spec[2] - '0');
    };
}

pub const gpio = struct {
    fn dirReg(comptime pin: type) *volatile u8 {
        return @intToPtr(*volatile u8, 0x01);
    }
    fn portReg(comptime pin: type) *volatile u8 {
        return @intToPtr(*volatile u8, 0x01);
    }
    fn pinReg(comptime pin: type) *volatile u8 {
        return @intToPtr(*volatile u8, 0x01);
    }

    pub fn setOutput(comptime pin: type) void {
        dirReg(pin).* |= (1 << pin.pin);
    }
    pub fn setInput(comptime pin: type) void {
        dirReg(pin).* &= ~(@as(u8, 1) << pin.pin);
    }

    pub fn read(comptime pin: type) u1 {
        return if ((pinReg(pin).* & (1 << pin.pin)) != 0)
            @as(u1, 1)
        else
            0;
    }

    pub fn write(comptime pin: type, state: u1) void {
        if (state == 1) {
            portReg(pin).* |= (1 << pin.pin);
        } else {
            portReg(pin).* &= ~@as(u8, 1 << pin.pin);
        }
    }

    pub fn toggle(comptime pin: type) void {
        portReg(pin).* ^= (1 << pin.pin);
    }
};
