const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const peripherals = microzig.chip.peripherals;
const interrupt = microzig.cpu.interrupt;

const led = rp2xxx.gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = rp2xxx.gpio.num(0);

const chip = rp2xxx.compatibility.chip;

const timer = if (chip == .RP2040) peripherals.TIMER else peripherals.TIMER0;
const timer_irq = if (chip == .RP2040) .TIMER_IRQ_0 else .TIMER0_IRQ_0;

pub const rp2040_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .interrupts = .{ .TIMER_IRQ_0 = .{ .c = timer_interrupt } },
};

pub const rp2350_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .interrupts = .{ .TIMER0_IRQ_0 = .{ .c = timer_interrupt } },
};

pub const microzig_options = if (chip == .RP2040) rp2040_options else rp2350_options;

fn timer_interrupt() callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    std.log.info("toggle led!", .{});
    led.toggle();

    timer.INTR.modify(.{ .ALARM_0 = 1 });

    set_alarm(1_000_000);
}

pub fn set_alarm(us: u32) void {
    const Duration = microzig.drivers.time.Duration;
    const current = time.get_time_since_boot();
    const target = current.add_duration(Duration.from_us(us));

    timer.ALARM0.write_raw(@intCast(@intFromEnum(target) & 0xffffffff));
}

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);

    set_alarm(1_000_000);

    timer.INTE.toggle(.{ .ALARM_0 = 1 });

    interrupt.enable(timer_irq);

    // Enable machine external interrupts on RISC-V
    if (rp2xxx.compatibility.arch == .riscv) {
        microzig.cpu.interrupt.core.enable(.MachineExternal);
    }

    microzig.cpu.interrupt.enable_interrupts();

    while (true) {
        asm volatile ("wfi");
    }
}
