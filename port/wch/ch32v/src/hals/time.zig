const std = @import("std");
const microzig = @import("microzig");
const cpu = microzig.cpu;
const board = microzig.board;
const time = microzig.drivers.time;

const peripherals = microzig.chip.peripherals;
const PFIC = peripherals.PFIC;

/// Global tick counter in microseconds.
/// Incremented by the SysTick interrupt handler.
var ticks_us: u64 = 0;

/// Interval between SysTick interrupts in microseconds.
/// Configured during init().
var tick_interval_us: u64 = 1000; // Default 1ms

/// Initialize the time system with SysTick.
///
/// This configures SysTick to trigger interrupts at regular intervals and maintains
/// a microsecond counter.
/// NOTE: This must be called AFTER configuring the system clock to the final frequency.
pub fn init() void {
    // Reset configuration
    PFIC.STK_CTLR.raw = 0;

    // Reset the count register
    PFIC.STK_CNTL.raw = 0;

    // Configure SysTick to trigger every 1ms
    // Compute tick interval using board frequency if available, else CPU default
    const freq: u32 = if (microzig.config.has_board and @hasDecl(board, "cpu_frequency"))
        board.cpu_frequency
    else
        microzig.cpu.cpu_frequency;
    const counts_per_ms = freq / 1000;
    tick_interval_us = 1000;

    // Set the compare register
    PFIC.STK_CMPLR.raw = counts_per_ms - 1;

    // Configure SysTick
    PFIC.STK_CTLR.modify(.{
        // Turn on the system counter STK
        .STE = 1,
        // Enable counter interrupt
        .STIE = 1,
        // HCLK for time base
        .STCLK = 1,
        // Re-counting from 0 after counting up to the comparison value
        .STRE = 1,
    });

    // Clear the trigger state
    PFIC.STK_SR.modify(.{ .CNTIF = 0 });

    // Enable SysTick interrupt
    cpu.interrupt.enable(.SysTick);
}

/// SysTick interrupt handler.
///
/// This should be registered in the chip default_interrupts
/// ```zig
/// pub const default_interrupts: microzig.cpu.InterruptOptions = .{
///    .SysTick = time.systick_handler,
/// };
/// ```
pub fn systick_handler() callconv(cpu.riscv_calling_convention) void {
    // Increment the tick counter
    ticks_us +%= tick_interval_us;

    // Clear the trigger state for the next interrupt
    PFIC.STK_SR.modify(.{ .CNTIF = 0 });
}

/// Get the current time since boot.
pub fn get_time_since_boot() time.Absolute {
    // Read the tick counter
    // NOTE: On RISC-V, we rely on the fact that reading a u64 is atomic on 32-bit systems when
    // properly aligned. The worst case is reading a slightly stale value.
    return time.Absolute.from_us(ticks_us);
}

/// Sleep for the specified number of milliseconds.
pub fn sleep_ms(time_ms: u32) void {
    sleep_us(@as(u64, time_ms) * 1000);
}

/// Sleep for the specified number of microseconds.
pub fn sleep_us(time_us: u64) void {
    // Busy-wait using the cycle counter in safe chunks to avoid overflow.
    var remaining = time_us;
    while (remaining > 0) {
        const chunk: u32 = @intCast(@min(remaining, 1_000_000)); // <= 1s per iteration
        delay_us(chunk);
        remaining -= chunk;
    }
}

/// Busy-wait for the specified number of microseconds using the RISC-V cycle counter.
///
/// This does not depend on SysTick granularity and provides sub-millisecond resolution.
/// It blocks the CPU and may be affected by interrupt latency.
pub fn delay_us(us: u32) void {
    const freq: u32 = if (microzig.config.has_board and @hasDecl(board, "cpu_frequency"))
        board.cpu_frequency
    else
        microzig.cpu.cpu_frequency;

    // Guard against very low frequencies
    if (freq < 1_000_000 or us == 0) return;

    const cycles_per_us: u32 = freq / 1_000_000;

    // Ensure the cycle counter is running (clear mcountinhibit.CY if present)
    if (@hasField(cpu.csr, "mcountinhibit")) {
        const ci = cpu.csr.mcountinhibit.read();
        if ((ci & 0x1) != 0) cpu.csr.mcountinhibit.write(ci & ~@as(u32, 1));
    }

    // Probe whether the cycle counter advances at all; if not, fall back.
    const probe0: u32 = cpu.csr.cycle.read();
    asm volatile ("" ::: .{ .memory = true });
    const probe1: u32 = cpu.csr.cycle.read();
    // TODO: Determine if this works on ANY ch32v chips. It does not seem to on CH32V203
    if (probe0 == probe1) {
        // Fallback: use a dedicated tight loop. We keep a volatile asm barrier in the loop body to
        // prevent the compiler from removing or merging iterations. In practice this still
        // generates a tight (addi+bnez) loop on QingKe cores.
        //
        // Effective cost ≈ 3 cycles/iter (2 instructions + branch penalty).
        // If hardware observation shows a ~4/3 slowdown, consider either:
        //  - switching the loop body to an explicit `nop` and using 4 cycles/iter,
        //  - or adding a one-time boot calibration when mcycle is available.
        const cycles_per_iter: u32 = 3;
        const total_cycles: u32 = us * cycles_per_us;
        const iters: u32 = (total_cycles + cycles_per_iter - 1) / cycles_per_iter; // ceil
        fallback_delay_iters(iters);
        return;
    }

    const start: u32 = probe0;
    const wait_cycles: u32 = us * cycles_per_us;
    while (@as(u32, cpu.csr.cycle.read() - start) < wait_cycles) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

// A dedicated function for the fallback loop to keep the body stable across optimization levels
fn fallback_delay_iters(iter: u32) callconv(.c) void {
    var i = iter;
    if (i == 0) return;
    while (i != 0) : (i -= 1) {
        // Don't optimize away. Should be 2 instructions, addi + bne, with a cycle lost on branch
        // prediction.
        asm volatile ("" ::: .{ .memory = true });
    }
}

/// Create a deadline that expires in the specified number of milliseconds.
pub fn deadline_in_ms(time_ms: u32) time.Deadline {
    return time.Deadline.init_relative(get_time_since_boot(), time.Duration.from_ms(time_ms));
}

/// Create a deadline that expires in the specified number of microseconds.
pub fn deadline_in_us(time_us: u64) time.Deadline {
    return time.Deadline.init_relative(get_time_since_boot(), time.Duration.from_us(time_us));
}
