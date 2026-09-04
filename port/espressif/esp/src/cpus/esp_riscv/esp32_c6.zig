//! Interrupt matrix and cpu interrupt controller of the esp32c6.
//!
//! Unlike the esp32c3 these are two separate peripherals: INTERRUPT_CORE0 routes a peripheral
//! source to one of the cpu interrupts and reports which sources are pending, while INTPRI owns
//! the enable, type, priority and threshold state of the cpu interrupts themselves.

const microzig = @import("microzig");

const INTERRUPT_CORE0 = microzig.chip.peripherals.INTERRUPT_CORE0;
const INTPRI = microzig.chip.peripherals.INTPRI;

/// Peripheral interrupt sources that can be routed to one of the cpu interrupts.
pub const Source = enum(u7) {
    wifi_mac = 0,
    wifi_mac_nmi = 1,
    wifi_pwr = 2,
    wifi_bb = 3,
    bt_mac = 4,
    bt_bb = 5,
    bt_bb_nmi = 6,
    lp_timer = 7,
    coex = 8,
    ble_timer = 9,
    ble_sec = 10,
    i2c_mst = 11,
    zb_mac = 12,
    pmu = 13,
    efuse = 14,
    lp_rtc_timer = 15,
    lp_uart = 16,
    lp_i2c = 17,
    lp_wdt = 18,
    lp_peri_timeout = 19,
    lp_apm_m0 = 20,
    lp_apm_m1 = 21,
    cpu_intr_from_cpu_0 = 22,
    cpu_intr_from_cpu_1 = 23,
    cpu_intr_from_cpu_2 = 24,
    cpu_intr_from_cpu_3 = 25,
    assist_debug = 26,
    trace = 27,
    cache = 28,
    cpu_peri_timeout = 29,
    gpio = 30,
    gpio_nmi = 31,
    pau = 32,
    hp_peri_timeout = 33,
    modem_peri_timeout = 34,
    hp_apm_m0 = 35,
    hp_apm_m1 = 36,
    hp_apm_m2 = 37,
    hp_apm_m3 = 38,
    lp_apm0 = 39,
    spi1 = 40,
    i2s1 = 41,
    uhci0 = 42,
    uart0 = 43,
    uart1 = 44,
    ledc = 45,
    twai0 = 46,
    twai1 = 47,
    usb_device = 48,
    rmt = 49,
    i2c_ext0 = 50,
    tg0_t0 = 51,
    tg0_t1 = 52,
    tg0_wdt = 53,
    tg1_t0 = 54,
    tg1_t1 = 55,
    tg1_wdt = 56,
    systimer_target0 = 57,
    systimer_target1 = 58,
    systimer_target2 = 59,
    apb_adc = 60,
    mcpwm0 = 61,
    pcnt = 62,
    parl_io = 63,
    slc0 = 64,
    slc1 = 65,
    dma_in_ch0 = 66,
    dma_in_ch1 = 67,
    dma_in_ch2 = 68,
    dma_out_ch0 = 69,
    dma_out_ch1 = 70,
    dma_out_ch2 = 71,
    spi2 = 72,
    aes = 73,
    sha = 74,
    rsa = 75,
    ecc = 76,
};

/// Integer wide enough to hold the pending bit of every interrupt source.
pub const SourceStatus = u77;

pub fn source_status() SourceStatus {
    return INTERRUPT_CORE0.INT_STATUS_REG_0.raw |
        (@as(SourceStatus, INTERRUPT_CORE0.INT_STATUS_REG_1.raw) << 32) |
        (@as(SourceStatus, INTERRUPT_CORE0.INT_STATUS_REG_2.raw) << 64);
}

/// The register that selects which cpu interrupt a source is routed to. They are laid out
/// consecutively, WIFI_MAC_INTR_MAP being the first one.
pub fn source_map(source: Source) *volatile u32 {
    const base: usize = @intFromPtr(&INTERRUPT_CORE0.WIFI_MAC_INTR_MAP);
    return @ptrFromInt(base + @sizeOf(u32) * @as(usize, @backingInt(source)));
}

pub fn cpu_int_enable() *volatile u32 {
    return @ptrCast(&INTPRI.CPU_INT_ENABLE);
}

pub fn cpu_int_type() *volatile u32 {
    return @ptrCast(&INTPRI.CPU_INT_TYPE);
}

pub fn cpu_int_clear() *volatile u32 {
    return @ptrCast(&INTPRI.CPU_INT_CLEAR);
}

pub fn cpu_int_eip_status() *volatile u32 {
    return @ptrCast(&INTPRI.CPU_INT_EIP_STATUS);
}

pub fn cpu_int_thresh() *volatile u32 {
    return @ptrCast(&INTPRI.CPU_INT_THRESH);
}

/// Priority registers of the 32 cpu interrupts, laid out consecutively.
pub fn cpu_int_pri(int: u5) *volatile u32 {
    const base: *volatile [32]u32 = @ptrCast(&INTPRI.CPU_INT_PRI_0);
    return &base[int];
}
