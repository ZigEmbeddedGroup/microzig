const std = @import("std");
const microzig = @import("microzig");
const pll = @import("pll.zig");
const util = @import("util.zig");
const assert = std.debug.assert;

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

pub const Generator = enum {
    gpout0,
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
    const GeneratorRegs = packed struct {
        ctrl: u32,
        div: u32,
        selected: u32,
    };

    comptime {
        assert(12 == @sizeOf(GeneratorRegs));
        assert(24 == @sizeOf([2]GeneratorRegs));
    }

    const generators = @intToPtr(
        *volatile [9]GeneratorRegs,
        regs.CLOCKS.base_address,
    );

    pub fn hasGlitchlessMux(generator: Generator) bool {
        return switch (generator) {
            .sys, .ref => true,
            else => false,
        };
    }

    pub fn enable(generator: Generator) void {
        switch (generator) {
            .ref, .sys => {},
            else => generators[@enumToInt(generator)].ctrl |= (1 << 11),
        }
    }

    pub fn setDiv(generator: Generator, div: u32) void {
        if (generator == .peri)
            return;

        generators[@enumToInt(generator)].div = div;
    }

    pub fn getDiv(generator: Generator) u32 {
        if (generator == .peri)
            return 1;

        return generators[@enumToInt(generator)].div;
    }

    // The bitfields for the *_SELECTED registers are actually a mask of which
    // source is selected. While switching sources it may read as 0, and that's
    // what this function is indended for: checking if the new source has
    // switched over yet.
    //
    // Some mention that this is only for the glitchless mux, so if it is non-glitchless then return true
    pub fn selected(generator: Generator) bool {
        return (0 != generators[@enumToInt(generator)].selected);
    }

    pub fn clearSource(generator: Generator) void {
        generators[@enumToInt(generator)].ctrl &= ~@as(u32, 0x3);
    }

    pub fn disable(generator: Generator) void {
        switch (generator) {
            .sys, .ref => {},
            else => generators[@enumToInt(generator)].ctrl &= ~@as(u32, 1 << 11),
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
        const mask = ~@as(u32, 0x3);
        const ctrl_value = generators[@enumToInt(generator)].ctrl;
        generators[@enumToInt(generator)].ctrl = (ctrl_value & mask) | src;
    }

    pub fn setAuxSource(generator: Generator, auxsrc: u32) void {
        const mask = ~@as(u32, 0x1e0);
        const ctrl_value = generators[@enumToInt(generator)].ctrl;
        generators[@enumToInt(generator)].ctrl = (ctrl_value & mask) | (auxsrc << 5);
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
    xosc_configured: bool,
    sys: ?Configuration,
    ref: ?Configuration,
    usb: ?Configuration,
    adc: ?Configuration,
    rtc: ?Configuration,
    peri: ?Configuration,

    pll_sys: ?pll.Configuration,
    pll_usb: ?pll.Configuration,

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
        // TODO: allow user to configure PLLs to optimize for low-jitter, low-power, or manually specify
    };

    /// this function reasons about how to configure the clock system. It will
    /// assert if the configuration is invalid
    pub fn init(comptime opts: Options) GlobalConfiguration {
        var xosc_configured = false;
        var pll_sys: ?pll.Configuration = null;
        var pll_usb: ?pll.Configuration = null;

        return GlobalConfiguration{
            // the system clock can either use rosc, xosc, or the sys PLL
            .sys = if (opts.sys) |sys_opts| sys_config: {
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
                            xosc_configured = true;
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
                            xosc_configured = true;
                            output_freq = sys_opts.freq orelse 125_000_000;
                            assert(output_freq.? <= 125_000_000);

                            // TODO: proper values for 125MHz
                            pll_sys = .{
                                .refdiv = 2,
                                .vco_freq = 1_440_000_000,
                                .postdiv1 = 6,
                                .postdiv2 = 5,
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
            } else null,

            // to keep things simple for now, we'll make it so that the usb
            // generator can only be hooked up to the usb PLL, and only have
            // one configuration for the usb PLL
            .usb = if (opts.usb) |usb_opts| usb_config: {
                assert(pll_usb == null);
                assert(usb_opts.source == .pll_usb);

                xosc_configured = true;
                pll_usb = .{
                    .refdiv = 1,
                    .vco_freq = 1_440_000_000,
                    .postdiv1 = 6,
                    .postdiv2 = 5,
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
            } else null,

            // I THINK that if either pll is configured here, then that means
            // that the ref clock generator MUST use xosc to feed the PLLs?
            .ref = if (opts.ref) |_|
                unreachable // don't explicitly configure for now
            else if (pll_sys != null or pll_usb != null) ref_config: {
                xosc_configured = true;
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
            } else null,

            // for the rest of the generators we'll make it so that they can
            // either use the ROSC, XOSC, or sys PLL, with whatever dividing
            // they need

            // adc requires a 48MHz clock, so only ever let it get hooked up to
            // the usb PLL
            .adc = if (opts.adc) |adc_opts| adc_config: {
                assert(adc_opts.source == .pll_usb);
                xosc_configured = true;

                // TODO: some safety checks for overwriting this
                pll_usb = .{
                    .refdiv = 1,
                    .vco_freq = 1_440_000_000,
                    .postdiv1 = 6,
                    .postdiv2 = 5,
                };

                break :adc_config .{
                    .generator = .usb,
                    .input = .{
                        .source = .pll_usb,
                        .freq = 48_000_000,
                        .src_value = srcValue(.adc, .pll_usb),
                        .auxsrc_value = auxSrcValue(.adc, .pll_usb),
                    },
                    .output_freq = 48_000_000,
                };
            } else null,

            .rtc = if (opts.rtc) |_|
                unreachable // TODO
            else
                null,

            .peri = if (opts.peri) |peri_opts| peri_config: {
                if (peri_opts.source == .src_xosc)
                    xosc_configured = true;

                break :peri_config .{
                    .generator = .peri,
                    .input = .{
                        .source = peri_opts.source,
                        .freq = xosc_freq,
                        .src_value = srcValue(.peri, peri_opts.source),
                        .auxsrc_value = auxSrcValue(.peri, peri_opts.source),
                    },
                    .output_freq = xosc_freq,
                };
            } else null,

            .xosc_configured = xosc_configured,
            .pll_sys = pll_sys,
            .pll_usb = pll_usb,
        };
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
                while (regs.CLOCKS.CLK_SYS_SELECTED.* == 0) {}
            },
            else => {},
        };

        if (config.ref) |ref| switch (ref.input.source) {
            .pll_usb, .pll_sys => {
                regs.CLOCKS.CLK_REF_CTRL.modify(.{ .SRC = 0 });
                while (regs.CLOCKS.CLK_REF_SELECTED.* == 0) {}
            },
            else => {},
        };

        //// initialize PLLs
        if (config.pll_sys) |pll_sys_config| pll.PLL.apply(.sys, pll_sys_config);
        if (config.pll_usb) |pll_usb_config| pll.PLL.apply(.usb, pll_usb_config);

        //// initialize clock generators
        if (config.ref) |ref| ref.apply(config.sys);
        if (config.usb) |usb| usb.apply(config.sys);
        if (config.adc) |adc| adc.apply(config.sys);
        if (config.rtc) |rtc| rtc.apply(config.sys);
        if (config.peri) |peri| peri.apply(config.sys);
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

        const div = @intCast(u32, (@intCast(u64, input.freq) << 8) / 8);

        // check divisor
        if (div > generator.getDiv())
            generator.setDiv(div);

        // TODO what _is_ an aux source?
        if (generator.hasGlitchlessMux() and input.src_value == 1) {
            generator.clearSource();
            while (!generator.selected()) {}
        } else {
            generator.disable();
            var delay_cycles = sys_config.output_freq / config.output_freq + 1;
            asm volatile (
                \\1:
                \\subs %[cycles], #1
                \\bne 1b
                : [cycles] "=r" (delay_cycles),
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

pub fn countFrequencyKhz(source: Source, comptime clock_config: GlobalConfiguration) u32 {
    const ref_freq = clock_config.ref.?.output_freq;

    // wait for counter to be done
    while (CLOCKS.FC0_STATUS.read().RUNNING == 1) {}

    CLOCKS.FC0_REF_KHZ.* = ref_freq / 1000;
    CLOCKS.FC0_INTERVAL.* = 10;
    CLOCKS.FC0_MIN_KHZ.* = 0;
    CLOCKS.FC0_MAX_KHZ.* = std.math.maxInt(u32);
    CLOCKS.FC0_SRC.* = @enumToInt(source);

    while (CLOCKS.FC0_STATUS.read().DONE != 1) {}

    return CLOCKS.FC0_RESULT.read().KHZ;
}
