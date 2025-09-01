//External Interrupts (exti) Example for STM32F1xx
//This example demonstrates how to configure an external interrupt on a GPIO pin
//and toggle an LED when the interrupt is triggered.

const microzig = @import("microzig");
const hal = microzig.hal;
const gpio = hal.gpio;
const rcc = hal.rcc;
const exti = hal.exti;

const led = hal.gpio.Pin.from_port(.B, 2);
const input = hal.gpio.Pin.from_port(.B, 9);

//define the EXTI handler
pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .EXTI9_5 = .{ .c = EXTI_handler },
    },
};

fn EXTI_handler() callconv(.c) void {
    // we have only one line configured, so we can just clear it
    // if you have more than one line configured, you should check the pending lines
    exti.clear_pending(exti.pending());
    led.toggle();
}

pub fn main() !void {
    // Enable clocks for GPIOB and AFIO
    hal.rcc.enable_clock(.AFIO);
    hal.rcc.enable_clock(.GPIOB);

    // Configure the LED pin as output
    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);

    // Configure the input pin as input with pull-up
    input.set_input_mode(.pull);
    input.set_pull(.up);

    // Configure the EXTI line for PB9 with falling edge trigger
    exti.apply_line(.{
        .line = 9,
        .port = .B,
        .trigger = .falling,
        .interrupt = true, //enable interrupt imamediately (you can also enable it later if you want)
        .event = false, //no event for this example
    });

    //enable NVIC for EXTI9_5 and enable interrupts globally
    microzig.interrupt.enable(.EXTI9_5);
    microzig.interrupt.enable_interrupts();

    // Main loop does nothing, waiting for interrupts
    while (true) {
        asm volatile ("wfi"); // Wait for interrupt
    }
}
