const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const xosc_freq = microzig.board.xosc_freq;
const peripherals = microzig.chip.peripherals;
const RESETS = peripherals.RESETS;

const PllRegs = microzig.chip.types.peripherals.PLL_SYS;

pub const Configuration = struct {
    refdiv: u6,
    fbdiv: u32,
    postdiv1: u3,
    postdiv2: u3,

    pub fn frequency(config: Configuration) u32 {
        return @as(u32, xosc_freq) / config.refdiv * config.fbdiv / config.postdiv1 / config.postdiv2;
    }
};

pub const PLL = enum(u1) {
    sys,
    usb,

    fn get_regs(pll: PLL) *volatile PllRegs {
        return switch (pll) {
            .sys => peripherals.PLL_SYS,
            .usb => peripherals.PLL_USB,
        };
    }

    pub fn reset(pll: PLL) void {
        switch (pll) {
            .sys => {
                RESETS.RESET.modify(.{ .pll_sys = 1 });
                RESETS.RESET.modify(.{ .pll_sys = 0 });
                while (RESETS.RESET_DONE.read().pll_sys != 1) {}
            },
            .usb => {
                RESETS.RESET.modify(.{ .pll_usb = 1 });
                RESETS.RESET.modify(.{ .pll_usb = 0 });
                while (RESETS.RESET_DONE.read().pll_usb != 1) {}
            },
        }
    }

    pub fn is_locked(pll: PLL) bool {
        const pll_regs = pll.get_regs();
        return pll_regs.CS.read().LOCK == 1;
    }

    pub fn apply(pll: PLL, comptime config: Configuration) void {
        comptime assert(config.fbdiv >= 16 and config.fbdiv <= 320);
        comptime assert(config.postdiv1 >= 1 and config.postdiv1 <= 7);
        comptime assert(config.postdiv2 >= 1 and config.postdiv2 <= 7);
        comptime assert(config.postdiv2 <= config.postdiv1);

        const pll_regs = pll.get_regs();
        const ref_freq = xosc_freq / @as(u32, config.refdiv);
        const vco_freq = ref_freq * config.fbdiv;
        comptime assert(ref_freq <= vco_freq / 16);

        // 1. program reference clock divider
        // 2. program feedback divider
        // 3. turn on the main power and vco
        // 4. wait for vco to lock
        // 5. set up post dividers and turn them on

        // do not bother a PLL which is already configured
        if (pll.is_locked() and
            config.refdiv == pll_regs.CS.read().REFDIV and
            config.fbdiv == pll_regs.FBDIV_INT.read().FBDIV_INT and
            config.postdiv1 == pll_regs.PRIM.read().POSTDIV1 and
            config.postdiv2 == pll_regs.PRIM.read().POSTDIV2)
        {
            return;
        }

        pll.reset();

        // load vco related dividers
        pll_regs.CS.modify(.{ .REFDIV = config.refdiv });
        pll_regs.FBDIV_INT.modify(.{ .FBDIV_INT = config.fbdiv });

        // turn on PLL
        pll_regs.PWR.modify(.{ .PD = 0, .VCOPD = 0 });

        // wait for PLL to lock
        while (!pll.is_locked()) {}

        pll_regs.PRIM.modify(.{
            .POSTDIV1 = config.postdiv1,
            .POSTDIV2 = config.postdiv2,
        });

        pll_regs.PWR.modify(.{ .POSTDIVPD = 0 });
    }
};
