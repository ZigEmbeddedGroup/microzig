const std = @import("std");
const microzig = @import("microzig");

pub fn sei() void {
    asm volatile ("cpsie i");
}

pub fn cli() void {
    asm volatile ("cpsid i");
}

pub fn enable_fault_irq() void {
    asm volatile ("cpsie f");
}
pub fn disable_fault_irq() void {
    asm volatile ("cpsid f");
}

pub fn nop() void {
    asm volatile ("nop");
}
pub fn wfi() void {
    asm volatile ("wfi");
}
pub fn wfe() void {
    asm volatile ("wfe");
}
pub fn sev() void {
    asm volatile ("sev");
}
pub fn isb() void {
    asm volatile ("isb");
}
pub fn dsb() void {
    asm volatile ("dsb");
}
pub fn dmb() void {
    asm volatile ("dmb");
}
pub fn clrex() void {
    asm volatile ("clrex");
}

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    extern var microzig_data_start: anyopaque;
    extern var microzig_data_end: anyopaque;
    extern var microzig_bss_start: anyopaque;
    extern var microzig_bss_end: anyopaque;
    extern const microzig_data_load_start: anyopaque;

    pub fn _start() callconv(.C) noreturn {

        // fill .bss with zeroes
        {
            const bss_start = @ptrCast([*]u8, &microzig_bss_start);
            const bss_end = @ptrCast([*]u8, &microzig_bss_end);
            const bss_len = @ptrToInt(bss_end) - @ptrToInt(bss_start);

            std.mem.set(u8, bss_start[0..bss_len], 0);
        }

        // load .data from flash
        {
            const data_start = @ptrCast([*]u8, &microzig_data_start);
            const data_end = @ptrCast([*]u8, &microzig_data_end);
            const data_len = @ptrToInt(data_end) - @ptrToInt(data_start);
            const data_src = @ptrCast([*]const u8, &microzig_data_load_start);

            std.mem.copy(u8, data_start[0..data_len], data_src[0..data_len]);
        }

        microzig_main();
    }
};
