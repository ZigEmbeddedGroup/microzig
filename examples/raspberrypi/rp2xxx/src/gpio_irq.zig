const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const led = gpio.num(25);
const button = gpio.num(9);

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

const MAGICREBOOTCODE: u8 = 0xAB;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    // This function has to handle both cpus if BANK0 interrupts are enabled on both.
    .interrupts = .{ .IO_IRQ_BANK0 = .{ .c = callback_alt } },
};

// used as event flag to keep IRQ handler fast
var event: ?gpio.IrqTrigger = null;

/// GPIO IRQ callback defined here.
/// It will iterate through all pins/ events that are triggered
/// No debounce featured
/// Added to .ram_text section so it always executes quickly from RAM (vs Flash)
/// only sets the last one to event flag (others would be dropped if there are multiple)
fn callback_alt() linksection(".ram_text") callconv(.c) void {
    var iter = gpio.IrqEventIter{};
    while (iter.next()) |e| {
        event = e;
    }
}

pub fn main() !void {
    // Setup LED for blinking
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    // Enable GPIO button & interrupt
    button.set_function(.sio);
    button.set_direction(.in);
    button.set_pull(.up);
    button.set_irq(gpio.IrqEvents{ .fall = 1, .rise = 1 }, true);
    microzig.interrupt.enable(.IO_IRQ_BANK0);

    // Setup uart for logging and fast reset to bootloader
    uart_tx_pin.set_function(.uart);
    uart_rx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // Initialize the loop
    var i: u32 = 0;
    var next_time = time.get_time_since_boot().add_duration(.from_ms(500));
    while (true) {
        if (event) |e| {
            std.log.info("Callback happened! gpio{d} events: {}", .{ e.pin, e.events });
            event = null;
        }
        uart_read() catch {}; // Check for the reboot code.  Ignore errors.
        if (next_time.is_reached_by(time.get_time_since_boot())) {
            next_time = time.get_time_since_boot().add_duration(.from_ms(500));
            std.log.info("tick {}", .{i});
            led.toggle();
            i += 1;
        }
    }
}

fn uart_read() !void {
    const v = uart.read_word() catch {
        uart.clear_errors();
        return;
    };
    if (v == MAGICREBOOTCODE) {
        std.log.warn("Reboot cmd received", .{});
        microzig.hal.rom.reset_to_usb_boot();
    }
}
