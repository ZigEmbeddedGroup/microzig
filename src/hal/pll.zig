const std = @import("std");
const microzig = @import("microzig");
const assert = std.debug.assert;

// TODO: remove
const gpio = @import("gpio.zig");

const regs = microzig.chip.registers;
const xosc_freq = microzig.board.xosc_freq;

pub const Configuration = struct {
    refdiv: u6,
    fbdiv: u32,
    postdiv1: u3,
    postdiv2: u3,

    pub fn frequency(config: Configuration) u32 {
        return @as(u32, xosc_freq) / config.refdiv * config.fbdiv / config.postdiv1 / config.postdiv2;
    }
};

pub const PLL = enum {
    sys,
    usb,

    fn getRegs(pll: PLL) *volatile PllRegs {
        return &plls[@enumToInt(pll)];
    }

    pub fn reset(pll: PLL) void {
        switch (pll) {
            .sys => {
                regs.RESETS.RESET.modify(.{ .pll_sys = 1 });
                regs.RESETS.RESET.modify(.{ .pll_sys = 0 });
                while (regs.RESETS.RESET_DONE.read().pll_sys != 1) {}
            },
            .usb => {
                regs.RESETS.RESET.modify(.{ .pll_usb = 1 });
                regs.RESETS.RESET.modify(.{ .pll_usb = 0 });
                while (regs.RESETS.RESET_DONE.read().pll_usb != 1) {}
            },
        }
    }

    pub fn isLocked(pll: PLL) bool {
        const pll_regs = pll.getRegs();
        return pll_regs.cs.read().LOCK == 1;
    }

    pub fn apply(pll: PLL, comptime config: Configuration) void {
        assert(config.fbdiv >= 16 and config.fbdiv <= 320);
        assert(config.postdiv1 >= 1 and config.postdiv1 <= 7);
        assert(config.postdiv2 >= 1 and config.postdiv2 <= 7);
        assert(config.postdiv2 <= config.postdiv1);

        const pll_regs = pll.getRegs();
        const ref_freq = xosc_freq / @as(u32, config.refdiv);
        const vco_freq = ref_freq * config.fbdiv;
        assert(ref_freq <= vco_freq / 16);

        // 1. program reference clock divider
        // 2. program feedback divider
        // 3. turn on the main power and vco
        // 4. wait for vco to lock
        // 5. set up post dividers and turn them on

        // do not bother a PLL which is already configured
        if (pll.isLocked() and
            config.refdiv == pll_regs.cs.read().REFDIV and
            config.fbdiv == pll_regs.fbdiv_int.read() and
            config.postdiv1 == pll_regs.prim.read().POSTDIV1 and
            config.postdiv2 == pll_regs.prim.read().POSTDIV2)
        {
            return;
        }

        pll.reset();

        // load vco related dividers
        pll_regs.cs.modify(.{ .REFDIV = config.refdiv });
        pll_regs.fbdiv_int.modify(config.fbdiv);

        // turn on PLL
        pll_regs.pwr.modify(.{ .PD = 0, .VCOPD = 0 });

        // wait for PLL to lock
        while (!pll.isLocked()) {}

        pll_regs.prim.modify(.{
            .POSTDIV1 = config.postdiv1,
            .POSTDIV2 = config.postdiv2,
        });

        pll_regs.pwr.modify(.{ .POSTDIVPD = 0 });
    }
};

const plls = @intToPtr(*volatile [2]PllRegs, regs.PLL_SYS.base_address);
comptime {
    assert(@sizeOf(PllRegs) == (regs.PLL_USB.base_address - regs.PLL_SYS.base_address));
}

const CsReg = @typeInfo(@TypeOf(regs.PLL_SYS.CS)).Pointer.child;
const PwrReg = @typeInfo(@TypeOf(regs.PLL_SYS.PWR)).Pointer.child;
const FbdivIntReg = @typeInfo(@TypeOf(regs.PLL_SYS.FBDIV_INT)).Pointer.child;
const PrimReg = @typeInfo(@TypeOf(regs.PLL_SYS.PRIM)).Pointer.child;

pub const PllRegs = extern struct {
    cs: CsReg,
    pwr: PwrReg,
    fbdiv_int: FbdivIntReg,
    prim: PrimReg,

    padding: [4092]u32,
};
