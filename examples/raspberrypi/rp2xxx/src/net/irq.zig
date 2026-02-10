/// Interrupt line is multiplexed with MOSI and MISO SPI lines, so it requires a
/// little special handling.
///
/// Interrupt is disabled during SPI read/write. It should be disabled in the
/// callback handler to prevent storm of interrputs. That is done in
/// `is_packet_ready_interrupt`. Reading packet data will re-enable intterrupt
/// when the last packet is read.
///
const std = @import("std");
const microzig = @import("microzig");
const cpu = microzig.cpu;
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = rp2xxx.drivers;
const system_timer = rp2xxx.system_timer;
const chip = rp2xxx.compatibility.chip;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const rp2040_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .interrupts = .{
        .IO_IRQ_BANK0 = .{ .c = gpio_interrupt },
        .TIMER_IRQ_0 = .{ .c = timer_interrupt },
    },
};
pub const rp2350_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .interrupts = .{
        .IO_IRQ_BANK0 = .{ .c = gpio_interrupt },
        .TIMER0_IRQ_0 = .{ .c = timer_interrupt },
    },
};
const timer_irq = if (chip == .RP2040) .TIMER_IRQ_0 else .TIMER0_IRQ_0;
pub const microzig_options = if (chip == .RP2040) rp2040_options else rp2350_options;
const timer = system_timer.num(0);

const log = std.log.scoped(.main);

comptime {
    _ = @import("lwip_exports.zig");
}
const net = @import("net");
const secrets = @import("secrets.zig");

var wifi_driver: drivers.WiFi = .{};

pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // Enable gpio interrupt callback
    microzig.interrupt.enable(.IO_IRQ_BANK0);
    // Enable timer interrupt callback
    microzig.cpu.interrupt.enable(timer_irq);
    timer.set_interrupt_enabled(.alarm0, true);

    // Init wifi_driver with interrupt handling enabled
    var wifi = try wifi_driver.init(.{ .handle_irq = true });
    _ = try wifi.join(secrets.ssid, secrets.pwd, secrets.join_opt);
    var led = wifi.gpio(0);

    var nic: net.Interface = .{ .link = wifi.link() };
    try nic.init(wifi.mac, try secrets.nic_options());

    timer.schedule_alarm(.alarm0, timer.read_low() +% tick_interval_ms * 1000);
    while (true) {
        // get and reset wakeup source
        const src = wakeup_source;
        wakeup_source = .{};

        if (src.wifi) {
            // Interrupt will be enabled after last packet is read
            try nic.poll();
            log.debug("{}", .{nic.stat});
        }
        if (src.tick) {
            nic.tick();
            if (nic.stat.tick_count % 5 == 0) {
                led.toggle();
            }
        }
        cpu.wfe();
    }
}

const tick_interval_ms = 50;

var wakeup_source: packed struct {
    wifi: bool = false,
    tick: bool = false,
} = .{};

fn gpio_interrupt() linksection(".ram_text") callconv(.c) void {
    // Disable interrupts storm, store source and wake up main loop.
    wifi_driver.disable_irq();
    wakeup_source.wifi = true;
    cpu.sev();

    // // If there are multiple triggers use `disable_irq_if` in the triggers
    // // iterator. It will disable interrupt wifi_driver is the source of
    // // interrupt, returns true in that case otherwise false.
    // var iter = gpio.IrqEventIter{};
    // while (iter.next()) |trg| {
    //     if (wifi_driver.disable_irq_if(trg)) {
    //         wakeup_source.packet_ready = true;
    //         cpu.sev();
    //         return;
    //     }
    // }
}

fn timer_interrupt() linksection(".ram_text") callconv(.c) void {
    wakeup_source.tick = true;
    cpu.sev();
    timer.clear_interrupt(.alarm0);
    timer.schedule_alarm(.alarm0, timer.read_low() +% tick_interval_ms * 1000);
}
