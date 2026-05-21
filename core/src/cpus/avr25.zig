const std = @import("std");
const microzig = @import("microzig");
const avr = @import("avr_common.zig");

export const abort = avr.abort;

pub const interrupt = avr.interrupt;
pub const HandlerFn = avr.HandlerFn;
pub const Interrupt = avr.Interrupt;
pub const InterruptOptions = avr.InterruptOptions;

pub const sbi = avr.sbi;
pub const cbi = avr.cbi;

fn vector_table() linksection("microzig_flash_start") callconv(.naked) noreturn {
    asm volatile (avr.generate_vector_table_asm(.rjmp));
}

pub fn export_startup_logic() void {
    _ = startup_logic;
    @export(&vector_table, .{
        .name = "_start",
    });
}

pub const startup_logic = avr.startup_logic;
