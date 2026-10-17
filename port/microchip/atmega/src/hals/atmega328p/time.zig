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

const interrupts = @import("interrupts.zig");

const TC0 = microzig.chip.peripherals.TC0;

/// Timer0 counts every 64 CPU cycles. The overflow interrupt then runs every
/// 16384 cycles, so its cost (about 90 cycles) stays under 1 %.
const prescaler = 64;
const clock_select = switch (prescaler) {
    1 => .RUNNING_NO_PRESCALING,
    8 => .RUNNING_CLK_8,
    64 => .RUNNING_CLK_64,
    256 => .RUNNING_CLK_256,
    1024 => .RUNNING_CLK_1024,
    else => @compileError(std.fmt.comptimePrint("Timer0 has no /{} prescaler", .{prescaler})),
};

/// Microseconds per Timer0 tick. A power of two, so that converting ticks
/// to microseconds is a shift (AVR has no 64-bit multiply).
const us_per_tick = blk: {
    if (!microzig.config.has_board)
        @compileError("hal.time takes the CPU frequency from the board");
    break :blk find_us_per_tick(microzig.board.clock_frequencies.cpu) orelse
        @compileError(std.fmt.comptimePrint("hal.time needs a CPU frequency where {} cycles take " ++
            "a power-of-two number of microseconds, such as 8 or 16 MHz", .{prescaler}));
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

/// Starts counting from zero. Call it once, early; the app must also
/// register `timer0_overflow` and enable interrupts.
pub fn init() void {
    if (comptime !handler_registered())
        @compileError("hal.time needs `.TIMER0_OVF = hal.time.timer0_overflow` " ++
            "in microzig_options.interrupts");

    const section = interrupts.enter_critical_section();
    defer section.leave();

    // Normal mode (count up to 255 and wrap), with OC0A/OC0B (D6/D5) left as
    // GPIOs.
    TC0.TCCR0A.write(.{ .WGM0 = 0, .COM0B = 0, .COM0A = 0 });
    // Start from zero.
    TC0.TCNT0 = 0;
    overflows = 0;
    // Clear a pending overflow (writing 1 clears a flag, 0 leaves it).
    TC0.TIFR0.write(.{ .TOV0 = 1, .OCF0A = 0, .OCF0B = 0 });
    // Interrupt on overflow only.
    TC0.TIMSK0.write(.{ .TOIE0 = 1, .OCIE0A = 0, .OCIE0B = 0 });
    // Start counting; WGM02 = 0 completes normal mode.
    TC0.TCCR0B.write(.{ .CS0 = clock_select, .WGM02 = 0, .FOC0B = 0, .FOC0A = 0 });
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
    const section = interrupts.enter_critical_section();
    var count = overflows;
    var tcnt = TC0.TCNT0;
    // An overflow that is still pending isn't in `overflows` yet. TCNT0 is
    // read again, because the first read may have been from before it.
    if (TC0.TIFR0.read().TOV0 == 1) {
        count += 1;
        tcnt = TC0.TCNT0;
    }
    section.leave();
    return count << 8 | tcnt;
}

/// Microseconds per tick at `cpu_frequency`, or null if that isn't a whole
/// power of two.
fn find_us_per_tick(comptime cpu_frequency: u32) ?u32 {
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
