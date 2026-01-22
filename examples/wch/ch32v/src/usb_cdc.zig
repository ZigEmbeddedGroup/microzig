const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;
const time = hal.time;
const gpio = hal.gpio;

pub const usb = @import("usbhs.zig");

const RCC = microzig.chip.peripherals.RCC;
const AFIO = microzig.chip.peripherals.AFIO;

const usart = hal.usart.instance.USART1;
const usart_tx_pin = gpio.Pin.init(0, 9); // PA9

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

pub const UsbSerial = microzig.core.usb.drivers.cdc.CdcClassDriver(.{ .max_packet_size = 512 });

pub var usb_dev: usb.Polled(
    microzig.core.usb.Config{
        .device_descriptor = .{
            .bcd_usb = .from(0x0200),
            .device_triple = .{
                .class = .Miscellaneous,
                .subclass = 2,
                .protocol = 1,
            },
            .max_packet_size0 = 64,
            .vendor = .from(0x2E8A),
            .product = .from(0x000A),
            .bcd_device = .from(0x0100),
            .manufacturer_s = 1,
            .product_s = 2,
            .serial_s = 3,
            .num_configurations = 1,
        },
        .string_descriptors = &.{
            .from_lang(.English),
            .from_str("MicroZig"),
            .from_str("ch32v307 Test Device"),
            .from_str("someserial"),
            .from_str("Board CDC"),
        },
        .configurations = &.{.{
            .num = 1,
            .configuration_s = 0,
            .attributes = .{ .self_powered = true },
            .max_current_ma = 100,
            .Drivers = struct { serial: UsbSerial },
        }},
        .debug = false,
    },
    .{ .prefer_high_speed = true },
) = undefined;

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();
    microzig.hal.init();

    // Enable peripheral clocks for USART2 and GPIOA
    RCC.APB2PCENR.modify(.{
        .IOPAEN = 1, // Enable GPIOA clock
        .AFIOEN = 1, // Enable AFIO clock
        .USART1EN = 1, // Enable USART1 clock
    });
    RCC.APB1PCENR.modify(.{
        .USART2EN = 1, // Enable USART2 clock
    });

    // Ensure USART2 is NOT remapped (default PA2/PA3, not PD5/PD6)
    AFIO.PCFR1.modify(.{ .USART2_RM = 0 });

    // Configure PA2 as alternate function push-pull for USART2 TX
    usart_tx_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{ .baud_rate = 921600 });

    hal.usart.init_logger(usart);
    std.log.info("UART logging initialized.", .{});

    std.log.info("Initializing USB device.", .{});

    usb_dev = .init();
    // microzig.cpu.interrupt.enable(.USBHS);

    var last = time.get_time_since_boot();
    var i: u32 = 0;
    while (true) : (i += 1) {
        const now = time.get_time_since_boot();
        if (now.diff(last).to_us() > 1000000) {
            // std.log.info("what {}", .{i});
            std.log.debug("usb drivers available?: {}", .{usb_dev.controller.drivers() != null});
            last = now;
        }
        run_usb();
    }
}

var usb_tx_buff: [1024]u8 = undefined;

// Transfer data to host
// NOTE: After each USB chunk transfer, we have to call the USB task so that bus TX events can be handled
pub fn usb_cdc_write(serial: *UsbSerial, comptime fmt: []const u8, args: anytype) void {
    const text = std.fmt.bufPrint(&usb_tx_buff, fmt, args) catch &.{};

    var write_buff = text;
    while (write_buff.len > 0) {
        write_buff = write_buff[serial.write(write_buff)..];
        // _ = serial.flush();
        usb_dev.poll();
    }
}

var usb_rx_buff: [1024]u8 = undefined;

// Receive data from host
// NOTE: Read code was not tested extensively. In case of issues, try to call USB task before every read operation
pub fn usb_cdc_read(
    serial: *UsbSerial,
) []const u8 {
    var total_read: usize = 0;
    var read_buff: []u8 = usb_rx_buff[0..];

    while (true) {
        const len = serial.read(read_buff);
        read_buff = read_buff[len..];
        total_read += len;
        if (len == 0) break;
    }

    return usb_rx_buff[0..total_read];
}

pub fn run_usb() void {
    if (usb_dev.controller.drivers()) |drivers| {
        std.log.info("USB CDC Demo transmitting", .{});
        usb_cdc_write(&drivers.serial, "This is very very long text sent from ch32 by USB CDC to your device: {s}\r\n", .{"Hello, World!"});

        // read and print host command if present
        const message = usb_cdc_read(&drivers.serial);
        if (message.len > 0) {
            usb_cdc_write(&drivers.serial, "Your message to me was: {s}\r\n", .{message});
        }
    }
    usb_dev.poll();
}
