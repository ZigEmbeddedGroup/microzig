const std = @import("std");
const microzig = @import("microzig");
const pll = @import("pll.zig");
const assert = std.debug.assert;

const regs = microzig.chip.registers;
const xosc_freq = microzig.board.xosc_freq;
// TODO: move to board file
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

    // source directly from register definitions
    const Source = enum {
        rosc_clksrc_ph,
        clksrc_clk_ref_aux,
        xosc_clksrc,
        clk_ref,
        clksrc_clk_sys_aux,
    };

    // aux sources directly from register definitions
    const AuxilarySource = enum {
        clksrc_pll_sys,
        clksrc_gpin0,
        clksrc_gpin1,
        clksrc_pll_usb,
        rosc_clksrc,
        xosc_clksrc,
        clk_sys,
        clk_usb,
        clk_adc,
        clk_rtc,
        clk_ref,
        rosc_clksrc_ph,
    };

    const source_map = struct {
        const ref = [_]Generator.Source{ .rosc_clksrc_ph, .clksrc_clk_ref, .xosc_clksrc };
        const sys = [_]Generator.Source{ .clk_ref, .clksrc_clk_sys_aux };
    };

    const aux_map = struct {};

    pub fn hasGlitchlessMux(generator: Generator) bool {
        return switch (generator) {
            .sys, .ref => true,
            else => false,
        };
    }

    pub fn enable(generator: Generator) void {
        inline for (std.meta.fields(Generator)) |field| {
            if (generator == @field(Generator, field.name)) {
                const reg_name = comptime std.fmt.comptimePrint("CLK_{s}_CTRL", .{
                    uppercase(field.name),
                });

                if (@hasField(@TypeOf(@field(regs.CLOCKS, reg_name).*).underlying_type, "ENABLE"))
                    @field(regs.CLOCKS, reg_name).modify(.{ .ENABLE = 1 });
            }
        }
    }

    pub fn setDiv(generator: Generator, div: u32) void {
        inline for (std.meta.fields(Generator)) |field| {
            if (generator == @field(Generator, field.name)) {
                const reg_name = comptime std.fmt.comptimePrint("CLK_{s}_DIV", .{
                    uppercase(field.name),
                });

                if (@hasDecl(regs.CLOCKS, reg_name))
                    @field(regs.CLOCKS, reg_name).raw = div
                else
                    assert(false); // doesn't have a divider
            }
        }
    }

    pub fn getDiv(generator: Generator) u32 {
        return inline for (std.meta.fields(Generator)) |field| {
            if (generator == @field(Generator, field.name)) {
                const reg_name = comptime std.fmt.comptimePrint("CLK_{s}_DIV", .{
                    uppercase(field.name),
                });

                break if (@hasDecl(regs.CLOCKS, reg_name))
                    @field(regs.CLOCKS, reg_name).raw
                else
                    1;
            }
        } else unreachable;
    }

    // The bitfields for the *_SELECTED registers are actually a mask of which
    // source is selected. While switching sources it may read as 0, and that's
    // what this function is indended for: checking if the new source has
    // switched over yet.
    //
    // Some mention that this is only for the glitchless mux, so if it is non-glitchless then return true
    pub fn selected(generator: Generator) bool {
        inline for (std.meta.fields(Generator)) |field| {
            if (generator == @field(Generator, field.name)) {
                return if (@field(Generator, field.name).hasGlitchlessMux()) ret: {
                    const reg_name = comptime std.fmt.comptimePrint("CLK_{s}_SELECTED", .{
                        uppercase(field.name),
                    });

                    break :ret @field(regs.CLOCKS, reg_name).* != 0;
                } else true;
            }
        } else unreachable;
    }
};

pub const Source = enum {
    src_rosc,
    src_xosc,
    src_aux,
    pll_sys,
    pll_usb,
    clk_sys,
};

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
                                .source = .rosc,
                                .freq = rosc_freq,
                            };
                        },
                        .src_xosc => input: {
                            xosc_configured = true;
                            output_freq = sys_opts.freq orelse xosc_freq;
                            assert(output_freq.? <= xosc_freq);
                            break :input .{
                                .source = .xosc,
                                .freq = xosc_freq,
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
                    },
                    .output_freq = xosc_freq,
                };
            } else null,

            // for the rest of the generators we'll make it so that they can
            // either use the ROSC, XOSC, or sys PLL, with whatever dividing
            // they need

            .adc = if (opts.adc) |_|
                unreachable // TODO
            else
                null,

            .rtc = if (opts.rtc) |_|
                unreachable // TODO
            else
                null,

            .peri = if (opts.peri) |peri_opts| peri_config: {
                if (peri_opts.source == .src_xosc)
                    xosc_configured = true;

                // TODO
                break :peri_config .{
                    .generator = .peri,
                    .input = .{
                        .source = peri_opts.source,
                        .freq = xosc_freq,
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
    pub fn apply(comptime config: GlobalConfiguration) !void {

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
                while (regs.CLOCKS.CLK_SYS_SELECTED.* != 1) {}
            },
            else => {},
        };

        if (config.ref) |ref| switch (ref.input.source) {
            .pll_usb, .pll_sys => {
                regs.CLOCKS.CLK_REF_CTRL.modify(.{ .SRC = 0 });
                while (regs.CLOCKS.CLK_REF_SELECTED.* != 1) {}
            },
            else => {},
        };

        // initialize PLLs
        if (config.pll_sys) |pll_sys_config| pll.sys.apply(pll_sys_config);
        if (config.pll_usb) |pll_usb_config| pll.usb.apply(pll_usb_config);

        // initialize clock generators
        if (config.ref) |ref| try ref.apply();
        if (config.usb) |usb| try usb.apply();
        if (config.adc) |adc| try adc.apply();
        if (config.rtc) |rtc| try rtc.apply();
        if (config.peri) |peri| try peri.apply();
    }

    /// returns frequency of a clock or pll, if unconfigured it returns null
    pub fn getFrequency(config: GlobalConfiguration) ?u32 {
        _ = config;
        return null;
    }
};

pub const Configuration = struct {
    generator: Generator,
    input: struct {
        source: Source,
        freq: u32,
    },
    output_freq: u32,

    pub fn apply(config: Configuration) !void {
        const generator = config.generator;
        const input = config.input;
        const output_freq = config.output_freq;

        // source frequency has to be faster because dividing will always reduce.
        assert(input.freq >= output_freq);
        if (output_freq < input.freq)
            return error.InvalidArgs;

        const div = @intCast(u32, (@intCast(u64, input.freq) << 8) / 8);

        // check divisor
        if (div > generator.getDiv())
            generator.setDiv(div);

        if (generator.hasGlitchlessMux() and input.source == .src_aux) {
            // TODO: clear bits
            while (!generator.selected()) {
                // TODO: is leaving this empty good enough? pico sdk has `tight_loop_contents()`
            }
        } else {
            // uh stuff
        }

        // set aux mux first and then glitchless mex if this clock has one
        if (generator.hasGlitchlessMux()) {
            // write to clock ctrl
            while (!generator.selected()) {}
        }

        generator.enable();
        generator.setDiv(div);
        // should we store global state on configured clocks?
    }
};

//pub fn countFrequencyKhz(source: Source) u32 {}

