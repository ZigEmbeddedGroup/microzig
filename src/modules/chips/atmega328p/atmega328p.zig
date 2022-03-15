const std = @import("std");
const micro = @import("microzig");

pub const cpu = micro.cpu;
const Port = enum(u8) {
    B = 1,
    C = 2,
    D = 3,
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec.len != 3)
        @compileError(invalid_format_msg);
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    return struct {
        pub const port: Port = std.meta.stringToEnum(Port, spec[1..2]) orelse @compileError(invalid_format_msg);
        pub const pin: u3 = std.fmt.parseInt(u3, spec[2..3], 10) catch @compileError(invalid_format_msg);
    };
}

pub const gpio = struct {
    fn regs(comptime desc: type) type {
        return struct {
            const pin_addr = 3 * @enumToInt(desc.port) + 0x00;
            const dir_addr = 3 * @enumToInt(desc.port) + 0x01;
            const port_addr = 3 * @enumToInt(desc.port) + 0x02;

            const pin = @intToPtr(*volatile u8, pin_addr);
            const dir = @intToPtr(*volatile u8, dir_addr);
            const port = @intToPtr(*volatile u8, port_addr);
        };
    }

    pub fn setOutput(comptime pin: type) void {
        cpu.sbi(regs(pin).dir_addr, pin.pin);
    }

    pub fn setInput(comptime pin: type) void {
        cpu.cbi(regs(pin).dir_addr, pin.pin);
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        return if ((regs(pin).pin.* & (1 << pin.pin)) != 0)
            .high
        else
            .low;
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        if (state == .high) {
            cpu.sbi(regs(pin).port_addr, pin.pin);
        } else {
            cpu.cbi(regs(pin).port_addr, pin.pin);
        }
    }

    pub fn toggle(comptime pin: type) void {
        cpu.sbi(regs(pin).pin_addr, pin.pin);
    }
};
