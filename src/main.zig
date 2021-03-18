const std = @import("std");
const _ = @import("startup.zig");
const mmio = @import("rk2040.zig");
const spi = @import("spi.zig");
const ST7789 = @import("st7789.zig").ST7789;
const gpio = @import("gpio.zig");

const Display = ST7789(spi.SPI0, gpio.Pin(20), gpio.Pin(21));

const SPI0_CLK = gpio.Pin(18);
const SPI0_TX = gpio.Pin(19);
const LED = gpio.Pin(25);

pub export fn main() void {
    mmio.CLOCKS.CLK_REF_CTRL.set(.{ .SRC = 2 }); // XOSC

    mmio.CLOCKS.CLK_PERI_CTRL.set(.{ .ENABLE = true });

    // LED
    mmio.IO_BANK0.GPIO25_CTRL.set(.{ .FUNCSEL = 5 });
    mmio.SIO.GPIO_OE_SET.set(.{ .GPIO_OE_SET = 1 << 25 });

    // RES
    mmio.IO_BANK0.GPIO20_CTRL.set(.{ .FUNCSEL = 5 });
    mmio.SIO.GPIO_OE_SET.set(.{ .GPIO_OE_SET = 1 << 20 });

    // DC
    mmio.IO_BANK0.GPIO21_CTRL.set(.{ .FUNCSEL = 5 });
    mmio.SIO.GPIO_OE_SET.set(.{ .GPIO_OE_SET = 1 << 21 });

    // SPI0 TX
    mmio.IO_BANK0.GPIO19_CTRL.set(.{ .FUNCSEL = 1 });
    mmio.SIO.GPIO_OE_SET.set(.{ .GPIO_OE_SET = 1 << 19 });

    // SPI0 CLK
    mmio.IO_BANK0.GPIO18_CTRL.set(.{ .FUNCSEL = 1 });
    mmio.SIO.GPIO_OE_SET.set(.{ .GPIO_OE_SET = 1 << 18 });

    LED.clr();

    Display.init();

    //@memset(@ptrCast([*]u8, &fd), 0x00, @sizeOf(fundude.Fundude));
    //fd.load(rom_2048) catch @breakpoint();

    while (true) {
        LED.set();
        delay(2000);
        LED.clr();
    }
}

pub fn delay(ms: u32) callconv(.Inline) void {
    var i: u32 = 0;
    while (i < (ms * 2000)) {
        asm volatile ("nop");
        i += 1;
    }
}

fn dma_stuff() void {
    const zero: u8 = 0;

    mmio.DMA.CH0_READ_ADDR.ptr().* = @ptrToInt(&zero);
    mmio.DMA.CH0_WRITE_ADDR.ptr().* = @ptrToInt(mmio.SPI0.SSPDR.ptr());
    mmio.DMA.CH0_TRANS_COUNT.ptr().* = 240 * 240 * 2;

    const ctrl: mmio.DMA.CH0_CTRL_TRIG.underlaying_type() = .{
        .EN = true,
        .HIGH_PRIORITY = false,
        .DATA_SIZE = 0, // 8-bits,
        .INCR_READ = false, // increment read ptr
        .INCR_WRITE = false, // increment write ptr
        .RING_SIZE = 0,
        .RING_SEL = false,
        .CHAIN_TO = 0, // disable chaining
        .TREQ_SEL = 0x10, // spi0 tx
        .IRQ_QUIET = true, // disable irq
        .BSWAP = false, // disable byte swapping
        .SNIFF_EN = false, // ???
        .BUSY = false,
        .WRITE_ERROR = false,
        .READ_ERROR = false,
        .AHB_ERROR = false,
    };
    mmio.DMA.CH0_CTRL_TRIG.write(ctrl);
    const dma_ptr = mmio.DMA.CH0_AL1_CTRL.ptr();
    while (dma_ptr.* & 0x01000000 == 0x01000000) // BUSY
        asm volatile ("nop");
}
