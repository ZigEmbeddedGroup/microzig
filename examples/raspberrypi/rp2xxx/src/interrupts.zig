const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const peripherals = microzig.chip.peripherals;
const interrupt = microzig.cpu.interrupt;

const led = rp2xxx.gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = rp2xxx.gpio.num(0);

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
    .interrupts = .{
        .TIMER_IRQ_0 = .{ .c = timer_interrupt },
    },
};

fn timer_interrupt() callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    std.log.info("toggle led!", .{});
    led.toggle();

    switch (rp2xxx.compatibility.chip) {
        // These registers are write-to-clear
        .RP2040 => peripherals.TIMER.INTR.modify(.{ .ALARM_0 = 1 }),
        .RP2350 => peripherals.TIMER0.INTR.modify(.{ .ALARM_0 = 1 }),
    }
    set_alarm(1_000_000);
}

pub fn set_alarm(us: u32) void {
    const Duration = microzig.drivers.time.Duration;
    const current = time.get_time_since_boot();
    const target = current.add_duration(Duration.from_us(us));
    switch (rp2xxx.compatibility.chip) {
        .RP2040 => peripherals.TIMER.ALARM0.write_raw(@intCast(@intFromEnum(target) & 0xffffffff)),
        .RP2350 => peripherals.TIMER0.ALARM0.write_raw(@intCast(@intFromEnum(target) & 0xffffffff)),
    }
}

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);

    set_alarm(1_000_000);

    switch (rp2xxx.compatibility.chip) {
        .RP2040 => {
            peripherals.TIMER.INTE.toggle(.{ .ALARM_0 = 1 });
            interrupt.enable(.TIMER_IRQ_0);
        },
        .RP2350 => {
            peripherals.TIMER0.INTE.toggle(.{ .ALARM_0 = 1 });
            switch (rp2xxx.compatibility.arch) {
                .arm => interrupt.enable(.TIMER0_IRQ_0),
                .riscv => {
                    interrupt.enable(.MachineExternal);
                    interrupt.external.enable(.TIMER0_IRQ_0);
                },
            }
        },
    }

    microzig.cpu.interrupt.enable_interrupts();

    while (true) {
        asm volatile ("wfi");
    }
}
