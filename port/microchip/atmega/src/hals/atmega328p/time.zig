//! Time since `init` for the ATmega328P, counted with Timer0 (opt-in).
//!
//! Timer0 runs in normal mode with a /64 prescaler, and its overflow
//! interrupt extends the 8-bit count to 64 bits. While in use, Timer0 isn't
//! available for anything else (such as the PWM on D5 and D6).
//!
//! The app registers the overflow handler, calls `init` and enables
//! interrupts:
//!
//! ```zig
//! pub const microzig_options: microzig.Options = .{
//!     .interrupts = .{ .TIMER0_OVF = hal.time.timer0_overflow },
//! };
//!
//! pub fn main() void {
//!     hal.time.init();
//!     microzig.interrupt.enable_interrupts();
//! }
//! ```
//!
//! The time counts from `init`. No ticks are lost as long as the overflow
//! interrupt is never kept waiting for a whole overflow period (256 ticks:
//! 1.024 ms at 16 MHz, 2.048 ms at 8 MHz) by critical sections or other
//! interrupt handlers. The sleeps need interrupts enabled, so they can't be
//! used in an interrupt handler.

const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;

const TC0 = microzig.chip.peripherals.TC0;

// The generated `peripherals.CPU` is a pointer to address 0, so SREG gets its
// own pointer at its offset (see `spi.zig`).
const CPU_Regs = microzig.chip.types.peripherals.CPU;
const SREG: *volatile u8 = @ptrFromInt(@offsetOf(CPU_Regs, "SREG"));

const prescaler = 64;

/// Microseconds per Timer0 tick. A power of two, so that converting ticks
/// to microseconds is a shift (AVR has no 64-bit multiply).
const us_per_tick = blk: {
    if (!microzig.config.has_board)
        @compileError("hal.time takes the CPU frequency from the board");
    break :blk find_us_per_tick(microzig.board.clock_frequencies.cpu) orelse
        @compileError("hal.time needs a CPU frequency where 64 cycles take a power-of-two number of microseconds, such as 8 or 16 MHz");
};

/// Number of Timer0 overflows since `init`.
var overflows: u64 = 0;

fn timer0_overflow_handler() callconv(.avr_signal) void {
    overflows += 1;
}

/// The TIMER0_OVF interrupt handler; register it in `microzig_options`.
pub const timer0_overflow: microzig.cpu.HandlerFn = .{ .signal = &timer0_overflow_handler };

fn handler_registered() bool {
    const handler = microzig.options.interrupts.TIMER0_OVF orelse return false;
    return switch (handler) {
        .signal => |func| func == &timer0_overflow_handler,
        else => false,
    };
}

/// Disables interrupts and returns SREG for `restore_interrupts`.
inline fn disable_interrupts() u8 {
    const sreg = SREG.*;
    asm volatile ("cli" ::: .{ .memory = true });
    return sreg;
}

/// Restores the interrupt flag saved by `disable_interrupts`.
inline fn restore_interrupts(sreg: u8) void {
    asm volatile ("" ::: .{ .memory = true });
    SREG.* = sreg;
}

/// Starts counting from zero. Call it once, early; the app must also
/// register `timer0_overflow` and enable interrupts.
pub fn init() void {
    if (comptime !handler_registered())
        @compileError("hal.time needs `.TIMER0_OVF = hal.time.timer0_overflow` in microzig_options.interrupts");

    const sreg = disable_interrupts();
    defer restore_interrupts(sreg);

    TC0.TCCR0A.write(.{ .WGM0 = 0, .COM0B = 0, .COM0A = 0 });
    TC0.TCNT0 = 0;
    overflows = 0;
    TC0.TIFR0.write(.{ .TOV0 = 1, .OCF0A = 0, .OCF0B = 0 }); // writing 1 clears it
    TC0.TIMSK0.write(.{ .TOIE0 = 1, .OCIE0A = 0, .OCIE0B = 0 });
    TC0.TCCR0B.write(.{ .CS0 = .RUNNING_CLK_64, .WGM02 = 0, .FOC0B = 0, .FOC0A = 0 });
}

/// Time since `init`.
pub fn get_time_since_boot() mdf.time.Absolute {
    return .from_us(read_ticks() * us_per_tick);
}

/// Waits at least `time_us` microseconds.
pub fn sleep_us(time_us: u64) void {
    if (time_us == 0) return;
    // One extra tick, because the wait may start at the end of a tick.
    const deadline: mdf.time.Absolute = .from_us(get_time_since_boot().to_us() +| time_us +| us_per_tick);
    while (!deadline.is_reached_by(get_time_since_boot())) {}
}

/// Waits at least `time_ms` milliseconds.
pub fn sleep_ms(time_ms: u32) void {
    // One millisecond at a time: multiplying by 1000 at runtime needs
    // `__muldi3`, which this port doesn't provide.
    var remaining = time_ms;
    while (remaining > 0) : (remaining -= 1) sleep_us(1000);
}

fn read_ticks() u64 {
    const sreg = disable_interrupts();
    var count = overflows;
    var tcnt = TC0.TCNT0;
    // An overflow that is still pending isn't in `overflows` yet. TCNT0 is
    // read again, because the first read may have been from before it.
    if (TC0.TIFR0.read().TOV0 == 1) {
        count += 1;
        tcnt = TC0.TCNT0;
    }
    restore_interrupts(sreg);
    return count << 8 | tcnt;
}

/// Microseconds per tick at `cpu_frequency`, or null if that isn't a whole
/// power of two.
fn find_us_per_tick(cpu_frequency: u32) ?u32 {
    if (cpu_frequency == 0 or prescaler * 1_000_000 % cpu_frequency != 0) return null;
    const us = prescaler * 1_000_000 / cpu_frequency;
    return if (std.math.isPowerOfTwo(us)) us else null;
}

test find_us_per_tick {
    try std.testing.expectEqual(4, find_us_per_tick(16_000_000));
    try std.testing.expectEqual(8, find_us_per_tick(8_000_000));
    try std.testing.expectEqual(null, find_us_per_tick(0));
    try std.testing.expectEqual(null, find_us_per_tick(12_000_000));
    try std.testing.expectEqual(null, find_us_per_tick(15_000_000));
    try std.testing.expectEqual(null, find_us_per_tick(20_000_000));
    try std.testing.expectEqual(null, find_us_per_tick(24_000_000));
}
