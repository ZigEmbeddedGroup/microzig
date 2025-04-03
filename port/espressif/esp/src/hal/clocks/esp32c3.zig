const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SYSTEM = peripherals.SYSTEM;
const RTC_CNTL = peripherals.RTC_CNTL;
const rom = microzig.hal.rom;
const clocks = microzig.hal.clocks;

// helpful links:
// - https://github.com/espressif/esp-idf/blob/master/components/esp_hw_support/port/esp32c3/rtc_clk.c
// - https://github.com/esp-rs/esp-hal/blob/main/esp-hal/src/clock/mod.rs

pub const CpuClockSource = union(enum) {
    pub const PllFreq = enum {
        @"80mhz",
        @"160mhz",
    };

    pll_clk: PllFreq,
    xtal_clk: u10,
    // TODO: add support for rc_fast_clk source
};

pub const Config = struct {
    cpu_clk_source: CpuClockSource,

    cpu_clk_freq: u32,
    xtal_clk_freq: u32,
    apb_clk_freq: u32,

    /// Initializes a clock config for the given cpu frequency.
    pub fn init(cpu_clk_freq: u32) clocks.Error!Config {
        if (@inComptime()) {
            @compileError("A clock configuration can only be created at runtime");
        }

        const xtal_clk_freq = get_xtal_clk_freq();

        const cpu_clk_source: CpuClockSource = if (cpu_clk_freq <= xtal_clk_freq and cpu_clk_freq != 0) blk: {
            const div: u10 = @intCast(xtal_clk_freq / cpu_clk_freq);
            const real_freq = (xtal_clk_freq + div / 2) / div;

            if (real_freq != cpu_clk_freq) {
                return error.InvalidCpuClockFrequency;
            }

            break :blk .{
                .xtal_clk = div,
            };
        } else if (cpu_clk_freq == 80_000_000) .{
            .pll_clk = .@"80mhz",
        } else if (cpu_clk_freq == 160_000_000) .{
            .pll_clk = .@"160mhz",
        } else {
            return error.InvalidCpuClockFrequency;
        };

        const apb_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => 80_000_000,
            .xtal_clk => cpu_clk_freq,
        };

        return .{
            .cpu_clk_source = cpu_clk_source,
            .cpu_clk_freq = cpu_clk_freq,
            .xtal_clk_freq = xtal_clk_freq,
            .apb_clk_freq = apb_clk_freq,
        };
    }

    /// Applies this clock configuration. Internal use only. Use `hal.clocks.apply()` instead.
    pub fn apply(config: Config) void {
        switch (config.cpu_clk_source) {
            .pll_clk => |pll_freq| {
                bbpll_enable();
                bbpll_configure();
                switch_to_pll(pll_freq);
            },
            .xtal_clk => |div| {
                switch_to_xtal(div);
            },
        }

        apb_freq_update(config.apb_clk_freq);
        rom_cpu_frequency_update(config.cpu_clk_freq);
    }
};

fn switch_to_pll(pll_freq: CpuClockSource.PllFreq) void {
    SYSTEM.SYSCLK_CONF.modify(.{
        .PRE_DIV_CNT = 0,
        .SOC_CLK_SEL = 1,
    });

    SYSTEM.CPU_PER_CONF.modify(.{
        .CPUPERIOD_SEL = @as(u1, switch (pll_freq) {
            .@"80mhz" => 0,
            .@"160mhz" => 1,
        }),
    });
}

fn switch_to_xtal(div: u10) void {
    // Set divider from XTAL to APB clock. Need to set divider to 1 (reg. value 0) first.
    SYSTEM.SYSCLK_CONF.modify(.{
        .PRE_DIV_CNT = 0,
    });
    SYSTEM.SYSCLK_CONF.modify(.{
        .PRE_DIV_CNT = div - 1,
    });

    // Switch clock source
    SYSTEM.SYSCLK_CONF.modify(.{
        .SOC_CLK_SEL = 0,
    });
}

fn apb_freq_update(freq: u32) void {
    const value = ((freq >> 12) & @as(u32, std.math.maxInt(u16))) |
        (((freq >> 12) & @as(u32, std.math.maxInt(u16))) << 16);
    RTC_CNTL.STORE5.write_raw(value);
}

fn rom_cpu_frequency_update(freq: u32) void {
    rom.functions.ets_update_cpu_frequency(freq / 1_000_000);
}

fn get_xtal_clk_freq() u32 {
    const xtal_freq_reg = RTC_CNTL.STORE4.read().RTC_SCRATCH4;
    if ((xtal_freq_reg & 0xFFFF) == ((xtal_freq_reg >> 16) & 0xFFFF) and
        xtal_freq_reg != 0 and xtal_freq_reg != std.math.maxInt(u32))
    {
        return xtal_freq_reg & ~@as(u32, (1 << 0) | (1 << 16)) & std.math.maxInt(u16);
    }

    @panic("invalid format of xtal register");
}

fn bbpll_enable() void {
    RTC_CNTL.OPTIONS0.modify(.{
        .BB_I2C_FORCE_PD = 0,
        .BBPLL_FORCE_PD = 0,
        .BBPLL_I2C_FORCE_PD = 0,
    });
}

fn bbpll_configure() void {
    SYSTEM.CPU_PER_CONF.modify(.{
        .PLL_FREQ_SEL = 1, // 480mhz
    });

    I2C_ANA_MST.ANA_CONF0.modify(.{
        .BBPLL_STOP_FORCE_HIGH = 0,
        .BBPLL_STOP_FORCE_LOW = 1,
    });

    // specific for 480mhz pll
    const i2c_bbpll_oc_dchgp_lsb: u32 = 4;
    const i2c_bbpll_oc_dlref_sel_lsb: u32 = 6;
    const i2c_bbpll_oc_dhref_sel_lsb: u32 = 4;

    const div_ref: u8 = 0;
    const div7_0: u8 = 8;
    const dr1: u8 = 0;
    const dr3: u8 = 0;
    const dchgp: u8 = 5;
    const dcur: u8 = 3;
    const dbias: u8 = 2;

    const i2c_bbpll_lref = (dchgp << i2c_bbpll_oc_dchgp_lsb) | div_ref;
    const i2c_bbpll_dcur =
        (2 << i2c_bbpll_oc_dlref_sel_lsb) | (1 << i2c_bbpll_oc_dhref_sel_lsb) | dcur;

    rom.functions.rom_i2c_writeReg(0x66, 0, 4, 0x6b);

    rom.functions.rom_i2c_writeReg(0x66, 0, 2, i2c_bbpll_lref);
    rom.functions.rom_i2c_writeReg(0x66, 0, 3, div7_0);

    {
        var value = rom.functions.rom_i2c_readReg(0x66, 0, 5);
        value &= ~@as(u8, 0b111);
        value &= ~@as(u8, 0b111 << 4);
        value |= dr1;
        value |= dr3 << 4;
        rom.functions.rom_i2c_writeReg(0x66, 0, 5, value);
    }

    rom.functions.rom_i2c_writeReg(0x66, 0, 6, i2c_bbpll_dcur);

    {
        var value = rom.functions.rom_i2c_readReg(0x66, 0, 9);
        value &= ~@as(u8, 0b11);
        value |= dbias;
        rom.functions.rom_i2c_writeReg(0x66, 0, 9, value);
    }

    {
        var value = rom.functions.rom_i2c_readReg(0x66, 0, 6);
        value &= ~@as(u8, 0b11 << 4);
        value &= ~@as(u8, 0b11 << 6);
        value |= 2 << 4;
        value |= 1 << 6;
        rom.functions.rom_i2c_writeReg(0x66, 0, 6, value);
    }
}

const I2C_ANA_MST_TYPE = extern struct {
    ANA_CONF0: microzig.mmio.Mmio(packed struct {
        reserved0: u2,
        BBPLL_STOP_FORCE_HIGH: u1,
        BBPLL_STOP_FORCE_LOW: u1,
        padding: u28,
    }),
};

const I2C_ANA_MST: *volatile I2C_ANA_MST_TYPE = @ptrFromInt(0x6000E040);
