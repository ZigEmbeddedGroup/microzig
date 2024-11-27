/// Implements the ARM processor level IRQ enable/disable functionality on the RP2040
///
/// Note: Interrupts generally also have to be enabled at the peripheral level for specific peripheral functions,
/// this is only to control the NVIC enable/disable of the actual processor.
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const cpu = rp2xxx.compatibility.cpu;
const PPB = microzig.chip.peripherals.PPB;

pub const Mask = switch (cpu) {
    // RP2040 only has a single set of registers for interrupts
    .RP2040 => enum(u5) {
        TIMER_IRQ_0 = 0,
        TIMER_IRQ_1 = 1,
        TIMER_IRQ_2 = 2,
        TIMER_IRQ_3 = 3,
        PWM_IRQ_WRAP = 4,
        USBCTRL_IRQ = 5,
        XIP_IRQ = 6,
        PIO0_IRQ_0 = 7,
        PIO0_IRQ_1 = 8,
        PIO1_IRQ_0 = 9,
        PIO1_IRQ_1 = 10,
        DMA_IRQ_0 = 11,
        DMA_IRQ_1 = 12,
        IO_IRQ_BANK0 = 13,
        IO_IRQ_QSPI = 14,
        SIO_IRQ_PROC0 = 15,
        SIO_IRQ_PROC1 = 16,
        CLOCKS_IRQ = 17,
        SPI0_IRQ = 18,
        SPI1_IRQ = 19,
        UART0_IRQ = 20,
        UART1_IRQ = 21,
        ADC_IRQ_FIFO = 22,
        I2C0_IRQ = 23,
        I2C1_IRQ = 24,
        RTC_IRQ = 25,
    },
    // RP2350 has two different sets of registers for interrupts since there's >32 available interrupts
    .RP2350 => enum(u6) {
        // Register group 0
        TIMER0_IRQ_0 = 0,
        TIMER0_IRQ_1 = 1,
        TIMER0_IRQ_2 = 2,
        TIMER0_IRQ_3 = 3,
        TIMER1_IRQ_0 = 4,
        TIMER1_IRQ_1 = 5,
        TIMER1_IRQ_2 = 6,
        TIMER1_IRQ_3 = 7,
        PWM_IRQ_WRAP_0 = 8,
        PWM_IRQ_WRAP_1 = 9,
        DMA_IRQ_0 = 10,
        DMA_IRQ_1 = 11,
        DMA_IRQ_2 = 12,
        DMA_IRQ_3 = 13,
        USBCTRL_IRQ = 14,
        PIO0_IRQ_0 = 15,
        PIO0_IRQ_1 = 16,
        PIO1_IRQ_0 = 17,
        PIO1_IRQ_1 = 18,
        PIO2_IRQ_0 = 19,
        PIO2_IRQ_1 = 20,
        IO_IRQ_BANK0 = 21,
        IO_IRQ_BANK0_NS = 22,
        IO_IRQ_QSPI = 23,
        IO_IRQ_QSPI_NS = 24,
        SIO_IRQ_FIFO = 25,
        SIO_IRQ_BELL = 26,
        SIO_IRQ_FIFO_NS = 27,
        SIO_IRQ_BELL_NS = 28,
        SIO_IRQ_MTIMECMP = 29,
        CLOCKS_IRQ = 30,
        SPI0_IRQ = 31,
        // Register group 1
        SPI1_IRQ = 32,
        UART0_IRQ = 33,
        UART1_IRQ = 34,
        ADC_IRQ_FIFO = 35,
        I2C0_IRQ = 36,
        I2C1_IRQ = 37,
        OTP_IRQ = 38,
        TRNG_IRQ = 39,
        PROC0_IRQ_CTI = 40,
        PROC1_IRQ_CTI = 41,
        PLL_SYS_IRQ = 42,
        PLL_USB_IRQ = 43,
        POWMAN_IRQ_POW = 44,
        POWMAN_IRQ_TIMER = 45,
        SPARE_IRQ_0 = 46,
        SPARE_IRQ_1 = 47,
        SPARE_IRQ_2 = 48,
        SPARE_IRQ_3 = 49,
        SPARE_IRQ_4 = 50,
        SPARE_IRQ_5 = 51,
    },
};

pub fn enable(mask: Mask) void {
    switch (cpu) {
        .RP2040 => {
            PPB.NVIC_ICPR.write(.{ .CLRPEND = @as(u32, 1) << @intFromEnum(mask) });
            PPB.NVIC_ISER.write(.{ .SETENA = @as(u32, 1) << @intFromEnum(mask) });
        },
        .RP2350 => {
            if (@intFromEnum(mask) >= 32) {
                PPB.NVIC_ICPR1.write(.{ .CLRPEND = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask) % 32)) });
                PPB.NVIC_ISER1.write(.{ .SETENA = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask) % 32)) });
            } else {
                PPB.NVIC_ICPR0.write(.{ .CLRPEND = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask))) });
                PPB.NVIC_ISER0.write(.{ .SETENA = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask))) });
            }
        },
    }
}

pub fn disable(mask: Mask) void {
    switch (cpu) {
        .RP2040 => {
            PPB.NVIC_ICER.write(.{ .CLRENA = @as(u32, 1) << @as(u5, @intFromEnum(mask)) });
        },
        .RP2350 => {
            if (@intFromEnum(mask) >= 32) {
                PPB.NVIC_ICER1.write(.{ .CLRENA = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask) % 32)) });
            } else {
                PPB.NVIC_ICER0.write(.{ .CLRENA = @as(u32, 1) << @as(u5, @truncate(@intFromEnum(mask))) });
            }
        },
    }
}
