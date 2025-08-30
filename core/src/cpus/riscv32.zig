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
    // Config entry0 addr to all 1s to make the range cover all space
    asm volatile ("li x6, 0xffffffff" ::: .{ .x6 = true });
    asm volatile ("csrw pmpaddr0, x6");
    // Config entry0 cfg to make it NAPOT address mode, and R/W/X okay
    asm volatile ("li x6, 0x7f" ::: .{ .x6 = true });
    asm volatile ("csrw pmpcfg0, x6");
}

pub fn switch_m2u_mode() void {
    asm volatile ("la x6, 1f    " ::: .{ .x6 = true });
    asm volatile ("csrw mepc, x6");
    asm volatile ("mret");
    asm volatile ("1:");
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
