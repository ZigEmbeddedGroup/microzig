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
/// Uses the interrupt-driven tick counter for accurate timing regardless of interrupt latency.
pub fn sleep_ms(time_ms: u32) void {
    const deadline = get_time_since_boot().add_duration(time.Duration.from_ms(time_ms));
    while (deadline.is_reached_by(get_time_since_boot()) == false) {
        asm volatile ("" ::: .{ .memory = true });
    }
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

/// Busy-wait for the specified number of microseconds.
///
/// For sub-millisecond delays (< 800us), uses SysTick CNT directly for accuracy
/// immune to interrupt latency. For longer delays, breaks down into ms + us.
pub fn delay_us(us: u32) void {
    if (us == 0) return;

    // For delays >= 800us, split into ms + us to avoid SysTick wrap issues, since we setup Systick to fire every 1ms, which resets the count
    if (us >= 800) {
        const ms = us / 1000;
        const remainder = us % 1000;
        if (ms > 0) sleep_ms(ms);
        if (remainder > 0) delay_us(remainder);
        return;
    }

    // Use SysTick CNT for sub-millisecond delays (immune to interrupt latency)
    const freq: u32 = if (microzig.config.has_board and @hasDecl(board, "cpu_frequency"))
        board.cpu_frequency
    else
        microzig.cpu.cpu_frequency;

    // SysTick counter runs at HCLK (configured via init)
    // counts_per_ms = freq / 1000, so ticks_per_us = freq / 1_000_000
    const ticks_per_us: u32 = freq / 1_000_000;
    const ticks: u32 = us * ticks_per_us;

    // Read start value and wait using wrapping arithmetic
    const start: u32 = PFIC.STK_CNTL.raw;
    while (@as(u32, PFIC.STK_CNTL.raw -% start) < ticks) {
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
