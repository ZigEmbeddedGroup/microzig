pub const cpu = @import("cpu");
pub const micro = @import("microzig");
pub const chip = @import("registers.zig");
const micro = @import("microzig");
const regs = chip.registers;

pub usingnamespace chip;

pub const clock_frequencies = .{
    .cpu = 8_000_000,
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'E')
        @compileError(invalid_format_msg);

    const _regs = struct {
        const name_suffix = std.fmt.comptimePrint("{d}", .{_port});

        const pinsel_reg = @field(regs.CRC, sel_reg_name);
        const pinsel_field = std.fmt.comptimePrint("P{d}_{d}", .{ _port, _pin });

        const dir = @field(regs.GPIO, "DIR" ++ name_suffix);
        const pin = @field(regs.GPIO, "PIN" ++ name_suffix);
        const set = @field(regs.GPIO, "SET" ++ name_suffix);
        const clr = @field(regs.GPIO, "CLR" ++ name_suffix);
        const mask = @field(regs.GPIO, "MASK" ++ name_suffix);
    };
    return struct {
        const pin_number: comptime_int = @import("std").fmt.parseInt(u3, spec[2..], 10) catch @compileError(invalid_format_msg);
        /// 'A'...'E'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(regs, "GPIO" ++ gpio_port_name);
        const suffix = @import("std").fmt.comptimePrint("{d}", .{pin_number});
    };
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        pin.regs.dir.raw |= pin.gpio_mask;
    }
    pub fn setInput(comptime pin: type) void {
        pin.regs.dir.raw &= ~pin.gpio_mask;
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        return if ((pin.regs.pin.raw & pin.gpio_mask) != 0)
            micro.gpio.State.high
        else
            micro.gpio.State.low;
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        if (state == .high) {
            pin.regs.set.raw = pin.gpio_mask;
        } else {
            pin.regs.clr.raw = pin.gpio_mask;
        }
    }
};

pub fn Uart(comptime index: usize, comptime pins: micro.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const UARTn = switch (index) {
            0 => regs.UART3,
            1 => regs.UART4,
            else => @compileError("GD32VF103 has 2 UARTs available."),
        };
        const Self = @This();
    };
}
