const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const PCR = peripherals.PCR;
const PMU = peripherals.PMU;
const rom = microzig.hal.rom;
const clocks = microzig.hal.clocks;

// helpful links:
// - https://github.com/espressif/esp-idf/blob/master/components/esp_hw_support/port/esp32c6/rtc_clk.c
// - https://github.com/espressif/esp-idf/blob/master/components/hal/esp32c6/include/hal/clk_tree_ll.h

pub const xtal_clk_freq: u32 = 40_000_000;

/// Frequency of the SPLL. Unlike the esp32c3 it is not configurable, the pll always runs at
/// 480 MHz and the cpu frequency is derived from it with a divider.
pub const pll_clk_freq: u32 = 480_000_000;

/// The AHB clock, and with it the APB clock, is fixed to 40 MHz while the cpu runs off the pll.
pub const pll_apb_clk_freq: u32 = 40_000_000;

pub const CpuClockSource = union(enum) {
    pub const PllClock = struct {
        pub const CpuFreq = enum {
            @"80mhz",
            @"120mhz",
            @"160mhz",

            /// Divider from the 480 MHz pll to this cpu frequency.
            fn divider(cpu_freq: CpuFreq) u32 {
                return switch (cpu_freq) {
                    .@"80mhz" => 6,
                    .@"120mhz" => 4,
                    .@"160mhz" => 3,
                };
            }

            fn freq(cpu_freq: CpuFreq) u32 {
                return pll_clk_freq / cpu_freq.divider();
            }
        };

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

            // The cpu and ahb low speed dividers only accept powers of two.
            if (!std.math.isPowerOfTwo(div)) {
                return error.InvalidCpuClockFrequency;
            }

            break :blk .{
                .xtal_clk = div,
            };
        } else if (cpu_clk_freq == 80_000_000) .{
            .pll_clk = .{ .cpu_freq = .@"80mhz" },
        } else if (cpu_clk_freq == 120_000_000) .{
            .pll_clk = .{ .cpu_freq = .@"120mhz" },
        } else if (cpu_clk_freq == 160_000_000) .{
            .pll_clk = .{ .cpu_freq = .@"160mhz" },
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
            .pll_clk => |pll_clk| pll_clk.cpu_freq.freq(),
            .xtal_clk => |div| xtal_clk_freq / div,
        };

        const apb_clk_freq: u32 = switch (cpu_clk_source) {
            .pll_clk => pll_apb_clk_freq,
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
                switch_to_pll(pll_clk.cpu_freq);
            },
            .xtal_clk => |div| {
                switch_to_xtal(div);
            },
        }

        rom_cpu_frequency_update(config.cpu_clk_freq);
    }
};

fn switch_to_pll(cpu_freq: CpuClockSource.PllClock.CpuFreq) void {
    const div = cpu_freq.divider();

    // High speed divider option: 1, 2, 4 (register value 0, 1, 3), applied on top of the fixed
    // divide by three from the pll to the high speed root clock. 120 MHz cannot be reached with a
    // divider and needs the dedicated force bit instead.
    PCR.CPU_FREQ_CONF.modify(.{
        .CPU_HS_DIV_NUM = @as(u8, @intCast((div / 3) - 1)),
        .CPU_HS_120M_FORCE = @intFromBool(div == 4),
    });

    // Pin the ahb clock at 480 / 12 = 40 MHz so that the apb clock does not depend on the
    // selected cpu frequency.
    PCR.AHB_FREQ_CONF.modify(.{
        .AHB_HS_DIV_NUM = (12 / 3) - 1,
    });

    PCR.SYSCLK_CONF.modify(.{
        .SOC_CLK_SEL = 1,
    });
}

fn switch_to_xtal(div: u10) void {
    // Low speed divider option: 1, 2, 4, 8, 16, 32 (register value is the divider minus one).
    PCR.AHB_FREQ_CONF.modify(.{
        .AHB_LS_DIV_NUM = @as(u8, @intCast(div - 1)),
    });

    PCR.CPU_FREQ_CONF.modify(.{
        .CPU_LS_DIV_NUM = @as(u8, @intCast(div - 1)),
    });

    // Switch clock source
    PCR.SYSCLK_CONF.modify(.{
        .SOC_CLK_SEL = 0,
    });
}

fn rom_cpu_frequency_update(freq: u32) void {
    rom.functions.ets_update_cpu_frequency(freq / 1_000_000);
}

/// Powers up the bbpll and ungates it.
///
/// NOTE: unlike the esp32c3 the analog side of the pll is not configured here. The esp32c6 rom
/// does not export the regi2c helpers, the analog registers have to be driven through the
/// LP_I2C_ANA_MST peripheral instead. The rom bootloader already calibrates the pll to 480 MHz
/// before it hands over control, so re-running that calibration is only needed once this hal
/// starts powering the pll down again.
fn bbpll_enable() void {
    PMU.IMM_HP_CK_POWER.modify(.{
        .TIE_HIGH_XPD_BB_I2C = 1,
        .TIE_HIGH_XPD_BBPLL = 1,
        .TIE_HIGH_XPD_BBPLL_I2C = 1,
    });

    PMU.IMM_HP_CK_POWER.modify(.{
        .TIE_HIGH_GLOBAL_BBPLL_ICG = 1,
    });
}
