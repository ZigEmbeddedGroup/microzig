const microzig = @import("microzig");

const SYSTEM = microzig.chip.peripherals.SYSTEM;

/// Peripheral mask for the PERIP_CLK_ENx and PERIP_RST_ENx registers.
// NOTE: tact1m4n3: I added some reserved bits according to the manual. I am not sure whether it is
// accurate.
pub const PeripheralMask = packed struct(u43) {
    pub const empty: PeripheralMask = .{};
    pub const all: PeripheralMask = empty.inverse();

    pub const keep_enabled: PeripheralMask = .{
        .uart0 = true,
        .usb_device = true,
        .systimer = true,

        // NOTE: SPI0 and SPI1 are for internal use.
        .spi01 = true,
    };

    pub const all_but_keep_enabled: PeripheralMask = all.subtract(keep_enabled.inverse());

    timers: bool = false,
    spi01: bool = false,
    uart0: bool = false,
    reserved1: u2 = 0,
    uart1: bool = false,
    spi2: bool = false,
    i2c_ext0: bool = false,
    uhci0: bool = false,
    rmt: bool = false,
    reserved2: u1 = 0,
    ledc: bool = false,
    reserved3: u1 = 0,
    timergroup0: bool = false,
    reserved4: u1 = 0,
    timergroup1: bool = false,
    reserved5: u3 = 0,
    twai: bool = false,
    reserved6: u1 = 0,
    i2s0: bool = false,
    spi2_dma: bool = false,
    usb_device: bool = false,
    uart_mem: bool = false,
    reserved7: u2 = 0,
    // Is spi3 even a thing? The datasheet seems to think so. I've added spi2_dma just in case which
    // doesn't appear in the datasheet, but others seem to use it.
    spi3_dma: bool = false,
    apb_saradc: bool = false,
    systimer: bool = false,
    adc2_arb: bool = false,
    reserved8: u2 = 0,
    crypto_aes: bool = false,
    crypto_sha: bool = false,
    crypto_rsa: bool = false,
    crypto_ds: bool = false,
    crypto_hmac: bool = false,
    dma: bool = false,
    reserved9: u3 = 0,
    tsens: bool = false,

    /// Combines two peripherals masks. Binary or.
    pub fn combine(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(u43, @bitCast(self)) | @as(u43, @bitCast(other)));
    }

    /// Subtracts two peripherals masks. Binary and.
    pub fn subtract(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(u43, @bitCast(self)) & @as(u43, @bitCast(other)));
    }

    /// Inverses the peripheral mask. Binary not.
    pub fn inverse(self: PeripheralMask) PeripheralMask {
        return @bitCast(~(@as(u43, @bitCast(self))) & ~@as(u43, 0x38186575418));
    }
};

/// Disables most peripheral clocks and puts peripherals in the reset state to bring them to a known state.
pub fn init() void {
    clocks_enable_clear(.all_but_keep_enabled);
    peripheral_reset_set(.all_but_keep_enabled);
}

/// Sets the bits in the mask of the PERIP_CLK_ENx registers.
pub fn clocks_enable_set(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_CLK_EN0.raw) | ((@as(u64, SYSTEM.PERIP_CLK_EN1.raw) << 32)));
    current_mask |= @as(u43, @bitCast(mask));
    SYSTEM.PERIP_CLK_EN0.raw = @intCast(current_mask & 0xffff_ffff);
    SYSTEM.PERIP_CLK_EN1.raw = @intCast(current_mask >> 32);
}

/// Clears the bits in the mask of the PERIP_CLK_ENx registers.
pub fn clocks_enable_clear(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_CLK_EN0.raw) | ((@as(u64, SYSTEM.PERIP_CLK_EN1.raw) << 32)));
    current_mask &= ~@as(u43, @bitCast(mask));
    SYSTEM.PERIP_CLK_EN0.raw = @intCast(current_mask & 0xffff_ffff);
    SYSTEM.PERIP_CLK_EN1.raw = @intCast(current_mask >> 32);
}

/// Sets and clears the bits in the mask of the PERIP_RST_ENx registers. Resets the peripherals.
pub fn peripheral_reset(mask: PeripheralMask) void {
    peripheral_reset_set(mask);
    peripheral_reset_clear(mask);
}

/// Sets the bits in the mask of the PERIP_RST_ENx registers.
pub fn peripheral_reset_set(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_RST_EN0.raw) | ((@as(u64, SYSTEM.PERIP_RST_EN1.raw) << 32)));
    current_mask |= @as(u43, @bitCast(mask));
    SYSTEM.PERIP_RST_EN0.raw = @intCast(current_mask & 0xffff_ffff);
    SYSTEM.PERIP_RST_EN1.raw = @intCast(current_mask >> 32);
}

/// Clears the bits in the mask of the PERIP_RST_ENx registers.
pub fn peripheral_reset_clear(mask: PeripheralMask) void {
    var current_mask: u64 = @bitCast(@as(u64, SYSTEM.PERIP_RST_EN0.raw) | ((@as(u64, SYSTEM.PERIP_RST_EN1.raw) << 32)));
    current_mask &= ~@as(u43, @bitCast(mask));
    SYSTEM.PERIP_RST_EN0.raw = @intCast(current_mask & 0xffff_ffff);
    SYSTEM.PERIP_RST_EN1.raw = @intCast(current_mask >> 32);
}

/// Enable clocks and release peripherals from reset.
pub fn enable_clocks_and_release_reset(mask: PeripheralMask) void {
    clocks_enable_set(mask);
    peripheral_reset_clear(mask);
}

pub const CPU_Interrupt = enum {
    cpu_interrupt_0,
    cpu_interrupt_1,
    cpu_interrupt_2,
    cpu_interrupt_3,

    pub fn source(cpu_interrupt: CPU_Interrupt) microzig.cpu.interrupt.Source {
        return switch (cpu_interrupt) {
            .cpu_interrupt_0 => .from_cpu_intr0,
            .cpu_interrupt_1 => .from_cpu_intr1,
            .cpu_interrupt_2 => .from_cpu_intr2,
            .cpu_interrupt_3 => .from_cpu_intr3,
        };
    }

    pub fn set_pending(cpu_interrupt: CPU_Interrupt, enabled: bool) void {
        const regs: @TypeOf(&SYSTEM.CPU_INTR_FROM_CPU_0) = switch (cpu_interrupt) {
            .cpu_interrupt_0 => @ptrCast(&SYSTEM.CPU_INTR_FROM_CPU_0),
            .cpu_interrupt_1 => @ptrCast(&SYSTEM.CPU_INTR_FROM_CPU_1),
            .cpu_interrupt_2 => @ptrCast(&SYSTEM.CPU_INTR_FROM_CPU_2),
            .cpu_interrupt_3 => @ptrCast(&SYSTEM.CPU_INTR_FROM_CPU_3),
        };
        regs.write(.{
            .CPU_INTR_FROM_CPU_0 = @intFromBool(enabled),
        });
    }
};
