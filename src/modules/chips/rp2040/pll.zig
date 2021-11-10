const std = @import("std");

const registers = @import("registers.zig");
const clocks = @import("clocks.zig");

const VCO_MAX = 1600 * 1024 * 1024;
const VCO_MIN = 400 * 1024 * 1024;

pub fn calculateConfig(comptime input: u64, comptime target_frequency: u64) PLL_CLOCK_CONFIG {
    @setEvalBranchQuota(50000);
    var best: struct { out: u64, fbdiv: u64, pd1: u3, pd2: u3 } = .{
        .out = 0,
        .fbdiv = 0,
        .pd1 = 0,
        .pd2 = 0,
    };
    var best_margin = target_frequency;

    var fbdiv: u64 = 320;
    while (fbdiv >= 16) {
        const vco = input * fbdiv;

        if (vco < VCO_MIN or vco > VCO_MAX) {
            fbdiv = fbdiv - 1;
            continue;
        }

        var pd2: u3 = 1;
        while (true) {
            var pd1: u3 = 1;
            while (true) {
                const out = vco / pd1 / pd2;
                const margin = std.math.absInt(@intCast(i64, out) - @intCast(i64, target_frequency)) catch unreachable;

                if (margin < best_margin) {
                    best = .{
                        .out = out,
                        .fbdiv = fbdiv,
                        .pd1 = pd1,
                        .pd2 = pd2,
                    };
                    best_margin = margin;
                }
                if (pd1 == 7)
                    break;
                pd1 = pd1 + 1;
            }
            if (pd2 == 7)
                break;
            pd2 = pd2 + 1;
        }
        fbdiv = fbdiv - 1;
    }

    if ((input * best.fbdiv) / best.pd1 / best.pd2 != target_frequency)
        @compileError("failed to calculate exactly the requestd PLL frequency");

    return .{ .fbdiv = best.fbdiv, .pd1 = best.pd1, .pd2 = best.pd2, .frequency = target_frequency };
}

// this function assume that the configuratin is valid
pub fn apply(pll: anytype, comptime config: anytype) void {
    // turn of PLL
    pll.PWR.raw = 0xffffffff;
    pll.FBDIV_INT.modify(.{ .FBDIV_INT = 0 });

    // TODO: hardcoded for now
    pll.CS.modify(.{ .REFDIV = 1 });

    pll.FBDIV_INT.modify(.{ .FBDIV_INT = config.fbdiv });

    // turn on PLL
    pll.PWR.modify(.{ .PD = 0, .VCOPD = 0 });

    // wait for PLL to lock
    while (pll.CS.read().LOCK == 0)
        asm volatile ("" ::: "memory");

    // turn on PLL
    pll.PWR.modify(.{
        .PD = 0, // main power
        .VCOPD = 0, // VCO power
    });

    // postdiv1 can handle higher frequencies than postdiv2
    if (config.pd1 < config.pd2)
        @compileError("postdiv1 should be bigger than postdiv2");

    // setup up psot dividers
    pll.PRIM.modify(.{ .POSTDIV1 = config.pd1, .POSTDIV2 = config.pd2 });

    // turn on post divider
    pll.PWR.modify(.{
        .POSTDIVPD = 0, // post divider power
    });
}

pub const PLL_CLOCK_CONFIG = packed struct {
    frequency: u32,
    fbdiv: u12,
    pd1: u3,
    pd2: u3,
};
