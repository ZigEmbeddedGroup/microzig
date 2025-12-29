//NOTE: This is just an experimental test, USB HAL for the F1 family is not complete.

const std = @import("std");
const microzig = @import("microzig");

const host = microzig.core.arm_semihosting;

const RCC = microzig.chip.peripherals.RCC;
const flash = microzig.chip.peripherals.FLASH;
const rcc_v1 = microzig.chip.types.peripherals.rcc_f1;
const flash_v1 = microzig.chip.types.peripherals.flash_f1;

const stm32 = microzig.hal;
const gpio = stm32.gpio;
const timer = stm32.timer.GPTimer.init(.TIM2).into_counter_mode();
const usb_ll = stm32.usb.usb_ll;
const descriptor = microzig.core.usb.descriptor;

const EpControl = usb_ll.EpControl;

const interrupt = microzig.interrupt;
var Counter: stm32.drivers.CounterDevice = undefined;
const IR_pin = gpio.Pin.from_port(.B, 0);
const peri = microzig.chip.peripherals;
const t_types = microzig.chip.types.peripherals.timer_v1;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .USB_LP_CAN1_RX0 = .{ .c = usb_ll.usb_handler },
        .EXTI0 = .{ .c = IR_handler },
        .TIM3 = .{ .c = IR_timer_handler },
    },
};

// ============== HID Descriptor ================
const DeviceDescriptor = [18]u8{
    0x12, // bLength
    0x01, // bDescriptorType (Device)
    0x10, 0x01, // bcdUSB (USB 1.1)
    0x00, // bDeviceClass (Defined at Interface)
    0x00, // bDeviceSubClass
    0x00, // bDeviceProtocol
    0x40, // bMaxPacketSize0 (64 bytes)
    0x55, 0xF0, // idVendor FOSS
    0x01, 0x98, // idProduct (0x9801) HID
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
var HID_send: [8]u8 = .{0} ** 8;
var to_report: bool = false;
var device_addr: ?u7 = null;
var config: bool = false;
//=============== USB DATA =================
//==========IR NEC ==========
const NecPkg = packed struct(u32) {
    addr_h: u8,
    addr_l: u8,
    cmd: u8,
    inv_cmd: u8,
};
//==========IR NEC ==========

const lang_id: descriptor.String = .from_lang(.English);
const prod_id: descriptor.String = .from_str("Zig Keyboard");
const manu_id: descriptor.String = .from_str("RecursiveError");
fn get_string(index: usize) []const u8 {
    return switch (index) {
        0 => &lang_id.data,
        1 => &manu_id.data,
        2 => &prod_id.data,
        else => &[_]u8{},
    };
}

//TODO port USB driver from RPxxxx USB HAL
fn get_descriptor(setup: []const u8, epc: EpControl) void {
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
    epc.write_buffer(buffer[0..length]) catch unreachable;
    epc.set_status(.TX, .Valid, .force_data1) catch unreachable;
}

fn set_addr(recive_addr: u7, epc: EpControl) void {
    device_addr = recive_addr;
    epc.ZLP() catch unreachable;
    epc.set_status(.TX, .Valid, .force_data1) catch unreachable;
}

fn ep0_setup(epc: EpControl, _: ?*anyopaque) void {
    epc.set_status(.RX, .Valid, .no_change) catch unreachable;

    const setup = epc.read_buffer(&EP0_RX_BUFFER) catch unreachable;
    if (setup.len == 0) {
        return;
    }

    switch (setup[1]) {
        0x06 => get_descriptor(setup, epc),
        0x05 => set_addr(@intCast(setup[2]), epc),
        0x09 => {
            epc.ZLP() catch unreachable;
            epc.set_status(.TX, .Valid, .force_data1) catch unreachable;
            config = true;
            to_report = false;
        },
        else => {
            epc.ZLP() catch unreachable;
            epc.set_status(.TX, .Valid, .force_data1) catch unreachable;
        },
    }
}

fn ep0_rx(epc: EpControl, _: ?*anyopaque) void {
    epc.set_status(.RX, .Valid, .no_change) catch unreachable;
}

fn ep0_tx(epc: EpControl, _: ?*anyopaque) void {
    if (device_addr) |addr| {
        usb_ll.set_addr(addr);
    }
    epc.set_status(.RX, .Valid, .endpoint_ctr) catch unreachable;
}

fn ep1_tx(epc: EpControl, _: ?*anyopaque) void {
    to_report = false;
    epc.set_status(.TX, .Nak, .no_change) catch unreachable;
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
    .rx_buffer_size = .{ .block_qtd = 1, .block_size = .@"2bytes" },
    .tx_buffer_size = 16,
    .tx_callback = ep1_tx,
};

//TODO: full HID report function
fn report(keys: []const u8) void {
    const len = @min(keys.len, 6);
    const epc = usb_ll.EpControl.EPC1;
    const report_flag: *volatile bool = &to_report;
    if (!config) return;
    while (report_flag.*) {}
    std.mem.copyForwards(u8, HID_send[3..], keys[0..len]);
    epc.write_buffer(&HID_send) catch unreachable;
    epc.set_status(.TX, .Valid, .endpoint_ctr) catch unreachable;
    report_flag.* = true;
}

fn init_IR() void {

    //enable IR EXTI
    IR_pin.set_input_mode(.pull);
    IR_pin.set_pull(.up);
    peri.AFIO.EXTICR[0].modify(.{ .@"EXTI[0]" = 1 });
    peri.EXTI.IMR.modify(.{ .@"LINE[0]" = 1 });
    peri.EXTI.FTSR.modify(.{ .@"LINE[0]" = 1 });
    peri.EXTI.RTSR.modify(.{ .@"LINE[0]" = 1 });
    peri.EXTI.PR.modify(.{ .@"LINE[0]" = 1 });

    //enable timer
    peri.TIM3.CR1.raw = 0;
    peri.TIM3.CR2.raw = 0;
    peri.TIM3.SR.raw = 0;

    peri.TIM3.CR1.modify(.{ .CEN = 0 });
    peri.TIM3.CR1.modify(.{
        .URS = t_types.URS.CounterOnly,
        .OPM = 1,
        .DIR = t_types.DIR.Down,
        .ARPE = 1,
    });
    peri.TIM3.PSC = 72;
    peri.TIM3.DIER.modify(.{ .UIE = 1 });

    interrupt.enable(.EXTI0);
    interrupt.enable(.TIM3);
}

fn start_IR_timer() void {
    peri.TIM3.SR.raw = 0;
    peri.TIM3.CR1.modify(.{ .CEN = 0 });
    peri.TIM3.PSC = 72;
    peri.TIM3.ARR.modify(.{ .ARR = @as(u16, 25_000) });
    peri.TIM3.EGR.modify(.{ .UG = 1 });
    peri.TIM3.CR1.modify(.{ .CEN = 1 });
}

fn stop_IR_timer() usize {
    peri.TIM3.CR1.modify(.{ .CEN = 0 });
    const val = peri.TIM3.CNT.read().CNT;
    peri.TIM3.SR.raw = 0;
    return val;
}

var ir_val: u64 = 0;
var ir_index: u6 = 0;

fn IR_handler() callconv(.c) void {
    const pin_state = IR_pin.read();
    if (pin_state == 0) {
        const val = stop_IR_timer();
        if (val != 0) {
            const bit = 25_000 - val;
            switch (bit) {
                200...800 => {
                    ir_val &= ~(@as(u64, 0) << ir_index);
                    ir_index += 1;
                    ir_index = ir_index % 63;
                },
                1200...1900 => {
                    ir_val |= (@as(u64, 1) << ir_index);
                    ir_index += 1;
                    ir_index = ir_index % 63;
                },
                4200...4800 => {
                    ir_val = 0;
                    ir_index = 0;
                },
                else => {},
            }
        }
    } else if (pin_state == 1) {
        start_IR_timer();
    }
    peri.EXTI.PR.modify(.{ .@"LINE[0]" = 1 });
}

var nec_report: NecPkg = undefined;
var nec_send: bool = false;
fn IR_timer_handler() callconv(.c) void {
    const val: u32 = @truncate(ir_val);
    const nec: NecPkg = @bitCast(val);
    if (val == 0) {
        nec_send = true;
    } else {
        nec_report = nec;
        nec_send = true;
    }
    ir_index = 0;
    ir_val = 0;
    peri.TIM3.SR.raw = 0;
}

fn nec_to_hid(nec_cmd: u8) u8 {
    return switch (nec_cmd) {
        0x1D => 0x52, //arrow up
        0x45 => 0x51, //arrow down
        0x40 => 0x50, //arrow left
        0x43 => 0x4F, //arrow right
        0x41 => 0x20, //enter
        0x0e => 0x29, //esc
        else => nec_cmd,
    };
}

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
        .TIM3EN = 1,
        .USBEN = 1,
    });
    Counter = timer.counter_device(72_000_000);

    //NOTE: the stm32f103 does not have an internal 1.5k pull-up resistor for USB, you must add one externally
    interrupt.enable_interrupts();
    usb_ll.usb_init(&.{ endpoint0, endpoint1 }, Counter.make_ms_timeout(25)) catch unreachable;
    init_IR();
    //interrupt.enable(.USB_LP_CAN1_RX0);
    const nec: *volatile bool = &nec_send;
    const n_report: *volatile NecPkg = &nec_report;
    while (true) {
        if (nec.*) {
            report(&.{n_report.cmd});
            nec_send = false;
        } else {
            report(&.{ 0, 0, 0, 0, 0 });
        }
        Counter.sleep_ms(10);
    }
}
