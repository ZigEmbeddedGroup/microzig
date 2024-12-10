const std = @import("std");
const assert = std.debug.assert;

const common = @import("common.zig");
pub const xosc = common.xosc;
pub const xosc_freq = common.xosc_freq;

// xosc limits
comptime {
    assert(xosc_freq <= 15_000_000 and xosc_freq >= 1_000_000);
}

const calculate_integer_divisor = common.calculate_integer_divisor;
const rosc_freq = common.rosc_freq;
const pll = @import("../pll.zig");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const CLOCKS = peripherals.CLOCKS;
const WATCHDOG = peripherals.WATCHDOG;
const AUX_SRC_SETTING_SRC_REG = common.AUX_SRC_SETTING_SRC_REG;

pub const Source =
    enum {
    src_rosc,
    src_xosc,
    src_gpin0,
    src_gpin1,
    pll_sys,
    pll_usb,
    clk_sys,
    clk_ref,
    clk_usb,
    clk_adc,
    clk_rtc,

    /// Gets the integer value for the given clock generator's _CTRL[SRC] bitfield that
    /// configures the given source. This is only relevant to glitchless sources (ref/sys).
    pub fn src_for(source: Source, generator: Generator) u32 {
        assert(generator.has_glitchless_mux());

        return switch (generator) {
            .sys => src: {
                const ret: u32 = switch (source) {
                    .clk_ref => 0,
                    else => AUX_SRC_SETTING_SRC_REG,
                };
                break :src ret;
            },
            .ref => src: {
                const ret: u32 = switch (source) {
                    .src_rosc => 0,
                    .src_xosc => 2,
                    else => AUX_SRC_SETTING_SRC_REG,
                };
                break :src ret;
            },
            else => @panic("Only allowed for glitchless SYS and REF clocks"),
        };
    }

    /// Gets the integer value for the given clock generator's _CTRL[AUXSRC] bitfield that
    /// configures the given source.
    pub fn aux_src_for(source: Source, generator: Generator) u32 {
        return switch (generator) {
            .sys => auxsrc: {
                const ret: u32 = switch (source) {
                    .pll_sys => 0,
                    .pll_usb => 1,
                    .src_rosc => 2,
                    .src_xosc => 3,
                    .src_gpin0 => 4,
                    .src_gpin1 => 5,
                    else => @panic("invalid aux source for generator"),
                };
                break :auxsrc ret;
            },
            .ref => auxsrc: {
                const ret: u32 = switch (source) {
                    .pll_usb => 0,
                    .src_gpin0 => 1,
                    .src_gpin1 => 2,
                    else => @panic("invalid aux source for generator"),
                };
                break :auxsrc ret;
            },
            .peri => auxsrc: {
                const ret: u32 = switch (source) {
                    .clk_sys => 0,
                    .pll_sys => 1,
                    .pll_usb => 2,
                    .src_rosc => 3,
                    .src_xosc => 4,
                    .src_gpin0 => 5,
                    .src_gpin1 => 6,
                    else => @panic("invalid aux source for generator"),
                };
                break :auxsrc ret;
            },
            .usb, .adc, .rtc => auxsrc: {
                const ret: u32 = switch (source) {
                    .pll_usb => 0,
                    .pll_sys => 1,
                    .src_rosc => 2,
                    .src_xosc => 3,
                    .src_gpin0 => 4,
                    .src_gpin1 => 5,
                    else => @panic("invalid aux source for generator"),
                };
                break :auxsrc ret;
            },
            .gpout0, .gpout1, .gpout2, .gpout3 => auxsrc: {
                const ret: u32 = switch (source) {
                    .pll_sys => 0,
                    .src_gpin0 => 1,
                    .src_gpin1 => 2,
                    .pll_usb => 3,
                    .src_rosc => 4,
                    .src_xosc => 5,
                    .clk_sys => 6,
                    .clk_usb => 7,
                    .clk_adc => 8,
                    .clk_rtc => 9,
                    .clk_ref => 10,
                };
                break :auxsrc ret;
            },
        };
    }

    /// Determines for a given generator if this source will need to be
    /// set in the AUX_SRC register
    pub fn is_aux_src_for(source: Source, generator: Generator) bool {
        return switch (generator) {
            .sys => switch (source) {
                .clk_ref => false,
                else => true,
            },
            .ref => switch (source) {
                .src_rosc, .src_xosc => false,
                else => true,
            },
            else => true,
        };
    }
};

pub const Generator =
    enum(u32) {
    gpout0 = 0,
    gpout1,
    gpout2,
    gpout3,
    ref,
    sys,
    peri,
    usb,
    adc,
    rtc,

    const Impl = common.GeneratorImpl(Generator, Source, u24);
    pub const Regs = Impl.Regs;

    pub const get_regs = Impl.get_regs;
    pub const has_glitchless_mux = Impl.has_glitchless_mux;
    pub const enable = Impl.enable;
    pub const selected = Impl.selected;
    pub const clear_source = Impl.clear_source;
    pub const disable = Impl.disable;
    pub const set_source = Impl.set_source;
    pub const set_aux_source = Impl.set_aux_source;
    pub const apply = Impl.apply;

    pub fn set_div(comptime generator: Generator, comptime div: u32) void {
        comptime {
            if ((div & 0xFF) > 0)
                @compileError("TODO: Currently don't support fractional clock dividers due to potential clock jitter headaches");
            const int_component: u24 = @intCast(div >> 8);

            switch (generator) {
                .gpout0, .gpout1, .gpout2, .gpout3, .sys, .rtc => {
                    // No checks required on int component, can be full 24 bits
                },
                .usb, .ref, .adc => {
                    if (int_component > std.math.maxInt(u2)) @compileError("CLK_REF only supports integer divisors of 2 bits");
                },
                .peri => {
                    if (int_component != 1) @compileError("CLK_PERI only supports a peripheral divisor of 1");
                },
            }
        }

        // Peripheral clock divisor always fixed to 1
        if (generator == .peri)
            return;

        generator.get_regs().div = div;
    }

    pub fn get_div(generator: Generator) u32 {
        // Peripheral clock divisor is always fixed to 1
        if (generator == .peri)
            return 1;

        return generator.get_regs().div;
    }
};

pub const config = struct {
    pub const Global = struct {
        pub const GeneratorConfig = common.GeneratorConfig(Source, u24);

        ref: ?GeneratorConfig = null,
        sys: ?GeneratorConfig = null,
        usb: ?GeneratorConfig = null,
        adc: ?GeneratorConfig = null,
        rtc: ?GeneratorConfig = null,
        peri: ?GeneratorConfig = null,
        gpout0: ?GeneratorConfig = null,
        gpout1: ?GeneratorConfig = null,
        gpout2: ?GeneratorConfig = null,
        gpout3: ?GeneratorConfig = null,
        pll_sys: ?pll.Configuration = null,
        pll_usb: ?pll.Configuration = null,

        /// If sys clock is already configured, and the user just wants to configure the peripheral clock, for instance,
        /// they must use this member to specify what the current sys frequency is so the API knows how long to wait for
        /// a given clock to stabilize
        sys_freq: ?u32 = null,

        /// Gets a given clock source's configured output frequency if it's been configured
        pub fn get_frequency(cfg: Global, source: Source) ?u32 {
            return switch (source) {
                .src_xosc => xosc_freq,
                .src_rosc => rosc_freq,
                .clk_sys => if (cfg.sys) |sys_cfg| sys_cfg.frequency() else null,
                .clk_usb => if (cfg.usb) |usb_cfg| usb_cfg.frequency() else null,
                .clk_ref => if (cfg.ref) |ref_cfg| ref_cfg.frequency() else null,
                .clk_adc => if (cfg.adc) |adc_cfg| adc_cfg.frequency() else null,
                .clk_rtc => if (cfg.rtc) |rtc_cfg| rtc_cfg.frequency() else null,
                .pll_sys => if (cfg.pll_sys) |pll_sys_cfg| pll_sys_cfg.frequency() else null,
                .pll_usb => if (cfg.pll_usb) |pll_usb_cfg| pll_usb_cfg.frequency() else null,
                .src_gpin0, .src_gpin1 => @panic("TODO: No way to know the frequency of an external clock input unless specified by user."),
            };
        }

        /// Apply must be used with a comptime known Global configuration so that
        /// validity of settings can be checked at compile time
        pub fn apply(comptime cfg: Global) void {
            const sys_freq = comptime if (cfg.get_frequency(.clk_sys)) |val|
                val
            else if (cfg.sys_freq) |sys_freq|
                sys_freq
            else
                @compileError("SYS clock frequency must be known for configuration of other clocks, either passed in via sys or sys_freq members");

            // switch sys and ref cleanly away from aux sources if that's the desired source
            if (cfg.sys) |sys_cfg| {
                if (sys_cfg.input.source.is_aux_src_for(Generator.sys)) {
                    Generator.sys.clear_source();
                    while (!Generator.sys.selected()) {}
                }
            }

            if (cfg.ref) |ref_cfg| {
                if (ref_cfg.input.source.is_aux_src_for(Generator.ref)) {
                    Generator.ref.clear_source();
                    while (!Generator.ref.selected()) {}
                }
            }

            // initialize PLLs
            if (cfg.pll_sys) |pll_sys_cfg| pll.PLL.apply(.sys, pll_sys_cfg);
            if (cfg.pll_usb) |pll_usb_cfg| pll.PLL.apply(.usb, pll_usb_cfg);

            //  initialize clock generators
            if (cfg.ref) |ref| Generator.ref.apply(ref, sys_freq);
            if (cfg.sys) |sys| Generator.sys.apply(sys, sys_freq);
            if (cfg.usb) |usb| Generator.usb.apply(usb, sys_freq);
            if (cfg.adc) |adc| Generator.adc.apply(adc, sys_freq);
            if (cfg.rtc) |rtc| Generator.rtc.apply(rtc, sys_freq);
            if (cfg.peri) |peri| Generator.peri.apply(peri, sys_freq);
            if (cfg.gpout0) |gpout0| Generator.gpout0.apply(gpout0, sys_freq);
            if (cfg.gpout1) |gpout1| Generator.gpout1.apply(gpout1, sys_freq);
            if (cfg.gpout2) |gpout2| Generator.gpout2.apply(gpout2, sys_freq);
            if (cfg.gpout3) |gpout3| Generator.gpout3.apply(gpout3, sys_freq);
        }
    };

    pub const preset = struct {
        /// The default Global clock config for the RP2040
        pub fn default() Global {
            return system(125_000_000, 12_000_000);
        }

        /// Creates a Global clock config for the given sys and ref frequency
        /// under the following conditions:
        /// - Assumes a 12MHZ crystal oscillator on XOSC
        /// - CLK_REF sourced from XOSC
        /// - CLK_SYS sourced from PLL_SYS @ 125 MHz
        ///     - TODO: Could vary the PLL frequency based on sys_freq input to open up a broader range of SYS frequencies
        /// - CLK_USB sourced from PLL_USB @ 48 MHz
        /// - CLK_ADC sourced from PLL_USB @ 48 MHz
        /// - CLK_RTC sourced from PLL_USB @ 48 MHz and divided down to ~65484 Hz
        /// - CLK_PERI sourced from CLK_SYS
        pub fn system(sys_freq: u32, ref_freq: u32) Global {
            var cfg: Global = .{};

            // CLK_REF is sourced from XOSC
            cfg.ref = .{
                .input = .{
                    .source = .src_xosc,
                    .freq = xosc_freq,
                },
                .integer_divisor = calculate_integer_divisor(xosc_freq, ref_freq, u24),
            };

            // Both PLL_SYS and PLL_USB are used, fixed configs for known frequencies
            const pll_sys_cfg_125_mhz: pll.Configuration = .{
                .refdiv = 1,
                .fbdiv = 125,
                .postdiv1 = 6,
                .postdiv2 = 2,
            };
            cfg.pll_sys = pll_sys_cfg_125_mhz;

            const pll_usb_cfg_48_mhz: pll.Configuration = .{
                .refdiv = 1,
                .fbdiv = 40,
                .postdiv1 = 5,
                .postdiv2 = 2,
            };
            cfg.pll_usb = pll_usb_cfg_48_mhz;

            // CLK_SYS is sourced from PLL_SYS
            cfg.sys = .{
                .input = .{
                    .source = .pll_sys,
                    .freq = 125_000_000,
                },
                .integer_divisor = calculate_integer_divisor(125_000_000, sys_freq, u24),
            };

            // USB peripheral is hooked up to PLL_USB
            cfg.usb = .{
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                },
                .integer_divisor = 1,
            };

            // ADC requires a 48MHz clock, so also gets hooked up to
            // the PLL_USB
            cfg.adc = .{
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                },
                .integer_divisor = 1,
            };

            // RTC gets connected to PLL_USB, and divided down to ~65484 Hz in order
            // to be a suitable clock for 1 second reference.
            cfg.rtc =
                .{
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                },
                .integer_divisor = 733,
            };

            // CLK_PERI is sourced from CLK_SYS, divisor hard coded to 1 on RP2040
            cfg.peri = .{
                .input = .{
                    .source = .clk_sys,
                    .freq = cfg.get_frequency(.clk_sys).?,
                },
                .integer_divisor = 1,
            };

            return cfg;
        }

        pub const GpioOutputConfig = struct {
            source: Source,
            integer_divisor: u24 = 1,
        };

        pub const GpioOutputs = struct {
            gpout0: ?GpioOutputConfig = null,
            gpout1: ?GpioOutputConfig = null,
            gpout2: ?GpioOutputConfig = null,
            gpout3: ?GpioOutputConfig = null,
        };

        /// Returns a configuration for routing an active clock to GPIO(s)
        ///
        /// Requires the current config to ensure clock source is configured and of known frequency
        pub fn output_to_gpio(gpio_outputs: GpioOutputs, comptime current_config: Global) Global {
            var cfg: Global = .{
                // Grab the SYS frequency without re-applying any configs to SYS
                .sys_freq = current_config.sys.?.frequency(),
            };

            if (gpio_outputs.gpout0) |gpout0| {
                cfg.gpout0 = .{
                    .input = .{
                        .source = gpout0.source,
                        .freq = current_config.get_frequency(gpout0.source).?,
                    },
                    .integer_divisor = gpout0.integer_divisor,
                };
            }

            if (gpio_outputs.gpout1) |gpout1| {
                cfg.gpout1 = .{
                    .input = .{
                        .source = gpout1.source,
                        .freq = current_config.get_frequency(gpout1.source).?,
                    },
                    .integer_divisor = gpout1.integer_divisor,
                };
            }

            if (gpio_outputs.gpout2) |gpout2| {
                cfg.gpout2 = .{
                    .input = .{
                        .source = gpout2.source,
                        .freq = current_config.get_frequency(gpout2.source).?,
                    },
                    .integer_divisor = gpout2.integer_divisor,
                };
            }

            if (gpio_outputs.gpout3) |gpout3| {
                cfg.gpout3 = .{
                    .input = .{
                        .source = gpout3.source,
                        .freq = current_config.get_frequency(gpout3.source).?,
                    },
                    .integer_divisor = gpout3.integer_divisor,
                };
            }

            return cfg;
        }
    };
};

/// Configured the watchdog tick counter period in microseconds per
/// whatever frequency the REF clock has been configured to.
pub fn start_ticks(comptime tick_period_us: u32, comptime clk_ref_freq: u32) void {
    comptime if ((clk_ref_freq < 1_000_000) or
        (clk_ref_freq % 1_000_000 != 0))
        @compileError("CLK_REF must be an integer multiple of 1 MHz in order to support tick periods in microseconds");

    const cycle_count = comptime @as(u9, @intCast((clk_ref_freq / 1_000_000) * tick_period_us));
    WATCHDOG.TICK.modify(.{
        .CYCLES = cycle_count,
        .ENABLE = 1,
    });
}
