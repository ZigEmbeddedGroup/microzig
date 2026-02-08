const microzig = @import("microzig");
const WDTCTL = &microzig.chip.peripherals.Watchdog_Timer.WDTCTL;

pub fn disable() void {
    var reg = WDTCTL.read();
    reg.WDTHOLD = 1;
    // TODO: Allow adding fields in patches
    reg.padding = 0x5A;
    WDTCTL.write(reg);
}
