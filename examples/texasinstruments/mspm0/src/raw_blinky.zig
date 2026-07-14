const microzig = @import("microzig");

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});
comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    const pin = 22;

    const IOMUX_BASE: usize = 0x40428000;
    const GPIO0_BASE: usize = 0x400A0000;
    const PINCM: *usize = @ptrFromInt(IOMUX_BASE + (pin + 1) * 4);
    const GPIO_DOE31_0: *usize = @ptrFromInt(GPIO0_BASE + 0x12c0);
    const GPIO_DOUTTGL31_0: *usize = @ptrFromInt(GPIO0_BASE + 0x12b0);
    const PIN_MASK: usize = (1 << pin);
    const GPIO0_PWREN: *usize = @ptrFromInt(GPIO0_BASE + 0x800);

    GPIO0_PWREN.* = 0x26000001;
    PINCM.* = (1 << 0) | (1 << 7);
    GPIO_DOE31_0.* |= PIN_MASK;

    while (true) {
        GPIO_DOUTTGL31_0.* = PIN_MASK;

        for (0..2_000_000) |_|
            asm volatile ("nop");
    }
}
