const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

const led = rp2xxx.gpio.num(0);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = rp2xxx.gpio.num(12);
const uart_rx_pin = rp2xxx.gpio.num(13);

pub const microzig_options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};

pub const interrupts = .{
    .TIMER0_IRQ_0 = TIMER0_IRQ_0,
};

fn TIMER0_IRQ_0() callconv(.C) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    std.log.info("toggle led!", .{});
    led.toggle();

    microzig.chip.peripherals.TIMER0.INTR.toggle(.{ .ALARM_0 = 0 });
    set_alarm(1_000_000);
}

pub fn set_alarm(us: u32) void {
    const Duration = microzig.drivers.time.Duration;
    const current = time.get_time_since_boot();
    const target = current.add_duration(Duration.from_us(us));
    microzig.chip.peripherals.TIMER0.ALARM0.write_raw(@intCast(@intFromEnum(target) & 0xffffffff));
}

pub fn main() !void {
    // init uart logging
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart_first);
    }

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);

    set_alarm(1_000_000);

    microzig.chip.peripherals.TIMER0.INTE.toggle(.{ .ALARM_0 = 1 });
    if (rp2xxx.compatibility.arch == .riscv) {
        microzig.cpu.enable(.MachineExternal);
    }
    microzig.cpu.enable(.TIMER0_IRQ_0);
    microzig.cpu.enable_interrupts();

    while (true) {
        asm volatile ("wfi");
    }
}
