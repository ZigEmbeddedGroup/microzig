const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;
const time = hal.time;
const gpio = hal.gpio;

pub const usb = @import("usbhs.zig");

const USB_Serial = microzig.core.usb.drivers.CDC;

const RCC = microzig.chip.peripherals.RCC;
const AFIO = microzig.chip.peripherals.AFIO;
const PFIC = microzig.chip.peripherals.PFIC;

const usart = hal.usart.instance.USART1;
const usart_tx_pin = gpio.Pin.init(0, 9); // PA9

const mco_pin = gpio.Pin.init(0, 8); // PA9

pub const my_interrupts: microzig.cpu.InterruptOptions = .{
    // .TIM2 = time.tim2_handler,
    .USBHS = usbhs_interrupt_handler,
};

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
    .interrupts = my_interrupts,
};

pub fn usbhs_interrupt_handler() callconv(microzig.cpu.riscv_calling_convention) void {
    // usb_dev.poll(true);
    // std.log.debug("usb isr called", .{});
}

fn usb_poll() void {
    // microzig.cpu.interrupt.disable(.USBHS);
    usb_dev.poll(false, &usb_controller);
    // microzig.cpu.interrupt.enable(.USBHS);
}

const USBController = microzig.core.usb.DeviceController(.{
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

pub var usb_dev: usb.Polled(
    .{ .prefer_high_speed = true },
) = undefined;

var usb_controller: USBController = .init;

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();
    microzig.hal.init();
    // RCC.CFGR0.modify(.{ .MCO = 0b0100 });
    // Enable peripheral clocks for USART2 and GPIOA
    RCC.APB2PCENR.modify(.{
        .IOPAEN = 1, // Enable GPIOA clock
        .AFIOEN = 1, // Enable AFIO clock
        .USART1EN = 1, // Enable USART1 clock
    });

    // Ensure USART2 is NOT remapped (default PA2/PA3, not PD5/PD6)
    AFIO.PCFR1.modify(.{ .USART2_RM = 0 });

    // Configure PA2 as alternate function push-pull for USART2 TX
    usart_tx_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // mco_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{ .baud_rate = 921600 });
    comptime {
        const sysclk: comptime_float = 144_000_000;
        const hb: comptime_float = 1.0;
        const pb2: comptime_float = 1.0;
        const pclk = (sysclk / hb) / pb2;
        if (!usart.validate_baudrate(921600, pclk, 1.0)) {
            @compileError("Bad baud rate");
        }
    }

    hal.usart.init_logger(usart);
    std.log.info("UART logging initialized.", .{});

    std.log.info("Initializing USB device.", .{});

    usb_dev = .init();
    // microzig.cpu.interrupt.enable(.USBHS);
    PFIC.IPRIOR70 = 255;
    var last = time.get_time_since_boot();
    var i: u32 = 0;

    while (true) {
        const now = time.get_time_since_boot();
        if (now.diff(last).to_us() > 100_000) {
            run_usb(i);
            i += 1;
            last = now;
        }
        usb_poll();
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
        usb_poll();
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

fn intToHexChar(i: u4) u8 {
    // Ensure the input is within the 0-15 range
    std.debug.assert(i <= 15);

    const base: u8 = if (i < 10) '0' else 'A';
    const offset: u8 = if (i < 10) 0 else 10;
    return @intCast(@as(u8, @intCast(base)) + @as(u8, @intCast(i)) - offset);
}

pub fn run_usb(i: u32) void {
    // _ = i;
    if (usb_controller.drivers()) |drivers| {
        const freqs = hal.clocks.get_freqs();
        usb_cdc_write(&drivers.serial, "what {}: sysclk {}, hclk {}, pclk1 {}, PFIC.IPRIOR70 {}\r\n", .{ i, freqs.sysclk, freqs.hclk, freqs.pclk1, PFIC.IPRIOR70 });

        // read and print host command if present
        const message = usb_cdc_read(&drivers.serial);
        if (message.len > 0) {
            usb_cdc_write(&drivers.serial, "Your message to me was: {s}\r\n", .{message});
        }
    }
}
