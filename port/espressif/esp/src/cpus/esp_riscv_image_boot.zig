const std = @import("std");
const microzig = @import("microzig");

const common = @import("esp_riscv_common.zig");

pub const Interrupt = common.Interrupt;
pub const InterruptHandler = common.InterruptHandler;
pub const InterruptOptions = common.InterruptOptions;
pub const TrapFrame = common.TrapFrame;

pub const interrupt = common.interrupt;

pub const nop = common.nop;
pub const wfi = common.wfi;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub const sections = struct {
        extern var microzig_bss_start: u8;
        extern var microzig_bss_end: u8;
    };

    pub fn _start() callconv(.naked) noreturn {
        asm volatile (
            \\mv sp, %[eos]
            \\jal _start_c
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );
    }

    pub fn _start_c() callconv(.c) noreturn {
        interrupt.disable_interrupts();

        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        // fill .bss with zeroes
        {
            const bss_start: [*]u8 = @ptrCast(&sections.microzig_bss_start);
            const bss_end: [*]u8 = @ptrCast(&sections.microzig_bss_end);
            const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss_start);

            @memset(bss_start[0..bss_len], 0);
        }

        common.init_interrupts();

        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
    @export(&startup_logic._start_c, .{ .name = "_start_c" });
}

pub const csr = common.csr;
