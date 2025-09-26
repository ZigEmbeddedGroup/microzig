//NOTE: This is just an experimental test, USB HAL for the F1 family is not complete.
//NOTE: THIS EXAMPLE ONLY RUNS IN RELEASE BUILDS, debug builds add too much overhead and USB ends up missing response timing

const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const time = stm32.time;
const Duration = microzig.drivers.time.Duration;
const usb_ll = stm32.usb.usb_ll;
const usb_utils = stm32.usb.usb_utils;

const EpControl = usb_ll.EpControl;

const interrupt = microzig.interrupt;
var Counter: stm32.drivers.CounterDevice = undefined;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .USB_LP_CAN1_RX0 = .{ .c = usb_ll.usb_handler } },
};

// ============== HID Descriptor ================
const DeviceDescriptor = [_]u8{
    0x12, // bLength
    0x01, // bDescriptorType (Device)
    0x00, 0x02, // bcdUSB 2.00
    0xEF, // bDeviceClass (misc class)
    0x02, // bDeviceSubClass (Common)
    0x01, // bDeviceProtocol (IAD)
    0x40, // bMaxPacketSize0
    0x55, 0xF0, // idVendor FOSS
    0x00, 0x98, // idProduct (0x9800) CDC
    0x00, 0x01, // bcdDevice 1.00
    0x01, // iManufacturer
    0x02, // iProduct
    0x03, // iSerialNumber
    0x01, // bNumConfigurations
};
const langID = [_]u8{ 0x04, 0x03, 0x09, 0x04 };
const prod_id = usb_utils.string_to_descriptor("STM32 CDC example");
const manu_id = usb_utils.string_to_descriptor("MicroZig");
const serial_id = usb_utils.string_to_descriptor("12345");

// USB Configuration Descriptor
const ConfigDescriptor = [_]u8{
    // Configuration Descriptor
    0x09, 0x02, // bLength, bDescriptorType
    0x4B, 0x00, // wTotalLength (75 bytes)
    0x02, // bNumInterfaces
    0x01, // bConfigurationValue
    0x00, // iConfiguration
    0xC0, // bmAttributes: self powered
    0x32, // MaxPower: 100 mA

    // Interface Association Descriptor (IAD)
    0x08, 0x0B, // bLength, bDescriptorType = IAD
    0x00, // bFirstInterface
    0x02, // bInterfaceCount
    0x02, // bFunctionClass: Communications
    0x02, // bFunctionSubClass: Abstract Control Model
    0x00, // bFunctionProtocol: none
    0x00, // iFunction

    // Interface Descriptor (Communication Interface)
    0x09, 0x04, // bLength, bDescriptorType
    0x00, // bInterfaceNumber
    0x00, // bAlternateSetting
    0x01, // bNumEndpoints
    0x02, // bInterfaceClass: Communications
    0x02, // bInterfaceSubClass: Abstract Control Model
    0x00, // bInterfaceProtocol: none
    0x00, // iInterface

    // CDC Header Functional Descriptor
    0x05, 0x24, 0x00, 0x10, 0x01, // bFunctionLength, bDescriptorType, bDescriptorSubType, CDC version

    // CDC ACM Functional Descriptor
    0x04, 0x24, 0x02, 0x06, // bmCapabilities

    // CDC Call Management Functional Descriptor
    0x05, 0x24, 0x01, 0x02, 0x02, // bmCapabilities, bDataInterface

    // CDC Union Functional Descriptor
    0x05, 0x24, 0x06, 0x00, 0x01, // bMasterInterface, bSlaveInterface0

    // Endpoint Descriptor (Interrupt IN)
    0x07, 0x05, // bLength, bDescriptorType
    0x81, // bEndpointAddress: IN, EP1
    0x03, // bmAttributes: Interrupt
    0x40, 0x00, // wMaxPacketSize: 64
    0x01, // bInterval: 1

    // Interface Descriptor (Data Interface)
    0x09, 0x04, // bLength, bDescriptorType
    0x01, // bInterfaceNumber
    0x00, // bAlternateSetting
    0x02, // bNumEndpoints
    0x0A, // bInterfaceClass: CDC Data
    0x00, // bInterfaceSubClass
    0x00, // bInterfaceProtocol
    0x00, // iInterface

    // Endpoint Descriptor (Bulk IN)
    0x07, 0x05, // bLength, bDescriptorType
    0x82, // bEndpointAddress: IN, EP2
    0x02, // bmAttributes: Bulk
    0x40, 0x00, // wMaxPacketSize: 64
    0x00,

    // Endpoint Descriptor (Bulk OUT)
    0x07, 0x05, // bLength, bDescriptorType
    0x03, // bEndpointAddress: OUT, EP3
    0x02, // bmAttributes: Bulk
    0x40, 0x00, // wMaxPacketSize: 64
    0x00, // bInterval
};

const DeviceQualifierDescriptor = [_]u8{
    0x0A, // bLength = 10
    0x06, // bDescriptorType = DEVICE_QUALIFIER (6)
    0x00, 0x02, // bcdUSB = 0x0200 (USB 2.0)
    0x02, // bDeviceClass (idem ao Device Descriptor)
    0x00, // bDeviceSubClass
    0x00, // bDeviceProtocol
    0x40, // bMaxPacketSize0 = 64 bytes
    0x01, // bNumConfigurations = 1
    0x00, // bReserved (sempre 0)
};

const dev_serial_state: [10]u8 = .{ 0xA1, 0x20, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00 };

// ============== HID Descriptor ================

//==========CDC Serial Types ============

const StopBits = enum(u8) {
    @"1" = 0,
    @"1.5" = 1,
    @"2" = 2,
    _,
};

const Parity = enum(u8) {
    None = 0,
    Odd = 1,
    Even = 2,
    Mark = 3,
    Space = 4,
    _,
};

const Encoding = struct {
    baudrate: u32,
    stopbits: StopBits,
    parity: Parity,
    data: u8,

    fn from_pkg(pkg: []const u8) !Encoding {
        if (pkg.len < 7) return error.InvalidEncoding;
        var enc: Encoding = undefined;
        const baudbyte_1: u32 = pkg[3];
        const baudbyte_2: u32 = pkg[2];
        const baudbyte_3: u32 = pkg[1];
        const baudbyte_4: u32 = pkg[0];
        const stp = pkg[4];
        const parity = pkg[5];
        const db = pkg[6];
        enc.baudrate = (baudbyte_1) | (baudbyte_2 << 8) | (baudbyte_3 << 16) | (baudbyte_4 << 24);
        enc.stopbits = @enumFromInt(stp);
        enc.parity = @enumFromInt(parity);
        enc.data = db;
        return enc;
    }
};

const SerialState = packed struct(u8) {
    DTR: u1,
    RTS: u1,
    _res: u6,
};
//==========CDC Serial Types ============

//=============== USB DATA =================
var USB_RX_BUFFER: [64]u8 = undefined;
var CDC_fifo: microzig.utilities.CircularBuffer(u8, 64) = .empty;
var device_addr: ?u7 = null;
var remain_pkg: ?[]const u8 = null;
var config: bool = false;
var CDC_coding: bool = false;
var serial_config: Encoding = undefined;
var serial_state: SerialState = undefined;
var CDC_send: bool = false;
var line_pkg: [7]u8 = .{ 0x00, 0xC2, 0x01, 0x00, 0x00, 0x00, 0x08 };
//=============== USB DATA =================

//=============== USB FUNC =================
fn get_string(index: usize) []const u8 {
    return switch (index) {
        0 => &langID,
        1 => &manu_id,
        2 => &prod_id,
        3 => &serial_id,
        else => &[_]u8{},
    };
}

//TODO port USB driver from RPxxxx USB HAL
fn get_descriptor(setup: []const u8, epc: EpControl) void {
    const descriptor_type = setup[3];
    const descriptor_length: u16 = @as(u16, setup[6]) | (@as(u16, setup[7]) << 8);

    const buffer: []const u8 = switch (descriptor_type) {
        0x01 => &DeviceDescriptor,
        0x02 => &ConfigDescriptor,
        0x03 => get_string(setup[2]),
        0x06 => &DeviceQualifierDescriptor,
        else => return,
    };

    const length = @min(buffer.len, descriptor_length);
    const max = endpoint0.tx_buffer_size;
    if (length < max) {
        epc.USB_send(buffer[0..length], .force_data1) catch unreachable;
    } else {
        epc.USB_send(buffer[0..max], .force_data1) catch unreachable;
        remain_pkg = buffer[max..];
    }
}

fn set_addr(receive_addr: u7, epc: EpControl) void {
    device_addr = receive_addr;
    epc.ZLP(.force_data1) catch unreachable;
}

fn ep0_setup(epc: EpControl, _: ?*anyopaque) void {
    const setup = epc.USB_read(.no_change) catch unreachable;
    if (setup.len != 8) {
        return;
    }

    switch (setup[1]) {
        //Generic USB requests
        0x06 => get_descriptor(setup, epc),
        0x05 => set_addr(@intCast(setup[2]), epc),
        0x09 => {
            epc.ZLP(.force_data1) catch unreachable;
            config = true;
        },

        //CDC request
        0x20 => {
            epc.set_status(.RX, .Valid, .force_data1) catch unreachable;
            CDC_coding = true;
        },
        0x21 => {
            epc.USB_send(&line_pkg, .force_data1) catch unreachable;
        },
        0x22 => {
            epc.ZLP(.force_data1) catch unreachable;
            serial_state = @bitCast(setup[2]);
        },
        else => {
            epc.ZLP(.force_data1) catch unreachable;
        },
    }
}

fn ep0_rx(epc: EpControl, _: ?*anyopaque) void {
    const rev = epc.USB_read(.no_change) catch unreachable;
    if (CDC_coding) {
        const ep1 = usb_ll.EpControl.EPC1;
        epc.ZLP(.force_data1) catch unreachable;
        ep1.USB_send(&dev_serial_state, .force_data0) catch unreachable;

        CDC_coding = false;
        std.mem.copyForwards(u8, &line_pkg, rev);
        serial_config = Encoding.from_pkg(rev) catch unreachable;

        return;
    }
    //epc.set_status(.RX, .Valid, .force_data0) catch unreachable;
}

fn ep0_tx(epc: EpControl, _: ?*anyopaque) void {
    if (device_addr) |addr| {
        usb_ll.set_addr(addr);
        device_addr = null;
    } else if (remain_pkg) |pkg| {
        const length = pkg.len;
        const max = endpoint0.tx_buffer_size;
        if (length < max) {
            epc.USB_send(pkg, .no_change) catch unreachable;
            remain_pkg = null;
        } else {
            epc.USB_send(pkg[0..max], .no_change) catch unreachable;
            remain_pkg = pkg[max..];
        }
        return;
    }
    epc.set_status(.RX, .Valid, .no_change) catch unreachable;
}

fn ep1_tx(epc: EpControl, _: ?*anyopaque) void {
    //This function is responsible for sending the status of our serial device (CTS and RTS)
    //This example does not use these features, so there is nothing to notify the host.

    epc.USB_send(&dev_serial_state, .no_change) catch unreachable;
}

fn ep2_tx(_: EpControl, _: ?*anyopaque) void {
    CDC_send = false;
}

fn ep3_rx(epc: EpControl, _: ?*anyopaque) void {
    const recv = epc.USB_read(.no_change) catch unreachable;
    const free_data = CDC_fifo.get_writable_len();
    const to_write = @min(recv.len, free_data);
    CDC_fifo.write_assume_capacity(recv[0..to_write]);
}

//=============== USB FUNC =================

//================= main example =================
const endpoint0 = usb_ll.Endpoint{
    .ep_control = .EPC0,
    .endpoint = 0,
    .ep_type = .Control,
    .ep_kind = false,
    .rx_reset_state = .Valid,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 2, .block_size = .@"32bytes" },
    .tx_buffer_size = 64,
    .rx_callback = ep0_rx,
    .tx_callback = ep0_tx,
    .setup_callback = ep0_setup,
};

const endpoint1 = usb_ll.Endpoint{
    .ep_control = .EPC1,
    .endpoint = 1,
    .ep_type = .Interrupt,
    .ep_kind = false,
    .rx_reset_state = .Nak,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 0 }, //no RX buffer for IN endpoint
    .tx_buffer_size = 64,
    .tx_callback = ep1_tx,
};

//BULK IN
const endpoint2 = usb_ll.Endpoint{
    .ep_control = .EPC2,
    .endpoint = 2,
    .ep_type = .Bulk,
    .ep_kind = false,
    .rx_reset_state = .Nak,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 0 }, //no RX buffer for IN endpoint
    .tx_buffer_size = 64,
    .tx_callback = ep2_tx,
};

//BULK OUT

const endpoint3 = usb_ll.Endpoint{
    .ep_control = .EPC3,
    .endpoint = 3,
    .ep_type = .Bulk,
    .ep_kind = false,
    .rx_reset_state = .Valid,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 2, .block_size = .@"32bytes" },
    .tx_buffer_size = 0, //no TX buffer for OUT endpoint
    .rx_callback = ep3_rx,
};

const USB_conf = usb_ll.Config{
    .endpoints = &.{ endpoint0, endpoint1, endpoint2, endpoint3 },
    .RX_buffer = &USB_RX_BUFFER,
};

fn CDC_write(msg: []const u8) void {
    const send: *volatile bool = &CDC_send;
    const EP2 = usb_ll.EpControl.EPC2;
    send.* = true;
    EP2.USB_send(msg, .no_change) catch unreachable;
    while (send.*) {
        asm volatile ("nop"); //don't call WFE or WFI here, USB events don't count for wakeup
    }
}

fn CDC_read(buf: []u8, timeout: ?Duration) ![]const u8 {
    const deadline = microzig.drivers.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
    const fifo = &CDC_fifo;
    var index: usize = 0;
    reader: for (buf) |*byte| {
        while (fifo.get_readable_len() == 0) {
            if (deadline.is_reached_by(time.get_time_since_boot())) break :reader;
        }

        byte.* = fifo.pop().?;
        index += 1;
    }
    if (index == 0) {
        return error.Timeout;
    }

    return buf[0..index];
}

pub fn main() !void {
    try rcc.apply_clock(.{
        .PLLSource = .RCC_PLLSOURCE_HSE,
        .PLLMUL = .RCC_PLL_MUL9,
        .SysClkSource = .RCC_SYSCLKSOURCE_PLLCLK,
        .APB1Prescaler = .RCC_HCLK_DIV2,
        .USBPrescaler = .RCC_USBCLKSOURCE_PLL_DIV1_5,
    });

    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.GPIOB);
    rcc.enable_clock(.GPIOC);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.USB);
    time.init_timer(.TIM2);

    const led = gpio.Pin.from_port(.B, 2);
    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    CDC_fifo.reset();

    //NOTE: the stm32f103 does not have an internal 1.5k pull-up resistor for USB, you must add one externally
    usb_ll.usb_init(USB_conf, Duration.from_ms(25));
    var recv_byte: [64]u8 = undefined;
    const conf: *volatile bool = &config;
    while (true) {
        led.toggle();
        if (!conf.*) continue;
        const recv = CDC_read(&recv_byte, Duration.from_ms(10)) catch continue;
        CDC_write(recv);
    }
}
