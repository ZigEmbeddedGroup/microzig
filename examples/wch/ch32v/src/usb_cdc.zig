const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;
const time = hal.time;
const gpio = hal.gpio;
const usb = microzig.core.usb;

const USB_Serial = usb.drivers.CDC;

const RCC = microzig.chip.peripherals.RCC;
const AFIO = microzig.chip.peripherals.AFIO;
const PFIC = microzig.chip.peripherals.PFIC;

const usart = hal.usart.instance.USART1;

const usart_tx_pin = gpio.Pin.init(0, 9); // PA9

pub const microzig_options = microzig.Options{
    .logFn = hal.usart.log,
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_cdc, .level = .warn },
    },
};

const USBController = usb.DeviceController(.{
    .bcd_usb = .v2_00,
    .device_triple = .unspecified,
    .vendor = .{ .id = 0x2E8A, .str = "MicroZig" },
    .product = .{ .id = 0x000A, .str = "ch32v307 Test Device" },
    .bcd_device = .v1_00,
    .serial = "someserial",
    .max_supported_packet_size = 512,
    .configurations = &.{.{
        .attributes = .{ .self_powered = false },
        .max_current_ma = 50,
        .Drivers = struct { serial: USB_Serial },
    }},
}, .{.{
    .serial = .{ .itf_notifi = "Board CDC", .itf_data = "Board CDC Data" },
}});

pub var usb_dev: hal.usbhs.Polled(
    .{ .prefer_high_speed = true },
) = undefined;

var usb_controller: USBController = .init;

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();
    microzig.hal.init();

    // Enable peripheral clocks for USART1 and GPIOA
    RCC.APB2PCENR.modify(.{
        .IOPAEN = 1, // Enable GPIOA clock
        .AFIOEN = 1, // Enable AFIO clock
        .USART1EN = 1, // Enable USART1 clock
    });

    // Configure TX pin as alternate function push-pull
    usart_tx_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // Initialize USART1 at 115200 baud
    usart.apply(.{ .baud_rate = 115200 });

    hal.usart.init_logger(usart);
    std.log.info("UART logging initialized.", .{});

    std.log.info("Initializing USB device.", .{});

    usb_dev = .init();

    var i: u32 = 0;
    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;

    while (true) {
        if (usb_controller.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 500000) {
                old = new;
                i += 1;
                std.log.info("cdc test: {}", .{i});

                usb_cdc_write(&drivers.serial, "This is very very very very very very very very long text sent from ch32v30x by USB CDC to your device: {}\r\n", .{i});
            }

            // read and print host command if present
            const message = usb_cdc_read(&drivers.serial);
            if (message.len > 0) {
                usb_cdc_write(&drivers.serial, "Your message to me was: {s}\r\n", .{message});
            }
        }
        usb_dev.poll(false, &usb_controller);
    }
}

var usb_tx_buff: [1024]u8 = undefined;

// Transfer data to host
// NOTE: After each USB chunk transfer, we have to call the USB task so that bus TX events can be handled
pub fn usb_cdc_write(serial: *USB_Serial, comptime fmt: []const u8, args: anytype) void {
    const text = std.fmt.bufPrint(&usb_tx_buff, fmt, args) catch &.{};
    var write_buff = text;
    while (write_buff.len > 0) {
        write_buff = write_buff[serial.write(write_buff)..];
        while (!serial.flush())
            usb_dev.poll(false, &usb_controller);
    }
}

var usb_rx_buff: [1024]u8 = undefined;

// Receive data from host
// NOTE: Read code was not tested extensively. In case of issues, try to call USB task before every read operation
pub fn usb_cdc_read(
    serial: *USB_Serial,
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
