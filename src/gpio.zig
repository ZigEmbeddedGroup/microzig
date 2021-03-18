const mmio = @import("rk2040.zig");

pub fn init() void {
    mmio.RESETS.RESET.set(.{ .pads_bank0 = false });
    while (true) {
        const v = mmio.RESETS.RESET_DONE.read();
        if (v.pads_bank0)
            break;
    }
}

pub fn Pin(comptime pin: u8) type {
    return struct {
        pub fn set() void {
            mmio.SIO.GPIO_OUT_SET.set(.{ .GPIO_OUT_SET = 1 << pin });
        }
        pub fn clr() void {
            mmio.SIO.GPIO_OUT_CLR.set(.{ .GPIO_OUT_CLR = 1 << pin });
        }
        pub fn toggle() void {
            if (((mmio.SIO.GPIO_OE_SET.get().GPIO_OE_SET << pin) & 1) == 1) {
                set();
            } else {
                clr();
            }
        }
    };
}
