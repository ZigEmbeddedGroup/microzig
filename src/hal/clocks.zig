const std = @import("std");
const microzig = @import("microzig");
const pll = @import("pll.zig");
const util = @import("util.zig");
const assert = std.debug.assert;

// TODO: remove
const gpio = @import("gpio.zig");

const regs = microzig.chip.registers;
const CLOCKS = regs.CLOCKS;
const xosc_freq = microzig.board.xosc_freq;
/// this is only nominal, very imprecise and prone to drift over time
const rosc_freq = 6_500_000;

comptime {
    assert(xosc_freq <= 15_000_000 and xosc_freq >= 1_000_000); // xosc limits
}

pub const xosc = struct {
    const startup_delay_ms = 1;
    const startup_delay_value = xosc_freq * startup_delay_ms / 1000 / 256;

    pub fn init() void {
        regs.XOSC.STARTUP.modify(.{ .DELAY = startup_delay_value });
        regs.XOSC.CTRL.modify(.{ .ENABLE = 4011 });

        // wait for xosc startup to complete:
        while (regs.XOSC.STATUS.read().STABLE == 0) {}
    }

    pub fn waitCycles(value: u8) void {
        assert(is_enabled: {
            const status = regs.XOSC.STATUS.read();
            break :is_enabled status.STABLE != 0 and status.ENABLED != 0;
        });

        regs.XOSC.COUNT.modify(value);
        while (regs.XOSC.COUNT.read() != 0) {}
    }
};

fn formatUppercase(
    bytes: []const u8,
    comptime fmt: []const u8,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = fmt;
    _ = options;
    for (bytes) |c|
        try writer.writeByte(std.ascii.toUpper(c));
}

fn uppercase(bytes: []const u8) std.fmt.Formatter(formatUppercase) {
    return .{ .data = bytes };
}

pub const Generator = enum(u32) {
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

    // in some cases we can pretend the Generators are a homogenous array of
    // register clusters for the sake of smaller codegen
    const GeneratorRegs = extern struct {
        ctrl: u32,
        div: u32,
        selected: u32,
    };

    comptime {
        assert(12 == @sizeOf(GeneratorRegs));
        assert(24 == @sizeOf([2]GeneratorRegs));
    }

    const generators = @intToPtr(
        *volatile [@typeInfo(Generator).Enum.fields.len]GeneratorRegs,
        regs.CLOCKS.base_address,
    );

    fn getRegs(generator: Generator) *volatile GeneratorRegs {
        return &generators[@enumToInt(generator)];
    }

    pub fn hasGlitchlessMux(generator: Generator) bool {
        return switch (generator) {
            .sys, .ref => true,
            else => false,
        };
    }

    pub fn enable(generator: Generator) void {
        switch (generator) {
            .ref, .sys => {},
            else => generator.getRegs().ctrl |= (1 << 11),
        }
    }

    pub fn setDiv(generator: Generator, div: u32) void {
        if (generator == .peri)
            return;

        generator.getRegs().div = div;
    }

    pub fn getDiv(generator: Generator) u32 {
        if (generator == .peri)
            return 1;

        return generator.getRegs().div;
    }

    // The bitfields for the *_SELECTED registers are actually a mask of which
    // source is selected. While switching sources it may read as 0, and that's
    // what this function is indended for: checking if the new source has
    // switched over yet.
    //
    // Some mention that this is only for the glitchless mux, so if it is non-glitchless then return true
    pub fn selected(generator: Generator) bool {
        return (0 != generator.getRegs().selected);
    }

    pub fn clearSource(generator: Generator) void {
        generator.getRegs().ctrl &= ~@as(u32, 0x3);
    }

    pub fn disable(generator: Generator) void {
        switch (generator) {
            .sys, .ref => {},
            else => generator.getRegs().ctrl &= ~@as(u32, 1 << 11),
        }
    }

    pub fn isAuxSource(generator: Generator, source: Source) bool {
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

    pub fn setSource(generator: Generator, src: u32) void {
        std.debug.assert(generator.hasGlitchlessMux());
        const gen_regs = generator.getRegs();
        const mask = ~@as(u32, 0x3);
        const ctrl_value = gen_regs.ctrl;
        gen_regs.ctrl = (ctrl_value & mask) | src;
    }

    pub fn setAuxSource(generator: Generator, auxsrc: u32) void {
        const gen_regs = generator.getRegs();
        const mask = ~@as(u32, 0x1e0);
        const ctrl_value = gen_regs.ctrl;
        gen_regs.ctrl = (ctrl_value & mask) | (auxsrc << 5);
    }
};

pub const Source = enum {
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
};

fn srcValue(generator: Generator, source: Source) u32 {
    return switch (generator) {
        .sys => src: {
            const ret: u32 = switch (source) {
                .clk_ref => 0,
                else => 1,
            };
            break :src ret;
        },
        .ref => src: {
            const ret: u32 = switch (source) {
                .src_rosc => 0,
                .src_xosc => 2,
                else => 1,
            };
            break :src ret;
        },
        else => 0,
    };
}

fn auxSrcValue(generator: Generator, source: Source) u32 {
    return switch (generator) {
        .sys => auxsrc: {
            const ret: u32 = switch (source) {
                .pll_sys => 0,
                .pll_usb => 1,
                .src_rosc => 2,
                .src_xosc => 3,
                .src_gpin0 => 4,
                .src_gpin1 => 5,
                else => @panic("invalid source for generator"),
            };
            break :auxsrc ret;
        },
        .ref => auxsrc: {
            const ret: u32 = switch (source) {
                // zero'd out because it is a src option
                .src_xosc => 0,
                .pll_sys => 0,
                .src_gpin0 => 1,
                .src_gpin1 => 2,
                else => @panic("invalid source for generator"),
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
                else => @panic("invalid source for generator"),
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
                else => @panic("invalid source for generator"),
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

pub const GlobalConfiguration = struct {
    xosc_configured: bool = false,
    sys: ?Configuration = null,
    ref: ?Configuration = null,
    usb: ?Configuration = null,
    adc: ?Configuration = null,
    rtc: ?Configuration = null,
    peri: ?Configuration = null,
    gpout0: ?Configuration = null,
    gpout1: ?Configuration = null,
    gpout2: ?Configuration = null,
    gpout3: ?Configuration = null,

    pll_sys: ?pll.Configuration = null,
    pll_usb: ?pll.Configuration = null,

    pub const Option = struct {
        source: Source,
        freq: ?u32 = null,
    };

    pub const Options = struct {
        sys: ?Option = null,
        ref: ?Option = null,
        usb: ?Option = null,
        adc: ?Option = null,
        rtc: ?Option = null,
        peri: ?Option = null,
        gpout0: ?Option = null,
        gpout1: ?Option = null,
        gpout2: ?Option = null,
        gpout3: ?Option = null,
        // TODO: allow user to configure PLLs to optimize for low-jitter, low-power, or manually specify
    };

    pub fn getFrequency(config: GlobalConfiguration, source: Source) ?u32 {
        return switch (source) {
            .src_xosc => xosc_freq,
            .src_rosc => rosc_freq,
            .clk_sys => if (config.sys) |sys_config| sys_config.output_freq else null,
            .clk_usb => if (config.usb) |usb_config| usb_config.output_freq else null,
            .clk_ref => if (config.ref) |ref_config| ref_config.output_freq else null,
            .clk_adc => if (config.adc) |adc_config| adc_config.output_freq else null,
            .clk_rtc => if (config.rtc) |rtc_config| rtc_config.output_freq else null,
            .pll_sys => if (config.pll_sys) |pll_sys_config| pll_sys_config.frequency() else null,
            .pll_usb => if (config.pll_usb) |pll_usb_config| pll_usb_config.frequency() else null,

            .src_gpin0, .src_gpin1 => null,
        };
    }

    /// this function reasons about how to configure the clock system. It will
    /// assert if the configuration is invalid
    pub fn init(comptime opts: Options) GlobalConfiguration {
        var config = GlobalConfiguration{};

        // I THINK that if either pll is configured here, then that means
        // that the ref clock generator MUST use xosc to feed the PLLs?
        config.ref = if (opts.ref) |ref_opts| ref_config: {
            assert(ref_opts.source == .src_xosc);
            break :ref_config .{
                .generator = .ref,
                .input = .{
                    .source = ref_opts.source,
                    .freq = config.getFrequency(ref_opts.source).?,
                    .src_value = srcValue(.ref, ref_opts.source),
                    .auxsrc_value = auxSrcValue(.ref, ref_opts.source),
                },
                .output_freq = config.getFrequency(ref_opts.source).?,
            };
        } else if (config.pll_sys != null or config.pll_usb != null) ref_config: {
            config.xosc_configured = true;
            break :ref_config .{
                .generator = .ref,
                .input = .{
                    .source = .src_xosc,
                    .freq = xosc_freq,
                    .src_value = srcValue(.ref, .src_xosc),
                    .auxsrc_value = auxSrcValue(.ref, .src_xosc),
                },
                .output_freq = xosc_freq,
            };
        } else null;

        // the system clock can either use rosc, xosc, or the sys PLL
        config.sys = if (opts.sys) |sys_opts| sys_config: {
            var output_freq: ?u32 = null;
            break :sys_config .{
                .generator = .sys,
                .input = switch (sys_opts.source) {
                    .src_rosc => input: {
                        output_freq = sys_opts.freq orelse rosc_freq;
                        assert(output_freq.? <= rosc_freq);
                        break :input .{
                            .source = .src_rosc,
                            .freq = rosc_freq,
                            .src_value = srcValue(.sys, .src_rosc),
                            .auxsrc_value = auxSrcValue(.sys, .src_rosc),
                        };
                    },
                    .src_xosc => input: {
                        config.xosc_configured = true;
                        output_freq = sys_opts.freq orelse xosc_freq;
                        assert(output_freq.? <= xosc_freq);
                        break :input .{
                            .source = .src_xosc,
                            .freq = xosc_freq,
                            .src_value = srcValue(.sys, .src_xosc),
                            .auxsrc_value = auxSrcValue(.sys, .src_xosc),
                        };
                    },
                    .pll_sys => input: {
                        config.xosc_configured = true;
                        output_freq = sys_opts.freq orelse 125_000_000;
                        assert(output_freq.? == 125_000_000); // if using pll use 125MHz for now

                        // TODO: proper values for 125MHz
                        config.pll_sys = .{
                            .refdiv = 1,
                            .fbdiv = 125,
                            .postdiv1 = 6,
                            .postdiv2 = 2,
                        };

                        break :input .{
                            .source = .pll_sys,
                            // TODO: not really sure what frequency to
                            // drive pll at yet, but this is an okay start
                            .freq = 125_000_000,
                            .src_value = srcValue(.sys, .pll_sys),
                            .auxsrc_value = auxSrcValue(.sys, .pll_sys),
                        };
                    },

                    else => unreachable, // not an available input
                },
                .output_freq = output_freq.?,
            };
        } else null;

        // to keep things simple for now, we'll make it so that the usb
        // generator can only be hooked up to the usb PLL, and only have
        // one configuration for the usb PLL
        config.usb = if (opts.usb) |usb_opts| usb_config: {
            assert(config.pll_usb == null);
            assert(usb_opts.source == .pll_usb);

            config.xosc_configured = true;
            config.pll_usb = .{
                .refdiv = 1,
                .fbdiv = 40,
                .postdiv1 = 5,
                .postdiv2 = 2,
            };

            break :usb_config .{
                .generator = .usb,
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                    .src_value = srcValue(.usb, .pll_usb),
                    .auxsrc_value = auxSrcValue(.usb, .pll_usb),
                },
                .output_freq = 48_000_000,
            };
        } else null;

        // for the rest of the generators we'll make it so that they can
        // either use the ROSC, XOSC, or sys PLL, with whatever dividing
        // they need

        // adc requires a 48MHz clock, so only ever let it get hooked up to
        // the usb PLL
        config.adc = if (opts.adc) |adc_opts| adc_config: {
            assert(adc_opts.source == .pll_usb);
            config.xosc_configured = true;

            // TODO: some safety checks for overwriting this
            if (config.pll_usb) |pll_usb| {
                assert(pll_usb.refdiv == 1);
                assert(pll_usb.fbdiv == 40);
                assert(pll_usb.postdiv1 == 5);
                assert(pll_usb.postdiv2 == 2);
            } else {
                config.pll_usb = .{
                    .refdiv = 1,
                    .fbdiv = 40,
                    .postdiv1 = 5,
                    .postdiv2 = 2,
                };
            }

            break :adc_config .{
                .generator = .adc,
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                    .src_value = srcValue(.adc, .pll_usb),
                    .auxsrc_value = auxSrcValue(.adc, .pll_usb),
                },
                .output_freq = 48_000_000,
            };
        } else null;

        config.rtc = if (opts.rtc) |rtc_opts| rtc_config: {
            assert(rtc_opts.source == .pll_usb);
            config.xosc_configured = true;

            // TODO: some safety checks for overwriting this
            if (config.pll_usb) |pll_usb| {
                assert(pll_usb.refdiv == 1);
                assert(pll_usb.fbdiv == 40);
                assert(pll_usb.postdiv1 == 5);
                assert(pll_usb.postdiv2 == 2);
            } else {
                config.pll_usb = .{
                    .refdiv = 1,
                    .fbdiv = 40,
                    .postdiv1 = 5,
                    .postdiv2 = 2,
                };
            }

            break :rtc_config .{
                .generator = .rtc,
                .input = .{
                    .source = .pll_usb,
                    .freq = 48_000_000,
                    .src_value = srcValue(.rtc, .pll_usb),
                    .auxsrc_value = auxSrcValue(.rtc, .pll_usb),
                },
                .output_freq = 48_000_000,
            };
        } else null;

        config.peri = if (opts.peri) |peri_opts| peri_config: {
            if (peri_opts.source == .src_xosc)
                config.xosc_configured = true;

            break :peri_config .{
                .generator = .peri,
                .input = .{
                    .source = peri_opts.source,
                    .freq = config.getFrequency(peri_opts.source) orelse
                        @compileError("you need to configure the source: " ++ @tagName(peri_opts.source)),
                    .src_value = srcValue(.peri, peri_opts.source),
                    .auxsrc_value = auxSrcValue(.peri, peri_opts.source),
                },
                .output_freq = if (peri_opts.freq) |output_freq|
                    output_freq
                else
                    config.getFrequency(peri_opts.source).?,
            };
        } else null;

        config.gpout0 = if (opts.gpout0) |gpout0_opts| .{
            .generator = .gpout0,
            .input = .{
                .source = gpout0_opts.source,
                .freq = config.getFrequency(gpout0_opts.source) orelse
                    @compileError("you need to configure the source: " ++ @tagName(gpout0_opts.source)),
                .src_value = srcValue(.gpout0, gpout0_opts.source),
                .auxsrc_value = auxSrcValue(.gpout0, gpout0_opts.source),
            },
            .output_freq = if (gpout0_opts.freq) |output_freq|
                output_freq
            else
                config.getFrequency(gpout0_opts.source).?,
        } else null;

        return config;
    }

    /// this is explicitly comptime to encourage the user to have separate
    /// clock configuration declarations instead of mutating them at runtime
    pub fn apply(comptime config: GlobalConfiguration) void {

        // disable resus if it has been turned on elsewhere
        regs.CLOCKS.CLK_SYS_RESUS_CTRL.raw = 0;

        if (config.xosc_configured) {
            regs.WATCHDOG.TICK.modify(.{
                .CYCLES = xosc_freq / 1_000_000,
                .ENABLE = 1,
            });
            xosc.init();
        }

        // switch sys and ref cleanly away from aux sources if they're
        // configured to use/be used from PLLs
        if (config.sys) |sys| switch (sys.input.source) {
            .pll_usb, .pll_sys => {
                regs.CLOCKS.CLK_SYS_CTRL.modify(.{ .SRC = 0 });
                while (!Generator.sys.selected()) {}
            },
            else => {},
        };

        if (config.ref) |ref| switch (ref.input.source) {
            .pll_usb, .pll_sys => {
                regs.CLOCKS.CLK_REF_CTRL.modify(.{ .SRC = 0 });
                while (!Generator.ref.selected()) {}
            },
            else => {},
        };

        //// initialize PLLs
        if (config.pll_sys) |pll_sys_config| pll.PLL.apply(.sys, pll_sys_config);
        if (config.pll_usb) |pll_usb_config| pll.PLL.apply(.usb, pll_usb_config);

        //// initialize clock generators
        if (config.ref) |ref| ref.apply(config.sys);
        if (config.sys) |sys| sys.apply(config.sys);
        if (config.usb) |usb| usb.apply(config.sys);
        if (config.adc) |adc| adc.apply(config.sys);
        if (config.rtc) |rtc| rtc.apply(config.sys);
        if (config.peri) |peri| peri.apply(config.sys);

        if (config.gpout0) |gpout0| gpout0.apply(config.sys);
        if (config.gpout1) |gpout1| gpout1.apply(config.sys);
        if (config.gpout2) |gpout2| gpout2.apply(config.sys);
        if (config.gpout3) |gpout3| gpout3.apply(config.sys);
    }
};

pub const Configuration = struct {
    generator: Generator,
    input: struct {
        source: Source,
        src_value: u32,
        auxsrc_value: u32,
        freq: u32,
    },
    output_freq: u32,

    pub fn apply(comptime config: Configuration, comptime sys_config_opt: ?Configuration) void {
        const generator = config.generator;
        const input = config.input;
        const output_freq = config.output_freq;

        const sys_config = sys_config_opt.?; // sys clock config needs to be set!

        // source frequency has to be faster because dividing will always reduce.
        assert(input.freq >= output_freq);

        const div = @intCast(u32, (@intCast(u64, input.freq) << 8) / output_freq);

        // check divisor
        if (div > generator.getDiv())
            generator.setDiv(div);

        if (generator.hasGlitchlessMux() and input.src_value == 1) {
            generator.clearSource();

            while (!generator.selected()) {}
        } else {
            generator.disable();
            const delay_cycles: u32 = sys_config.output_freq / config.output_freq + 1;
            asm volatile (
                \\.syntax unified
                \\movs r1, %[cycles]
                \\1:
                \\subs r1, #1
                \\bne 1b
                :
                : [cycles] "i" (delay_cycles),
                : "{r1}"
            );
        }

        generator.setAuxSource(input.auxsrc_value);

        // set aux mux first and then glitchless mex if this clock has one
        if (generator.hasGlitchlessMux()) {
            generator.setSource(input.src_value);
            while (!generator.selected()) {}
        }

        generator.enable();
        generator.setDiv(div);
    }
};

// NOTE: untested
pub fn countFrequencyKhz(source: Source, comptime clock_config: GlobalConfiguration) u32 {
    const ref_freq = clock_config.ref.?.output_freq;

    // wait for counter to be done
    while (CLOCKS.FC0_STATUS.read().RUNNING == 1) {}

    CLOCKS.FC0_REF_KHZ.raw = ref_freq / 1000;
    CLOCKS.FC0_INTERVAL.raw = 10;
    CLOCKS.FC0_MIN_KHZ.raw = 0;
    CLOCKS.FC0_MAX_KHZ.raw = std.math.maxInt(u32);
    CLOCKS.FC0_SRC.raw = @enumToInt(source);

    while (CLOCKS.FC0_STATUS.read().DONE != 1) {}

    return CLOCKS.FC0_RESULT.read().KHZ;
}
