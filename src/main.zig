const std = @import("std");
const lpc1768 = @import("lpc1768.zig");

const InterruptVector = fn () callconv(.C) void;
const Vectors = struct {
    reset: InterruptVector = _start,
    nmi: InterruptVector = unhandledInterrupt,
    hard_fault: InterruptVector = unhandledInterrupt,
    mpu_fault: InterruptVector = unhandledInterrupt,
    bus_fault: InterruptVector = unhandledInterrupt,
    usage_fault: InterruptVector = unhandledInterrupt,

    checksum: u32 = undefined,
};

export const vectors linksection(".isr_vector") = Vectors{};

fn unhandledInterrupt() callconv(.C) noreturn {
    @panic("unhandled interrupt");
}

fn GPIO(comptime spec: []const u8) type {
    if (spec[0] != 'P' or spec[2] != '.')
        return @compileError("Invalid gpio format!");

    const _port = std.fmt.parseInt(u3, spec[1..2], 10) catch @compileError("Invalid gpio format!");
    const _pin = std.fmt.parseInt(u5, spec[3..], 10) catch @compileError("Invalid gpio format!");

    return struct {
        const gpio = @intToPtr(*volatile lpc1768.GPIO, 0x2009C000 + 0x20 * @as(u32, _port));
        const port = _port;
        const pin = _pin;
        const mask: u32 = (1 << pin);

        fn makeOutput() void {
            gpio.dir |= mask;
        }

        fn set() void {
            gpio.set = mask;
        }

        fn clear() void {
            gpio.clr = mask;
        }

        fn toggle() void {
            if ((gpio.pin & mask) != 0)
                clear()
            else
                set();
        }
    };
}

const led_1 = GPIO("P1.18");
const led_2 = GPIO("P1.20");
const led_3 = GPIO("P1.21");
const led_4 = GPIO("P1.23");

fn busyloop() void {
    var foo: u32 = 1_000_000;
    while (foo > 0) : (foo -= 1) {
        asm volatile (""
            :
            : [_] "r" (foo)
        );
    }
}

export fn _start() callconv(.C) noreturn {
    led_1.makeOutput();
    led_2.makeOutput();
    led_3.makeOutput();
    led_4.makeOutput();

    while (true) {
        led_1.toggle();
        led_2.set();
        led_3.clear();
        led_4.clear();
        busyloop();

        led_1.toggle();
        led_2.clear();
        led_3.set();
        led_4.clear();
        busyloop();

        led_1.toggle();
        led_2.clear();
        led_3.clear();
        led_4.set();
        busyloop();
    }
}

pub fn panic(msg: []const u8, stack_trace: ?*std.builtin.StackTrace) noreturn {
    while (true) {}
}
