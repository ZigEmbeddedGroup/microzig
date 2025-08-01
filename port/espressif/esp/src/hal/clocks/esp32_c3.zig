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

pub const xtal_clk_freq: u32 = 40_000_000;

pub const CpuClockSource = union(enum) {
    pub const PllClock = struct {
        pub const PllFreq = enum {
            @"320mhz",
            @"480mhz",
        };

        pub const CpuFreq = enum {
            @"80mhz",
            @"160mhz",
        };

        pll_freq: PllFreq,
        cpu_freq: CpuFreq,
    };

    pll_clk: PllClock,
    xtal_clk: u10,
    // TODO: add support for rc_fast_clk source
};

pub const Config = struct {
    /// Default clock config.
    pub const default: Config = .init_comptime(80_000_000);

    cpu_clk_source: CpuClockSource,

    cpu_clk_freq: u32,
    apb_clk_freq: u32,

    /// Initializes a clock config for this cpu frequency.
    pub fn init(cpu_clk_freq: u32) clocks.Error!Config {
        const cpu_clk_source: CpuClockSource = if (cpu_clk_freq <= xtal_clk_freq and cpu_clk_freq != 0) blk: {
            const div: u10 = @intCast(xtal_clk_freq / cpu_clk_freq);
            const real_freq: u32 = (xtal_clk_freq + div / 2) / div;

            if (real_freq != cpu_clk_freq) {
                return error.InvalidCpuClockFrequency;
            }

            break :blk .{
                .xtal_clk = div,
            };
        } else if (cpu_clk_freq == 80_000_000) .{
            .pll_clk = .{
                .pll_freq = .@"480mhz",
                .cpu_freq = .@"80mhz",
            },
        } else if (cpu_clk_freq == 160_000_000) .{
            .pll_clk = .{
                .pll_freq = .@"480mhz",
                .cpu_freq = .@"160mhz",
            },
        } else {
            return error.InvalidCpuClockFrequency;
        };

        return init_from_cpu_clock_source(cpu_clk_source);
    }

    /// Initializes a clock config for this cpu frequency at comptime. Triggers a compilation error
    /// if the frequency is invalid.
    pub fn init_comptime(cpu_clk_freq: u32) Config {
        return init(cpu_clk_freq) catch {
            @compileError(std.fmt.comptimePrint("Invalid cpu clock frequency: {}", .{cpu_clk_freq}));
        };
    }

    /// Initializes a clock config from a cpu clock source.
    pub fn init_from_cpu_clock_source(cpu_clk_source: CpuClockSource) Config {
        const cpu_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => |pll_clk| switch (pll_clk.cpu_freq) {
                .@"80mhz" => 80_000_000,
                .@"160mhz" => 80_000_000,
            },
            .xtal_clk => |div| xtal_clk_freq / div,
        };

        const apb_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => 80_000_000,
            .xtal_clk => cpu_clk_freq,
        };

        return .{
            .cpu_clk_source = cpu_clk_source,
            .cpu_clk_freq = cpu_clk_freq,
            .apb_clk_freq = apb_clk_freq,
        };
    }

    /// Applies this clock config.
    pub fn apply(config: Config) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        switch (config.cpu_clk_source) {
            .pll_clk => |pll_clk| {
                bbpll_enable();
                bbpll_configure(pll_clk.pll_freq);
                switch_to_pll(pll_clk.cpu_freq);
            },
            .xtal_clk => |div| {
                switch_to_xtal(div);
            },
        }

        apb_freq_update(config.apb_clk_freq);
        rom_cpu_frequency_update(config.cpu_clk_freq);
    }
};

fn switch_to_pll(pll_freq: CpuClockSource.PllClock.CpuFreq) void {
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

fn bbpll_enable() void {
    RTC_CNTL.OPTIONS0.modify(.{
        .BB_I2C_FORCE_PD = 0,
        .BBPLL_FORCE_PD = 0,
        .BBPLL_I2C_FORCE_PD = 0,
    });
}

fn bbpll_configure(pll_freq: CpuClockSource.PllClock.PllFreq) void {
    SYSTEM.CPU_PER_CONF.modify(.{
        .PLL_FREQ_SEL = @as(u1, switch (pll_freq) {
            .@"320mhz" => 0,
            .@"480mhz" => 1,
        }),
    });

    I2C_ANA_MST.ANA_CONF0.modify(.{
        .BBPLL_STOP_FORCE_HIGH = 0,
        .BBPLL_STOP_FORCE_LOW = 1,
    });

    const i2c_bbpll_oc_dchgp_lsb: u32 = 4;
    const i2c_bbpll_oc_dlref_sel_lsb: u32 = 6;
    const i2c_bbpll_oc_dhref_sel_lsb: u32 = 4;

    var div_ref: u8 = undefined;
    var div7_0: u8 = undefined;
    var dr1: u8 = undefined;
    var dr3: u8 = undefined;
    var dchgp: u8 = undefined;
    var dcur: u8 = undefined;
    var dbias: u8 = undefined;

    // specific to 40mhz xtal freq
    switch (pll_freq) {
        .@"320mhz" => {
            div_ref = 0;
            div7_0 = 4;
            dr1 = 0;
            dr3 = 0;
            dchgp = 5;
            dcur = 3;
            dbias = 2;

            rom.functions.esp_rom_regi2c_write(0x66, 0, 4, 0x69); // I2C_BBPLL_REG4
        },
        .@"480mhz" => {
            div_ref = 0;
            div7_0 = 8;
            dr1 = 0;
            dr3 = 0;
            dchgp = 5;
            dcur = 3;
            dbias = 2;

            rom.functions.esp_rom_regi2c_write(0x66, 0, 4, 0x6b); // I2C_BBPLL_REG4
        },
    }

    const i2c_bbpll_lref: u8 = (dchgp << i2c_bbpll_oc_dchgp_lsb) | div_ref;
    const i2c_bbpll_dcur: u8 =
        (2 << i2c_bbpll_oc_dlref_sel_lsb) | (1 << i2c_bbpll_oc_dhref_sel_lsb) | dcur;

    rom.functions.esp_rom_regi2c_write(0x66, 0, 2, i2c_bbpll_lref); // I2C_BBPLL_OC_REF
    rom.functions.esp_rom_regi2c_write(0x66, 0, 3, div7_0); // I2C_BBPLL_OC_DIV_REG

    rom.functions.esp_rom_regi2c_write_mask(0x66, 0, 5, 2, 0, dr1); // I2C_BBPLL_OC_DR1
    rom.functions.esp_rom_regi2c_write_mask(0x66, 0, 5, 6, 4, dr3); // I2C_BBPLL_OC_DR3
    // {
    //     var value = rom.functions.esp_rom_regi2c_read(0x66, 0, 5);
    //     value &= ~@as(u8, 0b111);
    //     value &= ~@as(u8, 0b111 << 4);
    //     value |= dr1;
    //     value |= dr3 << 4;
    //     rom.functions.esp_rom_regi2c_write(0x66, 0, 5, value);
    // }

    rom.functions.esp_rom_regi2c_write(0x66, 0, 6, i2c_bbpll_dcur); // I2C_BBPLL_REG6

    rom.functions.esp_rom_regi2c_write_mask(0x66, 0, 9, 1, 0, dbias); // I2C_BBPLL_OC_VCO_DBIAS
    // {
    //     var value = rom.functions.esp_rom_regi2c_read(0x66, 0, 9);
    //     value &= ~@as(u8, 0b11);
    //     value |= dbias;
    //     rom.functions.esp_rom_regi2c_write(0x66, 0, 9, value);
    // }

    rom.functions.esp_rom_regi2c_write_mask(0x66, 0, 6, 5, 4, 2); // I2C_BBPLL_OC_DHREF_SEL
    rom.functions.esp_rom_regi2c_write_mask(0x66, 0, 6, 7, 6, 1); // I2C_BBPLL_OC_DLREF_SEL
    // {
    //     var value = rom.functions.esp_rom_regi2c_read(0x66, 0, 6);
    //     value &= ~@as(u8, 0b11 << 4);
    //     value &= ~@as(u8, 0b11 << 6);
    //     value |= 2 << 4;
    //     value |= 1 << 6;
    //     rom.functions.esp_rom_regi2c_write(0x66, 0, 6, value);
    // }
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
