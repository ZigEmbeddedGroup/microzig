pub const std = @import("std");
pub const chip = @import("rp2040.zig"); // TODO: ???
pub const registers = @import("registers.zig");
pub const root = @import("root");

pub const xosc = @import("xosc.zig");
pub const pll = @import("pll.zig");

// TODO: clock configuration needs to be rewritten to handle depenencies between clocks,
// right now the order of clock configuration is hardcoded to:
// 1. xosc
// 2. pll sys
// 3. pll usb
// 4. clk ref
// 5  clk usb
// 6. clk adc
// 7. clk rtc
// 8. clk sys
// 9. clk peri

pub const default_clocks: struct {
    xosc: struct { frequency: u32 = 12_000_000 } = .{},
    pll: struct {
        sys: struct { frequency: u32 = 125_000_000 } = .{},
        usb: struct { frequency: u32 = 48_000_000 } = .{},
    } = .{},
    clocks: struct {
        ref: struct { src: PrecalcatedClocks.CLOCK_SRC = .XOSC, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .PLL_SYS, frequency: u32 = 12_000_000 } = .{},
        sys: struct { src: PrecalcatedClocks.CLOCK_SRC = .AUX, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .PLL_SYS, frequency: u32 = 125_000_000 } = .{},
        usb: struct { src: PrecalcatedClocks.CLOCK_SRC = .AUX, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .PLL_USB, frequency: u32 = 48_000_000 } = .{},
        adc: struct { src: PrecalcatedClocks.CLOCK_SRC = .AUX, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .PLL_USB, frequency: u32 = 48_000_000 } = .{},
        rtc: struct { src: PrecalcatedClocks.CLOCK_SRC = .AUX, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .PLL_USB, frequency: u32 = 46875 } = .{},
        peri: struct { src: PrecalcatedClocks.CLOCK_SRC = .AUX, auxsrc: PrecalcatedClocks.CLOCK_AUXSRC = .CLK_SYS } = .{}, // peripherial clock doesn't support dividers, so we cant set the frequency
    } = .{},
} = if (@hasDecl(root, "clocks_config")) root.clocks_config else .{};

pub fn init() void {
    apply(current_clocks_config);
}

// TODO: implement runtime configurable clocks and make this public
fn apply(comptime clocks: anytype) void {
    // TODO: enable watchdog

    // disable resus which might be enabled
    registers.CLOCKS.CLK_SYS_RESUS_CTRL.raw = 0;

    // enable xosc
    xosc.init(clocks);

    // switch the sys and ref clocks to know state
    registers.CLOCKS.CLK_SYS_CTRL.modify(.{ .SRC = .clk_ref });
    while (registers.CLOCKS.CLK_SYS_SELECTED.raw != 0x1)
        asm volatile ("" ::: "memory");

    registers.CLOCKS.CLK_REF_CTRL.modify(.{ .SRC = .rosc_clksrc_ph });
    while (registers.CLOCKS.CLK_REF_SELECTED.raw != 0x1)
        asm volatile ("" ::: "memory");

    // TODO: get the dependencies right and use the reset function
    chip.reset(.{ .pll_sys, .pll_usb });

    pll.apply(registers.PLL_SYS, clocks.pll.sys);
    pll.apply(registers.PLL_USB, clocks.pll.usb);

    // TODO: handle clocks dependencies
    configureclock("REF", clocks.clocks.ref);
    configureclock("USB", clocks.clocks.usb);
    configureclock("ADC", clocks.clocks.adc);
    configureclock("RTC", clocks.clocks.rtc);
    configureclock("SYS", clocks.clocks.sys);
    configureclock("PERI", clocks.clocks.peri);
}

fn configureclock(comptime clock: anytype, comptime clock_config: anytype) void {
    const clk_ctrl = @field(registers.CLOCKS, "CLK_" ++ clock ++ "_CTRL");

    // SRC register is available only on clocks which supports glitchless way of swtiching clocks
    const has_clk_ctrl_src = @hasField(@TypeOf(clk_ctrl.*).underlying_type, "SRC");

    // couple of clocks doesn't have dividers, for example CLK_PERI
    const has_clk_div = @hasDecl(registers.CLOCKS, "CLK_" ++ clock ++ "_DIV");

    const clk_div = if (has_clk_div) @field(registers.CLOCKS, "CLK_" ++ clock ++ "_DIV") else {};
    const clk_selected = @field(registers.CLOCKS, "CLK_" ++ clock ++ "_SELECTED");

    // if the clock is disabled we can just disable it and return
    if (!clock_config.enable) {
        clk_ctrl.modify(.{ .ENABLE = 0 });
        return;
    }

    // avoid overspped when switching to faster clock source
    if (has_clk_div) {
        if (clock_config.divider > clk_div.raw)
            clk_div.raw = clock_config.divider;
    }

    // switch the clock away from auxiliary source to avoid glitches
    // this is a case only for ref and sys clock, on rest of the clocks
    // we need to stop the clock before configuring it
    if (has_clk_ctrl_src) {
        clk_ctrl.modify(.{ .SRC = @intToEnum(@TypeOf(clk_ctrl.read().SRC), 0) });
        while (clk_selected.raw != 1) {
            asm volatile ("" ::: "memory");
        }
    } else {
        clk_ctrl.modify(.{ .ENABLE = 0 });

        // wait for ENABLE to propagate
        // TODO: we should delay for 3 cycles of the target clock
        // which is not that easy to calculate because we changed to divider
        // for now i choosed the delay arbitrary
        var i: u24 = 0;
        while (i < 3 * 50) : (i += 1) {
            @import("std").mem.doNotOptimizeAway(i);
        }
    }

    // set aux clock first, so we can later swtich to it in glitchless way
    if (clock_config.src == .AUX) {
        clk_ctrl.modify(.{
            .AUXSRC = switch (clock_config.auxsrc) {
                .PLL_SYS => .clksrc_pll_sys,
                .PLL_USB => .clksrc_pll_usb,
                .CLK_SYS => .clk_sys,
            },
        });
    }

    if (has_clk_ctrl_src) {
        // for some unknown reasons the enum values for auxiliary source in SRC registers
        // use different name in every clock, so we have to find it at comptime
        const clk_ctrl_src = @TypeOf(clk_ctrl.read().SRC);
        const clk_ctrl_src_aux = comptime @intToEnum(clk_ctrl_src, blk: {
            for (std.meta.fields(clk_ctrl_src)) |field| {
                if (std.mem.endsWith(u8, field.name, "_aux"))
                    break :blk field.value;
            }
            @compileError("aux src not found");
        });

        clk_ctrl.modify(.{ .SRC = switch (clock_config.src) {
            .XOSC => .xosc_clksrc,
            .ROSC => .rosc_clksrc_ph,
            .AUX => clk_ctrl_src_aux,
        } });

        // wait for the clock to be selected
        const src_idx = @as(u32, 1) << @intCast(u3, @enumToInt(clk_ctrl.read().SRC));
        while ((clk_selected.raw & src_idx) == 0) {
            asm volatile ("" ::: "memory");
        }
    }

    // enable/disable clock if it can be
    if (@hasField(@TypeOf(clk_ctrl.*).underlying_type, "ENABLE")) {
        clk_ctrl.modify(.{ .ENABLE = if (clock_config.enable) 1 else 0 });
    }

    // now we are safe to set the divider
    if (has_clk_div) {
        clk_div.raw = clock_config.divider;
    }
}

const PrecalcatedClocks = packed struct {
    xosc: packed struct {
        frequency: u32,
        enable: bool,
        delay: u14,
        frequency_range: std.meta.fieldInfo(@TypeOf(registers.XOSC.CTRL.*).underlying_type, .FREQ_RANGE).field_type,
    },
    pll: packed struct {
        sys: pll.PLL_CLOCK_CONFIG,
        usb: pll.PLL_CLOCK_CONFIG,
    },

    clocks: packed struct {
        // TODO: those types should use src/auxsrc types from the registers to avoid translations
        ref: CLOCK_CONFIG,
        sys: CLOCK_CONFIG,
        usb: CLOCK_CONFIG,
        adc: CLOCK_CONFIG,
        rtc: CLOCK_CONFIG,
        peri: CLOCK_CONFIG,

        // TODO: gpout clocks
    },

    const CLOCK_CONFIG = packed struct {
        frequency: u32,
        enable: bool,
        divider: u32, // TODO: reduce size of this field
        src: CLOCK_SRC,
        auxsrc: CLOCK_AUXSRC,
    };

    const CLOCK_SRC = enum(u2) {
        XOSC,
        ROSC,
        AUX,
    };
    const CLOCK_AUXSRC = enum(u2) {
        PLL_SYS,
        PLL_USB,
        CLK_SYS,
    };
};

comptime {
    if (@sizeOf(PrecalcatedClocks) > 72)
        @compileError("PrecalcatedClocks structure is bigger than expected");
}

fn getSrcClockFreqency(
    comptime clock_config: anytype,
    comptime xosc_config: anytype,
    comptime pll_config: anytype,
    comptime already_configured_clocks: anytype,
) u32 {
    return switch (clock_config.src) {
        .XOSC => xosc_config.frequency,
        .ROSC => @compileError("???"),
        .AUX => switch (clock_config.auxsrc) {
            .PLL_SYS => pll_config.sys.frequency,
            .PLL_USB => pll_config.usb.frequency,
            .CLK_SYS => already_configured_clocks.sys.frequency,
        },
    };
}

fn translateClock(
    comptime clock_name: anytype,
    comptime clock_config: anytype,
    comptime xosc_config: anytype,
    comptime pll_config: anytype,
    comptime already_configured_clocks: anytype,
) PrecalcatedClocks.CLOCK_CONFIG {
    _ = clock_name;
    const src_frequency = getSrcClockFreqency(clock_config, xosc_config, pll_config, already_configured_clocks);

    const divider = if (@hasField(@TypeOf(clock_config), "frequency")) @truncate(
        u32,
        (@intCast(u64, src_frequency) << 8) / @intCast(u64, clock_config.frequency),
    ) else 1;

    const frequency = if (@hasField(@TypeOf(clock_config), "frequency")) clock_config.frequency else src_frequency;

    if (frequency > src_frequency)
        @compileError("frequency is higher than source clock");

    return .{
        .frequency = frequency, // TODO: use divider
        .enable = true,
        .divider = divider,
        .src = clock_config.src,
        .auxsrc = clock_config.auxsrc,
    };
}

pub fn precalculateClocks(comptime clocks: anytype) PrecalcatedClocks {
    // TODO: make this optional
    if (!@hasField(@TypeOf(clocks), "xosc"))
        @compileError("xosc frequency is required");

    const xosc_config =
        if (!@hasField(@TypeOf(clocks), "xosc"))
    .{ .frequency = 0, .delay = 0, .enable = false, .frequency_range = .@"1_15MHZ" } else .{
        .frequency = clocks.xosc.frequency,
        .delay = (clocks.xosc.frequency / 1000 + 128) / 256,
        .enable = true,
        .frequency_range = .@"1_15MHZ",
    };
    const pll_config = .{ // TODO: allow PLLs to use something else than XOSC
        .sys = pll.calculateConfig(xosc_config.frequency, clocks.pll.sys.frequency),
        .usb = pll.calculateConfig(xosc_config.frequency, clocks.pll.usb.frequency),
    };

    // TODO: that is what the comment at the beginning of the file is refering to
    const clocks_config0 = .{ .ref = translateClock("REF", clocks.clocks.ref, xosc_config, pll_config, .{}) };
    const clocks_config1 = .{ .ref = clocks_config0.ref, .usb = translateClock("USB", clocks.clocks.usb, xosc_config, pll_config, clocks_config0) };
    const clocks_config2 = .{ .ref = clocks_config1.ref, .usb = clocks_config1.usb, .adc = translateClock("ADC", clocks.clocks.adc, xosc_config, pll_config, clocks_config1) };
    const clocks_config3 = .{ .ref = clocks_config2.ref, .usb = clocks_config2.usb, .adc = clocks_config2.adc, .rtc = translateClock("RTC", clocks.clocks.rtc, xosc_config, pll_config, clocks_config2) };
    const clocks_config4 = .{ .ref = clocks_config3.ref, .usb = clocks_config3.usb, .adc = clocks_config3.adc, .rtc = clocks_config3.rtc, .sys = translateClock("SYS", clocks.clocks.sys, xosc_config, pll_config, clocks_config3) };
    const clocks_config = .{ .ref = clocks_config4.ref, .usb = clocks_config4.usb, .adc = clocks_config4.adc, .rtc = clocks_config4.rtc, .sys = clocks_config4.sys, .peri = translateClock("PERI", clocks.clocks.peri, xosc_config, pll_config, clocks_config4) };

    return .{
        .xosc = xosc_config,
        .pll = pll_config,
        .clocks = clocks_config,
    };
}

pub const current_clocks_config = precalculateClocks(default_clocks);
