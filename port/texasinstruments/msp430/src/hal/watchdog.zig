const microzig = @import("microzig");
const WDTCTL = &microzig.chip.peripherals.Watchdog_Timer.WDTCTL;

pub fn disable() void {
    WDTCTL.modify(.{
        .WDTHOLD = 1,
        .WDTPW = 0x5A,
    });
}
