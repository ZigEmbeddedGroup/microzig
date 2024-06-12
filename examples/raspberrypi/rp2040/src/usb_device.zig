const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const flash = rp2040.flash;
const time = rp2040.time;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const usb = rp2040.usb;

const led = gpio.num(25);
const uart = rp2040.uart.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

const usb_packet_size = 64;
const usb_config_len = usb.templates.config_descriptor_len + usb.templates.vendor_descriptor_len;
const usb_config_descriptor = 
        usb.templates.config_descriptor(1, 1, 0, usb_config_len, 0xc0, 100) ++
        usb.templates.vendor_descriptor(0, 0, usb.Dir.Out.endpoint(1), usb.Dir.In.endpoint(1), usb_packet_size);

// First we define two callbacks that will be used by the endpoints we define next...
fn ep1_in_callback(dc: *usb.DeviceConfiguration, data: []const u8) void {
    _ = data;
    // The host has collected the data we repeated onto
    // EP1! Set up to receive more data on EP1.
    usb.Usb.callbacks.usb_start_rx(
        dc.endpoints[2], // EP1_OUT_CFG,
        64,
    );
}

fn ep1_out_callback(dc: *usb.DeviceConfiguration, data: []const u8) void {
    // We've gotten data from the host on our custom
    // EP1! Set up EP1 to repeat it.
    usb.Usb.callbacks.usb_start_tx(
        dc.endpoints[3], // EP1_IN_CFG,
        data,
    );
}

// The endpoints EP0_IN and EP0_OUT are already defined but you can
// add your own endpoints to...
pub var EP1_OUT_CFG: usb.EndpointConfiguration = .{
    .descriptor = usb.utils.get_enpoint_descriptor(usb.Dir.Out.endpoint(1), usb_config_descriptor.len, usb_config_descriptor),
    .endpoint_control_index = 2,
    .buffer_control_index = 3,
    .data_buffer_index = 2,
    .next_pid_1 = false,
    // The callback will be executed if we got an interrupt on EP1_OUT
    .callback = ep1_out_callback,
};

pub var EP1_IN_CFG: usb.EndpointConfiguration = .{
    .descriptor = usb.utils.get_enpoint_descriptor(usb.Dir.In.endpoint(1), usb_config_descriptor.len, usb_config_descriptor),
    .endpoint_control_index = 1,
    .buffer_control_index = 2,
    .data_buffer_index = 3,
    .next_pid_1 = false,
    // The callback will be executed if we got an interrupt on EP1_IN
    .callback = ep1_in_callback,
};

// This is our device configuration
pub var DEVICE_CONFIGURATION: usb.DeviceConfiguration = .{
    .device_descriptor = &.{
        .descriptor_type = usb.DescType.Device,
        .bcd_usb = 0x0110,
        .device_class = 0,
        .device_subclass = 0,
        .device_protocol = 0,
        .max_packet_size0 = 64,
        .vendor = 0,
        .product = 1,
        .bcd_device = 0,
        .manufacturer_s = 1,
        .product_s = 2,
        .serial_s = 0,
        .num_configurations = 1,
    },
    .config_descriptors = &usb_config_descriptor,
    .lang_descriptor = "\x04\x03\x09\x04", // length || string descriptor (0x03) || Engl (0x0409)
    .descriptor_strings = &.{
        &usb.utf8ToUtf16Le("Raspberry Pi"),
        &usb.utf8ToUtf16Le("Pico Test Device"),
    },
    // Here we pass all endpoints to the config
    // Dont forget to pass EP0_[IN|OUT] in the order seen below!
    .endpoints = .{
        &usb.EP0_OUT_CFG,
        &usb.EP0_IN_CFG,
        &EP1_OUT_CFG,
        &EP1_IN_CFG,
    },
};

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = .{
    .log_level = .debug,
    .logFn = rp2040.uart.log,
};

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    uart.apply(.{
        .baud_rate = baud_rate,
        .tx_pin = uart_tx_pin,
        .rx_pin = uart_rx_pin,
        .clock_config = rp2040.clock_config,
    });

    rp2040.uart.init_logger(uart);

    // First we initialize the USB clock
    rp2040.usb.Usb.init_clk();
    // Then initialize the USB device using the configuration defined above
    rp2040.usb.Usb.init_device(&DEVICE_CONFIGURATION) catch unreachable;
    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    while (true) {
        // You can now poll for USB events
        rp2040.usb.Usb.task(
            false, // debug output over UART [Y/n]
        ) catch unreachable;

        new = time.get_time_since_boot().to_us();
        if (new - old > 500000) {
            old = new;
            led.toggle();
        }
    }
}
