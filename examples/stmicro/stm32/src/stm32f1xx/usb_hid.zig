//NOTE: This is just an experimental test, USB HAL for the F1 family is not complete.

const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const flash = microzig.chip.peripherals.FLASH;
const rcc_v1 = microzig.chip.types.peripherals.rcc_f1;
const flash_v1 = microzig.chip.types.peripherals.flash_f1;

const USB = microzig.chip.peripherals.USB;
const USB_v1 = microzig.chip.types.peripherals.usb_v1;

const stm32 = microzig.hal;
const usb_ll = stm32.usb.usb_ll;
const pma = stm32.usb.pma;
const gpio = stm32.gpio;
const timer = stm32.timer.GPTimer.init(.TIM2);

const interrupt = microzig.interrupt;
var Counter: stm32.drivers.CounterDevice = undefined;

// ============== HID Descriptor ================
const DeviceDescriptor = [18]u8{
    0x12, // bLength
    0x01, // bDescriptorType (Device)
    0x10, 0x01, // bcdUSB (USB 1.1)
    0x00, // bDeviceClass (Defined at Interface)
    0x00, // bDeviceSubClass
    0x00, // bDeviceProtocol
    0x40, // bMaxPacketSize0 (64 bytes)
    0x83, 0x04, // idVendor (Exemplo: STM)
    0x75, 0x14, // idProduct (Exemplo: HID Keyboard)
    0x00, 0x01, // bcdDevice (1.00)
    0x01, // iManufacturer (String Index 1)
    0x02, // iProduct (String Index 2)
    0x00, // iSerialNumber (None)
    0x01, // bNumConfigurations
};

const ConfigurationDescriptor = [34]u8{
    // Configuration Descriptor (9 bytes)
    0x09, // bLength
    0x02, // bDescriptorType (Configuration)
    0x22, 0x00, // wTotalLength (34 bytes)
    0x01, // bNumInterfaces
    0x01, // bConfigurationValue
    0x00, // iConfiguration (None)
    0x80, // bmAttributes (Bus Powered)
    0x32, // bMaxPower (100 mA)

    // Interface Descriptor (9 bytes)
    0x09, // bLength
    0x04, // bDescriptorType (Interface)
    0x00, // bInterfaceNumber
    0x00, // bAlternateSetting
    0x01, // bNumEndpoints
    0x03, // bInterfaceClass (HID)
    0x01, // bInterfaceSubClass (Boot Interface)
    0x01, // bInterfaceProtocol (Keyboard)
    0x00, // iInterface (None)

    // HID Descriptor (9 bytes)
    0x09, // bLength
    0x21, // bDescriptorType (HID)
    0x11, 0x01, // bcdHID (1.11)
    0x00, // bCountryCode (Not Supported)
    0x01, // bNumDescriptors
    0x22, // bDescriptorType (Report)
    0x3F, 0x00, // wDescriptorLength (62 bytes)

    // Endpoint Descriptor (7 bytes)
    0x07, // bLength
    0x05, // bDescriptorType (Endpoint)
    0x81, // bEndpointAddress (EP1 IN)
    0x03, // bmAttributes (Interrupt)
    0x08, 0x00, // wMaxPacketSize (8 bytes)
    0x0A, // bInterval (10 ms)
};

const ReportDescriptor = [63]u8{
    0x05, 0x01, // Usage Page (Generic Desktop)
    0x09, 0x06, // Usage (Keyboard)
    0xA1, 0x01, // Collection (Application)

    // Modifier Keys (Shift, Ctrl, Alt, etc)
    0x05, 0x07, // Usage Page (Key Codes)
    0x19, 0xE0, // Usage Minimum (0xE0)
    0x29, 0xE7, // Usage Maximum (0xE7)
    0x15, 0x00, // Logical Minimum (0)
    0x25, 0x01, // Logical Maximum (1)
    0x75, 0x01, // Report Size (1 bit)
    0x95, 0x08, // Report Count (8 bits)
    0x81, 0x02, // Input (Data, Var, Abs)

    // Reserved (1 byte)
    0x95, 0x01, // Report Count (1)
    0x75, 0x08, // Report Size (8)
    0x81, 0x01, // Input (Const)

    // Key Array (6 bytes)
    0x95, 0x06, // Report Count (6)
    0x75, 0x08, // Report Size (8)
    0x15, 0x00, // Logical Minimum (0)
    0x25, 0x65, // Logical Maximum (101)
    0x05, 0x07, // Usage Page (Key Codes)
    0x19, 0x00, // Usage Minimum (0)
    0x29, 0x65, // Usage Maximum (101)
    0x81, 0x00, // Input (Data, Array)

    // Output (LEDs: Caps Lock, Num Lock, etc)
    0x95, 0x05, // Report Count (5)
    0x75, 0x01, // Report Size (1)
    0x05, 0x08, // Usage Page (LEDs)
    0x19, 0x01, // Usage Minimum (1)
    0x29, 0x05, // Usage Maximum (5)
    0x91, 0x02, // Output (Data, Var, Abs)

    // Reserved (3 bits)
    0x95, 0x01, // Report Count (1)
    0x75, 0x03, // Report Size (3)
    0x91, 0x01, // Output (Const)
    0xC0, // End Collection
};

// ============== HID Descriptor ================

//=============== USB DATA =================
var EP0_RX_BUFFER: [64]u8 = undefined;
//=============== USB DATA =================

fn usb_send(buffer: []const u8, toggle: usb_ll.PID, EP: usize) void {
    pma.buffer_to_TX(buffer, EP);
    usb_ll.change_status(.TX, .Valid, toggle, EP);
}

//TODO port helpers from RPxxxx USB HAL
fn calc_descriptor_size(comptime string: []const u8) comptime_int {
    return (string.len * 2) + 2;
}
fn string_to_descriptor(comptime string: []const u8) [calc_descriptor_size(string)]u8 {
    var buf: [calc_descriptor_size(string)]u8 = undefined;
    buf[0] = buf.len;
    buf[1] = 0x03;
    for (0..string.len) |index| {
        buf[(((index) * 2)) + 2] = string[index];
        buf[(((index) * 2) + 1) + 2] = 0;
    }
    return buf;
}

const prod_id = string_to_descriptor("Zig Keyboard");
const manu_id = string_to_descriptor("RecursiveError");
fn get_string(index: usize) []const u8 {
    return switch (index) {
        0 => &[_]u8{ 0x04, 0x03, 0x04, 0x09 },
        1 => &manu_id,
        2 => &prod_id,
        else => &[_]u8{},
    };
}

//TODO port USB driver from RPxxxx USB HAL
fn get_descriptor(setup: []const u8) void {
    const descriptor_type = setup[3];
    const descriptor_length: u16 = @as(u16, setup[6]) | (@as(u16, setup[7]) << 8);

    const buffer: []const u8 = switch (descriptor_type) {
        0x01 => &DeviceDescriptor,
        0x02 => &ConfigurationDescriptor,
        0x03 => get_string(setup[2]),
        0x22 => &ReportDescriptor,
        else => {
            return;
        },
    };

    const length = @min(buffer.len, descriptor_length);
    usb_send(buffer[0..length], .force_data1, 0);
}

var device_addr: ?u7 = null;
fn set_addr(recive_addr: u7) void {
    device_addr = recive_addr;
    usb_send(&[_]u8{}, .force_data1, 0);
}

fn set_idle(value: u8) void {
    if (value != 0) {
        //TODO
    }
    usb_send(&[_]u8{}, .force_data1, 0);
}

fn ep0_setup_handler() void {
    const setup = pma.RX_to_buffer(&EP0_RX_BUFFER, 0);
    if (setup.len == 0) {
        return;
    }

    switch (setup[1]) {
        0x06 => get_descriptor(setup),
        0x05 => set_addr(@intCast(setup[2])),
        0x09 => {
            usb_send(&[_]u8{}, .force_data1, 0);
            config = true;
        },
        0x0a => set_idle(setup[3]),
        else => {
            usb_send(&[_]u8{}, .force_data1, 0);
        },
    }
}

var config: bool = false;
fn ep0_handler() void {
    const ep_data = USB.EPR[0].read();

    if (ep_data.CTR_RX == 1) {
        USB.EPR[0].modify(.{ .CTR_RX = 0 });
        if (ep_data.SETUP == 1) {
            ep0_setup_handler();
        } else {
            const recv = pma.RX_to_buffer(&EP0_RX_BUFFER, 0);

            if (recv.len == 0) {
                usb_ll.change_status(.RX, .Valid, .endpoint_ctr, 0);
            }
        }
    }
    if (ep_data.CTR_TX == 1) {
        USB.EPR[0].modify(.{ .CTR_TX = 0 });
        if (device_addr) |addr| {
            USB.DADDR.modify(.{
                .ADD = addr,
                .EF = 1,
            });
        }
        usb_ll.change_status(.RX, .Valid, .endpoint_ctr, 0);
    }
}

var HID_send: [8]u8 = .{0} ** 8;
var to_report: bool = false;
fn ep1_handler() void {
    const ep_regs = USB.EPR[1].read();
    if (ep_regs.CTR_TX == 1) {
        USB.EPR[1].modify(.{ .CTR_TX = 0 });
        usb_ll.change_status(.TX, .Nak, .no_change, 0);
        to_report = false;
    }
}

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .USB_LP_CAN1_RX0 = .{ .c = USB_handler } },
};

//TODO create USB_handler in the USB HAL
fn USB_handler() callconv(.C) void {
    const event = USB.ISTR.read();
    if (event.RESET == 1) {
        usb_ll.default_reset_handler();
    }

    if (event.CTR == 1) {
        const EP = event.EP_ID;
        USB.ISTR.modify(.{ .CTR = 0 });
        switch (EP) {
            0 => ep0_handler(),
            1 => ep1_handler(),
            else => {},
        }
    }
}

//set clock to 72Mhz and USB to 48Mhz
//NOTE: USB clock must be exactly 48Mhz
fn config_clock() void {
    RCC.CR.modify(.{
        .HSEON = 1,
    });
    while (RCC.CR.read().HSERDY == 0) {
        asm volatile ("nop");
    }

    RCC.CFGR.modify(.{
        .PLLSRC = rcc_v1.PLLSRC.HSE_Div_PREDIV,
        .PLLMUL = rcc_v1.PLLMUL.Mul9,
    });

    RCC.CR.modify(.{
        .PLLON = 1,
    });

    while (RCC.CR.read().PLLRDY == 0) {
        asm volatile ("nop");
    }

    flash.ACR.modify(.{
        .LATENCY = flash_v1.LATENCY.WS2,
        .PRFTBE = 1,
    });

    RCC.CFGR.modify(.{
        .PPRE1 = rcc_v1.PPRE.Div2,
        .USBPRE = rcc_v1.USBPRE.Div1_5,
    });

    RCC.CFGR.modify(.{
        .SW = rcc_v1.SW.PLL1_P,
    });

    while (RCC.CFGR.read().SWS != rcc_v1.SW.PLL1_P) {
        asm volatile ("nop");
    }
}

//TODO: full HID report function
fn report(key: u8) void {
    const report_flag: *volatile bool = &to_report;
    if (!config) return;
    while (report_flag.*) {}
    HID_send[2] = key;
    usb_send(&HID_send, .endpoint_ctr, 1);
    report_flag.* = true;
}

const endpoint0 = usb_ll.Endpoint{
    .endpoint = 0,
    .ep_type = .Control,
    .ep_kind = false,
    .rx_reset_state = .Valid,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 2, .block_size = .@"32bytes" },
    .tx_buffer_size = 64,
};

const endpoint1 = usb_ll.Endpoint{
    .endpoint = 1,
    .ep_type = .Interrupt,
    .ep_kind = false,
    .rx_reset_state = .Nak,
    .tx_reset_state = .Nak,
    .rx_buffer_size = .{ .block_qtd = 1, .block_size = .@"2bytes" },
    .tx_buffer_size = 16,
};
pub fn main() !void {
    config_clock();
    RCC.APB2ENR.modify(.{
        .AFIOEN = 1,
        .GPIOAEN = 1,
        .GPIOBEN = 1,
        .GPIOCEN = 1,
    });

    RCC.APB1ENR.modify(.{
        .TIM2EN = 1,
        .USBEN = 1,
    });
    const led = gpio.Pin.from_port(.B, 2);
    Counter = timer.into_counter(60_000_000);

    //NOTE: the stm32f103 does not have an internal 1.5k pull-up resistor for USB, you must add one externally
    usb_ll.usb_init(&.{ endpoint0, endpoint1 }, Counter.make_ms_timeout(25)) catch unreachable;

    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        Counter.sleep_ms(1000);
        led.toggle();
        report(0x04);
        report(0x00);
        report(0x05);
        report(0x00);
    }
}
