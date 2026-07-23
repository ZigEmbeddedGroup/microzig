const microzig = @import("microzig");
const hal = microzig.hal;
const cpu = microzig.cpu;
const board = microzig.board;
const peripherals = microzig.chip.peripherals;

const Pins = hal.pins.Pins(board.pin_config);
var pins: Pins = undefined;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub const microzig_options: microzig.Options = .{
    .overwrite_hal_interrupts = true,
    .interrupts = .{
        .SysTick = sys_tick_handler,
    },
};

fn sys_tick_handler() callconv(cpu.riscv_calling_convention) void {
    pins.led.toggle();
    peripherals.PFIC.STK_SR.modify(.{ .CNTIF = 0 });
}

pub fn main() !void {
    board.init();
    pins = board.pin_config.apply();

    // Configure SysTick for 1 Hz interrupt.
    const PFIC = peripherals.PFIC;
    // Reset configuration.
    PFIC.STK_CTLR.raw = 0;
    // Reset the Count Register.
    PFIC.STK_CNTL.raw = 0;
    // Set the compare register to trigger once per second.
    PFIC.STK_CMPLR.raw = board.cpu_frequency - 1;
    // Set the SysTick Configuration.
    PFIC.STK_CTLR.modify(.{
        .STE = 1,
        .STIE = 1,
        .STCLK = 1,
        .STRE = 1,
    });
    // Clear the trigger state for the next interrupt.
    PFIC.STK_SR.modify(.{ .CNTIF = 0 });

    cpu.interrupt.enable(.SysTick);

    while (true) {
        cpu.wfe();
    }
}
