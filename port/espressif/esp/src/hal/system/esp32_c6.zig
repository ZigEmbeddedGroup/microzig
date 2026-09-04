const std = @import("std");
const microzig = @import("microzig");

const PCR = microzig.chip.peripherals.PCR;
const INTPRI = microzig.chip.peripherals.INTPRI;

/// Peripheral mask for the PCR configuration registers.
///
/// Unlike the esp32c3, which gathers every peripheral into two PERIP_CLK_ENx bitmasks, the
/// esp32c6 gives each peripheral its own PCR configuration register holding a clock enable and a
/// reset bit. The mask below is therefore a plain set of flags rather than a hardware layout.
pub const PeripheralMask = packed struct {
    pub const empty: PeripheralMask = .{};
    pub const all: PeripheralMask = empty.inverse();

    pub const keep_enabled: PeripheralMask = .{
        .uart0 = true,
        .usb_device = true,
        .systimer = true,
        .intmtx = true,
        .iomux = true,
        .cache = true,
        .assist = true,

        // NOTE: MSPI drives the flash the code is executing from.
        .mspi = true,
    };

    pub const all_but_keep_enabled: PeripheralMask = all.subtract(keep_enabled.inverse());

    uart0: bool = false,
    uart1: bool = false,
    mspi: bool = false,
    i2c_ext0: bool = false,
    uhci0: bool = false,
    rmt: bool = false,
    ledc: bool = false,
    timergroup0: bool = false,
    timergroup1: bool = false,
    systimer: bool = false,
    twai0: bool = false,
    twai1: bool = false,
    i2s0: bool = false,
    apb_saradc: bool = false,
    tsens: bool = false,
    usb_device: bool = false,
    intmtx: bool = false,
    pcnt: bool = false,
    etm: bool = false,
    mcpwm: bool = false,
    parl_io: bool = false,
    sdio_slave: bool = false,
    pvt_monitor: bool = false,
    dma: bool = false,
    spi2: bool = false,
    crypto_aes: bool = false,
    crypto_sha: bool = false,
    crypto_rsa: bool = false,
    crypto_ecc: bool = false,
    crypto_ds: bool = false,
    crypto_hmac: bool = false,
    iomux: bool = false,
    mem_monitor: bool = false,
    regdma: bool = false,
    retention: bool = false,
    trace: bool = false,
    assist: bool = false,
    cache: bool = false,
    modem_apb: bool = false,

    const Backing = @typeInfo(PeripheralMask).@"struct".backing_integer.?;

    /// Combines two peripherals masks. Binary or.
    pub fn combine(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(Backing, @bitCast(self)) | @as(Backing, @bitCast(other)));
    }

    /// Subtracts two peripherals masks. Binary and.
    pub fn subtract(self: PeripheralMask, other: PeripheralMask) PeripheralMask {
        return @bitCast(@as(Backing, @bitCast(self)) & @as(Backing, @bitCast(other)));
    }

    /// Inverses the peripheral mask. Binary not.
    pub fn inverse(self: PeripheralMask) PeripheralMask {
        return @bitCast(~@as(Backing, @bitCast(self)));
    }
};

/// Maps a `PeripheralMask` field onto the PCR configuration register that gates it.
const Mapping = struct {
    /// Name of the `PeripheralMask` field.
    field: []const u8,
    /// Name of the PCR configuration register.
    register: []const u8,
    /// Prefix of the `_CLK_EN` and `_RST_EN` fields inside that register. It does not always
    /// match the name of the register, TIMERGROUP0_CONF holds TG0_CLK_EN for example.
    prefix: []const u8,
};

const mappings: []const Mapping = &.{
    .{ .field = "uart0", .register = "UART0_CONF", .prefix = "UART0" },
    .{ .field = "uart1", .register = "UART1_CONF", .prefix = "UART1" },
    .{ .field = "mspi", .register = "MSPI_CONF", .prefix = "MSPI" },
    .{ .field = "i2c_ext0", .register = "I2C_CONF", .prefix = "I2C" },
    .{ .field = "uhci0", .register = "UHCI_CONF", .prefix = "UHCI" },
    .{ .field = "rmt", .register = "RMT_CONF", .prefix = "RMT" },
    .{ .field = "ledc", .register = "LEDC_CONF", .prefix = "LEDC" },
    .{ .field = "timergroup0", .register = "TIMERGROUP0_CONF", .prefix = "TG0" },
    .{ .field = "timergroup1", .register = "TIMERGROUP1_CONF", .prefix = "TG1" },
    .{ .field = "systimer", .register = "SYSTIMER_CONF", .prefix = "SYSTIMER" },
    .{ .field = "twai0", .register = "TWAI0_CONF", .prefix = "TWAI0" },
    .{ .field = "twai1", .register = "TWAI1_CONF", .prefix = "TWAI1" },
    .{ .field = "i2s0", .register = "I2S_CONF", .prefix = "I2S" },
    .{ .field = "apb_saradc", .register = "SARADC_CONF", .prefix = "SARADC" },
    .{ .field = "tsens", .register = "TSENS_CLK_CONF", .prefix = "TSENS" },
    .{ .field = "usb_device", .register = "USB_DEVICE_CONF", .prefix = "USB_DEVICE" },
    .{ .field = "intmtx", .register = "INTMTX_CONF", .prefix = "INTMTX" },
    .{ .field = "pcnt", .register = "PCNT_CONF", .prefix = "PCNT" },
    .{ .field = "etm", .register = "ETM_CONF", .prefix = "ETM" },
    .{ .field = "mcpwm", .register = "PWM_CONF", .prefix = "PWM" },
    .{ .field = "parl_io", .register = "PARL_IO_CONF", .prefix = "PARL" },
    .{ .field = "sdio_slave", .register = "SDIO_SLAVE_CONF", .prefix = "SDIO_SLAVE" },
    .{ .field = "pvt_monitor", .register = "PVT_MONITOR_CONF", .prefix = "PVT_MONITOR" },
    .{ .field = "dma", .register = "GDMA_CONF", .prefix = "GDMA" },
    .{ .field = "spi2", .register = "SPI2_CONF", .prefix = "SPI2" },
    .{ .field = "crypto_aes", .register = "AES_CONF", .prefix = "AES" },
    .{ .field = "crypto_sha", .register = "SHA_CONF", .prefix = "SHA" },
    .{ .field = "crypto_rsa", .register = "RSA_CONF", .prefix = "RSA" },
    .{ .field = "crypto_ecc", .register = "ECC_CONF", .prefix = "ECC" },
    .{ .field = "crypto_ds", .register = "DS_CONF", .prefix = "DS" },
    .{ .field = "crypto_hmac", .register = "HMAC_CONF", .prefix = "HMAC" },
    .{ .field = "iomux", .register = "IOMUX_CONF", .prefix = "IOMUX" },
    .{ .field = "mem_monitor", .register = "MEM_MONITOR_CONF", .prefix = "MEM_MONITOR" },
    .{ .field = "regdma", .register = "REGDMA_CONF", .prefix = "REGDMA" },
    .{ .field = "retention", .register = "RETENTION_CONF", .prefix = "RETENTION" },
    .{ .field = "trace", .register = "TRACE_CONF", .prefix = "TRACE" },
    .{ .field = "assist", .register = "ASSIST_CONF", .prefix = "ASSIST" },
    .{ .field = "cache", .register = "CACHE_CONF", .prefix = "CACHE" },
    // NOTE: the modem block gates its clock and its reset from the same register, but the reset
    // bit is called MODEM_RST_EN rather than MODEM_APB_RST_EN.
    .{ .field = "modem_apb", .register = "MODEM_APB_CONF", .prefix = "MODEM_APB" },
};

comptime {
    // Every mask field must be backed by a mapping, otherwise setting it would silently do
    // nothing.
    @setEvalBranchQuota(@typeInfo(PeripheralMask).@"struct".field_names.len * mappings.len * 16);
    for (std.meta.fieldNames(PeripheralMask)) |field| {
        for (mappings) |mapping| {
            if (std.mem.eql(u8, mapping.field, field)) break;
        } else @compileError("no PCR mapping for peripheral mask field \"" ++ field ++ "\"");
    }
}

const Bit = enum {
    clock_enable,
    reset,

    fn suffix(bit: Bit) []const u8 {
        return switch (bit) {
            .clock_enable => "_CLK_EN",
            .reset => "_RST_EN",
        };
    }
};

fn write_bit(mask: PeripheralMask, comptime bit: Bit, value: u1) void {
    inline for (mappings) |mapping| {
        if (@field(mask, mapping.field)) {
            const register = &@field(PCR, mapping.register);
            const name = comptime blk: {
                // MODEM_APB_CONF is the one register whose reset bit does not repeat the full
                // prefix of its clock enable bit.
                if (bit == .reset and std.mem.eql(u8, mapping.register, "MODEM_APB_CONF"))
                    break :blk "MODEM_RST_EN";
                break :blk mapping.prefix ++ bit.suffix();
            };

            var current = register.read();
            @field(current, name) = value;
            register.write(current);
        }
    }
}

/// Disables most peripheral clocks and puts peripherals in the reset state to bring them to a
/// known state.
pub fn init() void {
    clocks_enable_clear(.all_but_keep_enabled);
    peripheral_reset_set(.all_but_keep_enabled);
}

/// Sets the clock enable bits of the peripherals in the mask.
pub fn clocks_enable_set(mask: PeripheralMask) void {
    write_bit(mask, .clock_enable, 1);
}

/// Clears the clock enable bits of the peripherals in the mask.
pub fn clocks_enable_clear(mask: PeripheralMask) void {
    write_bit(mask, .clock_enable, 0);
}

/// Sets and clears the reset bits of the peripherals in the mask. Resets the peripherals.
pub fn peripheral_reset(mask: PeripheralMask) void {
    peripheral_reset_set(mask);
    peripheral_reset_clear(mask);
}

/// Sets the reset bits of the peripherals in the mask.
pub fn peripheral_reset_set(mask: PeripheralMask) void {
    write_bit(mask, .reset, 1);
}

/// Clears the reset bits of the peripherals in the mask.
pub fn peripheral_reset_clear(mask: PeripheralMask) void {
    write_bit(mask, .reset, 0);
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
            .cpu_interrupt_0 => .cpu_intr_from_cpu_0,
            .cpu_interrupt_1 => .cpu_intr_from_cpu_1,
            .cpu_interrupt_2 => .cpu_intr_from_cpu_2,
            .cpu_interrupt_3 => .cpu_intr_from_cpu_3,
        };
    }

    pub fn set_pending(cpu_interrupt: CPU_Interrupt, enabled: bool) void {
        const regs: @TypeOf(&INTPRI.CPU_INTR_FROM_CPU_0) = switch (cpu_interrupt) {
            .cpu_interrupt_0 => @ptrCast(&INTPRI.CPU_INTR_FROM_CPU_0),
            .cpu_interrupt_1 => @ptrCast(&INTPRI.CPU_INTR_FROM_CPU_1),
            .cpu_interrupt_2 => @ptrCast(&INTPRI.CPU_INTR_FROM_CPU_2),
            .cpu_interrupt_3 => @ptrCast(&INTPRI.CPU_INTR_FROM_CPU_3),
        };
        regs.write(.{
            .CPU_INTR_FROM_CPU_0 = @intFromBool(enabled),
        });
    }
};
