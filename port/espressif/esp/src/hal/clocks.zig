const std = @import("std");
const microzig = @import("microzig");
const rom = microzig.hal.rom;
const peripherals = microzig.chip.peripherals;
const SYSTEM = peripherals.SYSTEM;
const RTC_CNTL = peripherals.RTC_CNTL;

pub const Config = struct {
    pub var maybe_active: ?Config = null;

    cpu_clk_source: CpuClockSource,
    cpu_clk_freq: u32,
    xtal_clk_freq: u32,
    apb_clk_freq: u32,

    pub const CpuClockSource = union(enum) {
        pub const PllFreq = enum {
            @"80mhz",
            @"160mhz",
        };

        pll_clk: PllFreq,
        xtal_clk: u10,
        // TODO: rc_fast_clk
    };

    /// Gets the active clock config. Asserts **there is** an active clock config.
    pub fn get_active() Config {
        return maybe_active.?;
    }

    /// Creates a clock config from `CpuClockSource`.
    pub fn init_from_cpu_clock_source(cpu_clk_source: CpuClockSource) Config {
        if (@inComptime()) {
            @compileError("A clock configuration can only be created at runtime");
        }

        const xtal_clk_freq = measure_xtal_clk_freq();

        const cpu_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => |pll_freq| switch (pll_freq) {
                .@"80mhz" => 80_000_000,
                .@"160mhz" => 160_000_000,
            },
            .xtal_clk => |div| blk: {
                std.debug.assert(div != 0);

                break :blk xtal_clk_freq / div;
            },
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

    /// Creates a clock config for a requested cpu frequency.
    pub fn init_from_cpu_frequency(cpu_clk_freq: u32) error{InvalidCpuFrequency}!Config {
        if (@inComptime()) {
            @compileError("A clock configuration can only be created at runtime");
        }

        const xtal_clk_freq = measure_xtal_clk_freq();

        if (cpu_clk_freq <= xtal_clk_freq and cpu_clk_freq != 0) {
            const div: u10 = @intCast(xtal_clk_freq / cpu_clk_freq);
            const real_freq = (xtal_clk_freq + div / 2) / div;

            if (real_freq != cpu_clk_freq) {
                return error.InvalidCpuFrequency;
            }

            return init_from_cpu_clock_source(.{
                .xtal_clk = div,
            });
        } else if (cpu_clk_freq == 80_000_000) {
            return init_from_cpu_clock_source(.{
                .pll_clk = .@"80mhz",
            });
        } else if (cpu_clk_freq == 160_000_000) {
            return init_from_cpu_clock_source(.{
                .pll_clk = .@"160mhz",
            });
        } else {
            return error.InvalidCpuFrequency;
        }
    }

    /// Applies the current clock configuration.
    pub fn apply(config: Config) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        switch (config.cpu_clk_source) {
            .pll_clk => |pll_freq| {
                {
                    rom.rom_i2c_writeReg(0x66, 0, 4, 0x6b);

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

                    rom.rom_i2c_writeReg(0x66, 0, 2, i2c_bbpll_lref);
                    rom.rom_i2c_writeReg(0x66, 0, 3, div7_0);

                    {
                        var value = rom.rom_i2c_readReg(0x66, 0, 5);
                        value &= ~@as(u8, 0b111);
                        value &= ~@as(u8, 0b111 << 4);
                        value |= dr1;
                        value |= dr3 << 4;
                        rom.rom_i2c_writeReg(0x66, 0, 5, value);
                    }

                    rom.rom_i2c_writeReg(0x66, 0, 6, i2c_bbpll_dcur);

                    {
                        var value = rom.rom_i2c_readReg(0x66, 0, 9);
                        value &= ~@as(u8, 0b11);
                        value |= dbias;
                        rom.rom_i2c_writeReg(0x66, 0, 9, value);
                    }

                    {
                        var value = rom.rom_i2c_readReg(0x66, 0, 6);
                        value &= ~@as(u8, 0b11 << 4);
                        value &= ~@as(u8, 0b11 << 6);
                        value |= 2 << 4;
                        value |= 1 << 6;
                        rom.rom_i2c_writeReg(0x66, 0, 6, value);
                    }
                }

                RTC_CNTL.OPTIONS0.modify(.{
                    .BB_I2C_FORCE_PD = 0,
                    .BBPLL_FORCE_PD = 0,
                    .BBPLL_I2C_FORCE_PD = 0,
                });

                SYSTEM.CPU_PER_CONF.modify(.{
                    .PLL_FREQ_SEL = 1, // 480mhz
                });

                I2C_ANA_MST.ANA_CONF0.modify(.{
                    .BBPLL_STOP_FORCE_HIGH = 0,
                    .BBPLL_STOP_FORCE_LOW = 1,
                });

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

                rom.ets_update_cpu_frequency(to_mhz(config.cpu_clk_freq));
            },
            .xtal_clk => |div| {
                rom.ets_update_cpu_frequency(to_mhz(config.cpu_clk_freq));

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

                // maybe disable bbpll if no consumers depend on it
            },
        }

        // clk_ll_apb_store_freq_hz
        const value = ((config.apb_clk_freq >> 12) & @as(u32, std.math.maxInt(u16))) |
            (((config.apb_clk_freq >> 12) & @as(u32, std.math.maxInt(u16))) << 16);
        RTC_CNTL.STORE5.modify(.{ .RTC_SCRATCH5 = value });

        maybe_active = config;
    }
};

/// Returns the xtal_clk frequency.
// TODO: should be chip dependent (when we will support multiple chips)
pub fn measure_xtal_clk_freq() u32 {
    return 40_000_000;
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

fn to_mhz(freq: u32) u32 {
    return freq / 1_000_000;
}
