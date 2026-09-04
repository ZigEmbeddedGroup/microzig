//! Interrupt matrix and cpu interrupt controller of the esp32c3.
//!
//! Both live in the single INTERRUPT_CORE0 peripheral on this chip.

const microzig = @import("microzig");

const INTERRUPT_CORE0 = microzig.chip.peripherals.INTERRUPT_CORE0;

/// Peripheral interrupt sources that can be routed to one of the cpu interrupts.
pub const Source = enum(u6) {
    wifi_mac = 0,
    wifi_mac_nmi = 1,
    wifi_pwr = 2,
    wifi_bb = 3,
    bt_mac = 4,
    bt_bb = 5,
    bt_bb_nmi = 6,
    rwbt = 7,
    rwble = 8,
    rwbt_nmi = 9,
    rwble_nmi = 10,
    i2c_master = 11,
    slc0 = 12,
    slc1 = 13,
    apb_ctrl = 14,
    uhci0 = 15,
    gpio = 16,
    gpio_nmi = 17,
    spi1 = 18,
    spi2 = 19,
    i2s0 = 20,
    uart0 = 21,
    uart1 = 22,
    ledc = 23,
    efuse = 24,
    twai0 = 25,
    usb_device = 26,
    rtc_core = 27,
    rmt = 28,
    i2c_ext0 = 29,
    timer1 = 30,
    timer2 = 31,
    tg0_t0_level = 32,
    tg0_wdt_level = 33,
    tg1_t0_level = 34,
    tg1_wdt_level = 35,
    cache_ia = 36,
    systimer_target0 = 37,
    systimer_target1 = 38,
    systimer_target2 = 39,
    spi_mem_reject_cache = 40,
    icache_preload0 = 41,
    icache_sync0 = 42,
    apb_adc = 43,
    dma_ch0 = 44,
    dma_ch1 = 45,
    dma_ch2 = 46,
    rsa = 47,
    aes = 48,
    sha = 49,
    from_cpu_intr0 = 50,
    from_cpu_intr1 = 51,
    from_cpu_intr2 = 52,
    from_cpu_intr3 = 53,
    assist_debug = 54,
    dma_apbperi_pms = 55,
    core0_iram0_pms = 56,
    core0_dram0_pms = 57,
    core0_pif_pms = 58,
    core0_pif_pms_size = 59,
    bak_pms_violate = 60,
    cache_core0_acs = 61,
};

/// Integer wide enough to hold the pending bit of every interrupt source.
pub const SourceStatus = u61;

pub fn source_status() SourceStatus {
    return INTERRUPT_CORE0.INTR_STATUS_REG_0.raw |
        (@as(SourceStatus, INTERRUPT_CORE0.INTR_STATUS_REG_1.raw) << 32);
}

/// The register that selects which cpu interrupt a source is routed to. They are laid out
/// consecutively, MAC_INTR_MAP being the first one.
pub fn source_map(source: Source) *volatile u32 {
    const base: usize = @intFromPtr(&INTERRUPT_CORE0.MAC_INTR_MAP);
    return @ptrFromInt(base + @sizeOf(u32) * @as(usize, @backingInt(source)));
}

pub fn cpu_int_enable() *volatile u32 {
    return @ptrCast(&INTERRUPT_CORE0.CPU_INT_ENABLE);
}

pub fn cpu_int_type() *volatile u32 {
    return @ptrCast(&INTERRUPT_CORE0.CPU_INT_TYPE);
}

pub fn cpu_int_clear() *volatile u32 {
    return @ptrCast(&INTERRUPT_CORE0.CPU_INT_CLEAR);
}

pub fn cpu_int_eip_status() *volatile u32 {
    return @ptrCast(&INTERRUPT_CORE0.CPU_INT_EIP_STATUS);
}

pub fn cpu_int_thresh() *volatile u32 {
    return @ptrCast(&INTERRUPT_CORE0.CPU_INT_THRESH);
}

/// Priority registers of the 32 cpu interrupts, laid out consecutively.
pub fn cpu_int_pri(int: u5) *volatile u32 {
    const base: *volatile [32]u32 = @ptrCast(&INTERRUPT_CORE0.CPU_INT_PRI_0);
    return &base[int];
}
