const std = @import("std");
const microzig = @import("microzig");

const riscv32_common = @import("riscv32-common");

pub const interrupt = riscv32_common.interrupt;

pub const nop = riscv32_common.nop;
pub const wfi = riscv32_common.wfi;

pub fn wfe() void {
    asm volatile ("csrs 0x810, 0x1");
    wfi();
    asm volatile ("csrs 0x810, 0x1");
}

pub fn pmp_open_all_space() void {
    asm volatile (
        \\
        // Config entry0 addr to all 1s to make the range cover all space
        \\li x6, 0xffffffff
        \\csrw pmpaddr0, x6
        // Config entry0 cfg to make it NAPOT address mode, and R/W/X okay
        \\li x6, 0x7f
        \\csrw pmpcfg0, x6
        ::: .{ .x6 = true });
}

pub fn switch_m2u_mode() void {
    asm volatile (
        \\la x6, 1f
        \\csrw mepc, x6
        \\mret
        \\1:
        ::: .{ .x6 = true });
}

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub fn _start() linksection("microzig_flash_start") callconv(.c) noreturn {
        microzig.utilities.initialize_system_memories(.all);

        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });
}

pub const csr = riscv32_common.csr;
