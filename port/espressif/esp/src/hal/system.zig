const microzig = @import("microzig");

const SYSTEM = microzig.chip.peripherals.SYSTEM;
const RESET = SYSTEM.PERIP0;

pub const PeripheralMask = packed struct(u43) {
    pub const empty: PeripheralMask = .{};
    pub const all: PeripheralMask = empty.inverse();
    pub const keep_enabled: PeripheralMask = .{
        .uart = true,
        .usb_device = true,
        .systimer = true,
        .timergroup = true,
    };
    pub const all_but_keep_enabled: PeripheralMask = all.@"and"(keep_enabled.inverse());

    timers: bool = false,
    spi01: bool = false,
    uart: bool = false,
    wdg: bool = false,
    i2s0: bool = false,
    uart1: bool = false,
    spi2: bool = false,
    i2c_ext0: bool = false,
    uhci0: bool = false,
    rmt: bool = false,
    pcnt: bool = false,
    ledc: bool = false,
    uhci1: bool = false,
    timergroup: bool = false,
    efuse: bool = false,
    timergroup1: bool = false,
    spi3: bool = false,
    pwm0: bool = false,
    ext1: bool = false,
    can: bool = false,
    pwm1: bool = false,
    i2s1: bool = false,
    spi2_dma: bool = false,
    usb_device: bool = false,
    uart_mem: bool = false,
    pwm2: bool = false,
    pwm3: bool = false,
    spi3_dma: bool = false,
    apb_saradc: bool = false,
    systimer: bool = false,
    adc2_arb: bool = false,
    spi4: bool = false,
    reserved1: bool = false,
    crypto_aes: bool = false,
    crypto_sha: bool = false,
    crypto_rsa: bool = false,
    crypto_ds: bool = false,
    crypto_hmac: bool = false,
    dma: bool = false,
    sdio_host: bool = false,
    lcd_cam: bool = false,
    uart2: bool = false,
    tsens: bool = false,

    pub fn @"or"(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(u43, @bitCast(self)) | @as(u43, @bitCast(other)));
    }

    pub fn @"and"(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(u43, @bitCast(self)) & @as(u43, @bitCast(other)));
    }

    pub fn inverse(self: PeripheralMask) PeripheralMask {
        return @bitCast(~@as(u43, @bitCast(self)) & 0x7feffffffff); // this mask clears the reserved bit
    }
};

pub fn clocks_enable(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_CLK_EN0.raw) | (@as(u64, SYSTEM.PERIP_CLK_EN1.raw) << 32));
    current_mask |= @as(u43, @bitCast(mask));
    SYSTEM.PERIP_CLK_EN0.write_raw(@intCast(current_mask & 0xffff_ffff));
    SYSTEM.PERIP_CLK_EN1.write_raw(@intCast(current_mask >> 32));
}

pub fn clocks_disable(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_CLK_EN0.raw) | (@as(u64, SYSTEM.PERIP_CLK_EN1.raw) << 32));
    current_mask &= ~@as(u43, @bitCast(mask));
    SYSTEM.PERIP_CLK_EN0.write_raw(@intCast(current_mask & 0xffff_ffff));
    SYSTEM.PERIP_CLK_EN1.write_raw(@intCast(current_mask >> 32));
}

pub fn peripheral_reset(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_RST_EN0.raw) | (@as(u64, SYSTEM.PERIP_RST_EN1.raw) << 32));
    current_mask |= @as(u43, @bitCast(mask));
    SYSTEM.PERIP_RST_EN0.write_raw(@intCast(current_mask & 0xffff_ffff));
    SYSTEM.PERIP_RST_EN1.write_raw(@intCast(current_mask >> 32));
}
