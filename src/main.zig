const std = @import("std");
const nrf = @import("nrf52840.zig");

const InterruptVector = fn () callconv(.Naked) void;

const Vectors = extern struct {
    reset: InterruptVector,
};

export const vectors linksection(".isr_vector") = Vectors{
    .reset = _start,
};

fn GPIO(comptime spec: []const u8) type {
    if (spec.len != 5 or spec[0] != 'P' or spec[2] != '.')
        @compileError("Invalid GPIO format!");
    const _port = std.fmt.parseInt(u1, spec[1..2], 10) catch @compileError("Invalid GPIO format!");
    const _pin = std.fmt.parseInt(u5, spec[3..5], 10) catch @compileError("Invalid GPIO format!");

    return struct {
        const gpio = if (_port == 1) nrf.gpio_p1 else nrf.gpio_p0;
        const pin = _pin;
        const mask = (1 << pin);

        fn makeOutput() void {
            gpio.dirset = mask;
        }

        fn set() void {
            gpio.outset = mask;
        }

        fn clear() void {
            gpio.outclr = mask;
        }

        fn toggle() void {
            gpio.out = (gpio.out ^ mask);
        }
    };
}

const led1 = GPIO("P0.06");
const led2_r = GPIO("P0.08");
const led2_g = GPIO("P1.09");
const led2_b = GPIO("P0.12");

fn busyloop() void {
    var foo: u32 = 1_000_000;
    while (foo > 0) : (foo -= 1) {
        asm volatile (""
            :
            : [_] "r" (foo)
        );
    }
}

export fn _start() callconv(.Naked) noreturn {
    led1.makeOutput();
    led2_r.makeOutput();
    led2_g.makeOutput();
    led2_b.makeOutput();

    // is dis my code?

    while (true) {
        led1.toggle();
        led2_r.clear();
        led2_g.set();
        led2_b.set();
        busyloop();

        led1.toggle();
        led2_r.set();
        led2_g.clear();
        led2_b.set();
        busyloop();

        led1.toggle();
        led2_r.set();
        led2_g.set();
        led2_b.clear();
        busyloop();
    }
}

pub fn panic(msg: []const u8, stack_trace: ?*std.builtin.StackTrace) noreturn {
    while (true) {}
}

// 0, 0x40000000, CLOCKCLOCKClock control
// 0, 0x40000000, POWERPOWERPower control
// 0, 0x50000000, GPIOGPIOGeneral purpose input and output
// 0, 0x50000000, GPIOP0General purpose input and output, port 0
// 0, 0x50000300, GPIOP1General purpose input and output, port 1
// 1, 0x40001000, RADIORADIO2.4 GHz radio
// 2, 0x40002000, UARTUART0Universal asynchronous receiver/transmitter
// 2, 0x40002000, UARTEUARTE0Universal asynchronous receiver/transmitter with EasyDMA,
// 3, 0x40003000, SPISPI0SPI master 0
// 3, 0x40003000, SPIMSPIM0SPI master 0
// 3, 0x40003000, SPISSPIS0SPI slave 0
// 3, 0x40003000, TWITWI0Two-wire interface master 0
// 3, 0x40003000, TWIMTWIM0Two-wire interface master 0
// 3, 0x40003000, TWISTWIS0Two-wire interface slave 0
// 4, 0x40004000, SPISPI1SPI master 1
// 4, 0x40004000, SPIMSPIM1SPI master 1
// 4, 0x40004000, SPISSPIS1SPI slave 1
// 4, 0x40004000, TWITWI1Two-wire interface master 1
// 4, 0x40004000, TWIMTWIM1Two-wire interface master 1
// 4, 0x40004000, TWISTWIS1Two-wire interface slave 1
// 5, 0x40005000, NFCTNFCTNear field communication tag
// 6, 0x40006000, GPIOTEGPIOTEGPIO tasks and events
// 7, 0x40007000, SAADCSAADCAnalog to digital converter
// 8, 0x40008000, TIMERTIMER0Timer 0
// 9, 0x40009000, TIMERTIMER1Timer 1
// 10, 0x4000A000, TIMERTIMER2Timer 2
// 11, 0x4000B000, RTCRTC0Real-time counter 0
// 12, 0x4000C000, TEMPTEMPTemperature sensor
// 13, 0x4000D000, RNGRNGRandom number generator
// 14, 0x4000E000, ECBECBAES electronic code book (ECB) mode block encryption
// 15, 0x4000F000, AARAARAccelerated address resolver
// 15, 0x4000F000, CCMCCMAES counter with CBC-MAC (CCM) mode block encryption
// 16, 0x40010000, WDTWDTWatchdog timer
// 17, 0x40011000, RTCRTC1Real-time counter 1
// 18, 0x40012000, QDECQDECQuadrature decoder
// 19, 0x40013000, COMPCOMPGeneral purpose comparator
// 19, 0x40013000, LPCOMPLPCOMPLow power comparator
// 20, 0x40014000, EGUEGU0Event generator unit 0
// 20, 0x40014000, SWISWI0Software interrupt 0
// 21, 0x40015000, EGUEGU1Event generator unit 1
// 21, 0x40015000, SWISWI1Software interrupt 1
// 22, 0x40016000, EGUEGU2Event generator unit 2
// 22, 0x40016000, SWISWI2Software interrupt 2
// 23, 0x40017000, EGUEGU3Event generator unit 3
// 23, 0x40017000, SWISWI3Software interrupt 3
// 24, 0x40018000, EGUEGU4Event generator unit 4
// 24, 0x40018000, SWISWI4Software interrupt 4
// 25, 0x40019000, EGUEGU5Event generator unit 5
// 25, 0x40019000, SWISWI5Software interrupt 5
// 26, 0x4001A000, TIMERTIMER3Timer 3
// 27, 0x4001B000, TIMERTIMER4Timer 4
// 28, 0x4001C000, PWMPWM0Pulse width modulation unit 0
// 29, 0x4001D000, PDMPDMPulse Density modulation (digital microphone) interface
// 30, 0x4001E000, ACLACLAccess control lists
// 30, 0x4001E000, NVMCNVMCNon-volatile memory controller
// 31, 0x4001F000, PPIPPIProgrammable peripheral interconnect
// 32, 0x40020000, MWUMWUMemory watch unit
// 33, 0x40021000, PWMPWM1Pulse width modulation unit 1
// 34, 0x40022000, PWMPWM2Pulse width modulation unit 2
// 35, 0x40023000, SPISPI2SPI master 2
// 35, 0x40023000, SPIMSPIM2SPI master 2
// 35, 0x40023000, SPISSPIS2SPI slave 2
// 36, 0x40024000, RTCRTC2Real-time counter 2
// 37, 0x40025000, I2SI2SInter-IC sound interface
// 38, 0x40026000, FPUFPUFPU interrupt
// 39, 0x40027000, USBDUSBDUniversal serial bus device
// 40, 0x40028000, UARTEUARTE1Universal asynchronous receiver/transmitter with EasyDMA,
// 41, 0x40029000, QSPIQSPIExternal memory interface
// 42, 0x5002A000, CC_HOST_RGFCC_HOST_RGFHost platform interface
// 42, 0x5002A000, CRYPTOCELLCRYPTOCELLCryptoCell subsystem control interface
// 45, 0x4002D000, PWMPWM3Pulse width modulation unit 3
// 47, 0x4002F000, SPIMSPIM3SPI master 3
// 0,  0x10000000, FICRFICRFactory information configuration
// 0,  0x10001000, UICRUICRUser information configuration
