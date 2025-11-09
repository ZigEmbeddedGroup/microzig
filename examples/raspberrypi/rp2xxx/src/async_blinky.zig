const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const get_time_since_boot = rp2xxx.time.get_time_since_boot;
const Io = rp2xxx.Io;

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.log,
};

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO0 = .{ .function = .UART0_TX },
    .GPIO25 = .{
        .name = "led",
        .direction = .out,
    },
};

const pins = pin_config.pins();
const uart = rp2xxx.uart.instance.num(0);

// Blink the led with given half-period.
fn task_blink(io: *Io.RoundRobin, delay: u32) callconv(.c) noreturn {
    var deadline: time.Absolute = get_time_since_boot();
    while (true) {
        pins.led.toggle();
        deadline = deadline.add_duration(.from_us(delay));
        io.pause(&.{ .sleep_until = deadline });
    }
}

pub fn main() !void {
    pin_config.apply();
    uart.apply(.{ .baud_rate = 1_000_000, .clock_config = rp2xxx.clock_config });
    rp2xxx.uart.init_logger(uart);

    // Set up stacks. A helper function that automates this would be nice.
    const max_tasks = 8;
    var task_stacks_data: [max_tasks][1024]usize = undefined;
    var task_stacks: [max_tasks]*Io.PauseReason = undefined;
    for (&task_stacks, &task_stacks_data) |*dst, *src|
        dst.* = Io.prepare_empty_stack(src);

    var io: Io.RoundRobin = .{ .next_swap = 0, .tasks = &task_stacks };

    // Mixing (xoring) two squarewaves of almost the same frequency produces a beat frequency.
    io.async(task_blink, .{ &io, 24_000 });
    io.async(task_blink, .{ &io, 25_000 });

    var deadline: time.Absolute = get_time_since_boot();
    var cnt: u32 = 0;
    while (true) {
        try uart.writer().print("Hello! {}\r\n", .{cnt});
        cnt += 1;
        deadline = deadline.add_duration(.from_ms(1000));
        io.pause(&.{ .sleep_until = deadline });
    }
}
