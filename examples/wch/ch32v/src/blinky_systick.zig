const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const cpu = microzig.cpu;
const peripherals = microzig.chip.peripherals;

const led = if (cpu.cpu_name == .@"qingkev2-rv32ec")
    hal.gpio.Pin.init(2, 0) // PC0
else
    hal.gpio.Pin.init(0, 3); // PA3

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .SysTick = sys_tick_handler,
    },
};

fn sys_tick_handler() callconv(cpu.riscv_calling_convention) void {
    // Toggle the LED pin.
    led.toggle();

    // Clear the trigger state for the next interrupt.
    peripherals.PFIC.STK_SR.modify(.{ .CNTIF = 0 });
}

pub fn main() !void {
    // Enable Port
    if (cpu.cpu_name == .@"qingkev2-rv32ec")
        peripherals.RCC.APB2PCENR.modify(.{ .IOPCEN = 1 })
    else
        peripherals.RCC.APB2PCENR.modify(.{ .IOPAEN = 1 });

    // Set the LED pin as output.
    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);

    // Configure SysTick

    const PFIC = peripherals.PFIC;
    // Reset configuration.
    PFIC.STK_CTLR.raw = 0;
    // Reset the Count Register.
    PFIC.STK_CNTL.raw = 0;
    // Set the compare register to trigger once per second.
    PFIC.STK_CMPLR.raw = cpu.cpu_frequency - 1;
    // Set the SysTick Configuration.
    PFIC.STK_CTLR.modify(.{
        // Turn on the system counter STK
        .STE = 1,
        // Enable counter interrupt.
        .STIE = 1,
        // HCLK for time base.
        .STCLK = 1,
        // Re-counting from 0 after counting up to the comparison value.
        .STRE = 1,
    });
    // Clear the trigger state for the next interrupt.
    PFIC.STK_SR.modify(.{ .CNTIF = 0 });

    // Enable SysTick interrupt.
    cpu.interrupt.enable(.SysTick);

    while (true) {
        // Wait for interrupt.
        cpu.wfi();
    }
}
