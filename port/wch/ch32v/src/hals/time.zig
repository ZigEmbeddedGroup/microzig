const std = @import("std");
const microzig = @import("microzig");
const cpu = microzig.cpu;
const board = microzig.board;
const time = microzig.drivers.time;

const peripherals = microzig.chip.peripherals;
const PFIC = peripherals.PFIC;
const RCC = peripherals.RCC;
const TIM2 = peripherals.TIM2;

/// Global tick counter in microseconds.
/// Incremented by the TIM2 interrupt handler.
var ticks_us: u64 = 0;

/// Interval between TIM2 interrupts in microseconds.
/// Configured during init().
var tick_interval_us: u64 = 1000; // Default 1ms

/// Initialize SysTick as a free-running counter for delays.
///
/// This configures SysTick to run continuously without interrupts or auto-reload.
/// CNTH:CNTL together form a 64-bit counter that increments at HCLK rate.
/// NOTE: This must be called AFTER configuring the system clock to the final frequency.
fn init_delay_counter() void {
    // Configure SysTick for free-running mode (no interrupts, no auto-reload)
    PFIC.STK_CTLR.modify(.{
        // Turn on the system counter STK
        .STE = 1,
        // Disable counter interrupt
        .STIE = 0,
        // HCLK for time base (i.e. count 8x faster)
        .STCLK = 1,
        // Free-running (no auto-reload)
        .STRE = 0,
    });

    // Reset the count registers
    PFIC.STK_CNTL.raw = 0;
    PFIC.STK_CNTH.raw = 0;
}

/// Initialize TIM2 to fire interrupts every 1ms for timekeeping.
///
/// This configures TIM2 to generate periodic interrupts that maintain the ticks_us counter.
/// NOTE: This must be called AFTER configuring the system clock to the final frequency.
fn init_tick_timer() void {
    const freq: u32 = if (microzig.config.has_board and @hasDecl(board, "cpu_frequency"))
        board.cpu_frequency
    else
        microzig.cpu.cpu_frequency;

    // Enable TIM2 clock (bit 0 of APB1PCENR)
    RCC.APB1PCENR.raw |= 1 << 0;

    // Set prescaler and auto-reload for 1ms ticks
    // For 48MHz: PSC = 47 (divide by 48), ARR = 999 (count to 1000)
    // = 48MHz / 48 / 1000 = 1kHz = 1ms
    const prescaler: u16 = @intCast((freq / 1_000_000) - 1); // Divide to 1MHz
    TIM2.PSC.modify(.{ .PSC = prescaler });
    TIM2.ATRLR.modify(.{ .ARR = 999 }); // Count 1000 cycles = 1ms at 1MHz

    // Enable update interrupt
    TIM2.DMAINTENR.modify(.{ .UIE = 1 });

    // Enable the counter
    TIM2.CTLR1.modify(.{ .CEN = 1 });

    // Enable TIM2 interrupt in NVIC
    cpu.interrupt.enable(.TIM2);
}

/// Initialize the time system with TIM2 and SysTick.
///
/// - TIM2: Configured to fire interrupts every 1ms, maintaining a microsecond counter
/// - SysTick: Configured as a free-running 64-bit counter for precise delays (no interrupts)
/// NOTE: This must be called AFTER configuring the system clock to the final frequency.
pub fn init() void {
    tick_interval_us = 1000; // 1ms intervals

    // Initialize SysTick as free-running delay counter (no interrupts)
    init_delay_counter();

    // Initialize TIM2 for periodic 1ms interrupts
    init_tick_timer();
}

/// TIM2 interrupt handler.
///
/// This should be registered in the chip default_interrupts
/// ```zig
/// pub const default_interrupts: microzig.cpu.InterruptOptions = .{
///    .TIM2 = time.tim2_handler,
/// };
/// ```
pub fn tim2_handler() callconv(cpu.riscv_calling_convention) void {
    // Increment the tick counter
    ticks_us +%= tick_interval_us;

    // Clear the update interrupt flag
    TIM2.INTFR.modify(.{ .UIF = 0 });
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

/// Busy-wait for the specified number of microseconds using SysTick.
///
/// Uses SysTick as a free-running 64-bit counter. This provides:
/// - No interrupt conflicts (SysTick runs with no interrupts, TIM2 handles timing)
/// - 64-bit range (practically unlimited delays)
/// - Immune to interrupt latency (counter runs continuously)
/// - Direct hardware access, no wrapping concerns
pub fn delay_us(us: u32) void {
    if (us == 0) return;

    const freq: u32 = if (microzig.config.has_board and @hasDecl(board, "cpu_frequency"))
        board.cpu_frequency
    else
        microzig.cpu.cpu_frequency;

    // SysTick counter runs at HCLK
    // Calculate ticks needed for the delay
    const ticks_per_us: u32 = freq / 1_000_000;
    const ticks: u64 = @as(u64, us) * @as(u64, ticks_per_us);

    // Read 64-bit counter (CNTH:CNTL)
    const start_low: u32 = PFIC.STK_CNTL.raw;
    const start_high: u32 = PFIC.STK_CNTH.raw;
    const start: u64 = (@as(u64, start_high) << 32) | @as(u64, start_low);

    // Wait until enough ticks have elapsed
    while (true) {
        const current_low: u32 = PFIC.STK_CNTL.raw;
        const current_high: u32 = PFIC.STK_CNTH.raw;
        const current: u64 = (@as(u64, current_high) << 32) | @as(u64, current_low);

        if (current - start >= ticks) break;
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
