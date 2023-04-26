//! This is the entry point and root file of microzig.
//! If you do a @import("microzig"), you'll *basically* get this file.
//!
//! But microzig employs a proxy tactic

const std = @import("std");
const root = @import("root");
const builtin = @import("builtin");

/// The app that is currently built.
pub const app = @import("app");

/// Contains build-time generated configuration options for microzig.
/// Contains a CPU target description, chip, board and cpu information
/// and so on.
pub const config = @import("config");

/// Provides access to the low level features of the CPU.
pub const cpu = @import("cpu");

/// Provides access to the low level features of the current microchip.
pub const chip = struct {
    const inner = @import("chip");
    pub const types = inner.types;
    pub usingnamespace @field(inner.devices, config.chip_name);
};

/// Provides higher level APIs for interacting with hardware
pub const hal = if (config.has_hal) @import("hal") else void;

/// Provides access to board features or is `void` when no board is present.
pub const board = if (config.has_board) @import("board") else void;

pub const mmio = @import("mmio.zig");
pub const interrupt = @import("interrupt.zig");
pub const core = @import("core.zig");
pub const drivers = @import("drivers.zig");

/// The microzig default panic handler. Will disable interrupts and loop endlessly.
pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {

    // utilize logging functions
    std.log.err("microzig PANIC: {s}", .{message});

    if (builtin.cpu.arch != .avr) {
        var index: usize = 0;
        var iter = std.debug.StackIterator.init(@returnAddress(), null);
        while (iter.next()) |address| : (index += 1) {
            if (index == 0) {
                std.log.err("stack trace:", .{});
            }
            std.log.err("{d: >3}: 0x{X:0>8}", .{ index, address });
        }
    }
    if (@import("builtin").mode == .Debug) {
        // attach a breakpoint, this might trigger another
        // panic internally, so only do that in debug mode.
        std.log.info("triggering breakpoint...", .{});
        @breakpoint();
    }
    hang();
}

/// Hangs the processor and will stop doing anything useful. Use with caution!
pub fn hang() noreturn {
    cpu.disable_interrupts();
    while (true) {
        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: "memory");
    }
}
