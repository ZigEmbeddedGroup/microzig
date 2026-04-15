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
