const microzig = @import("microzig");
const hal = microzig.hal;

pub const microzig_options = microzig.Options{
    .interrupts = .{ .GPIO3 = .{ .c = gpio3_irq_handler } },
};

const port3 = hal.port.init(3);
const pin_led_red = port3.get_gpio(12);
const pin_button = port3.get_gpio(29);

pub fn main() void {
    microzig.interrupt.enable_interrupts();
    microzig.interrupt.enable(.GPIO3);

    port3.init();

    pin_led_red.init();
    pin_led_red.set_direction(.out);
    pin_led_red.put(1);

    pin_button.init();
    pin_button.set_direction(.in);
    pin_button.set_interrupt_config(.interrupt_rising_edge);

    while (true) {
        const is_pressed: *volatile bool = &button_pressed;
        if (is_pressed.*) {
            pin_led_red.toggle();
            is_pressed.* = false;
        }
    }
}

var button_pressed: bool = false;
fn gpio3_irq_handler() callconv(.c) void {
    pin_button.clear_interrupt_flag();

    const is_pressed: *volatile bool = &button_pressed;
    is_pressed.* = true;
}
