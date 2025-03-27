const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");

pub const interrupt = struct {
    pub fn globally_enabled() bool {
        return asm volatile ("csrr %[value], mstatus"
            : [value] "=r" (-> u32),
        ) & 0x8 != 0;
    }

    pub fn enable_interrupts() void {
        asm volatile ("csrs mstatus, 0x8");
    }

    pub fn disable_interrupts() void {
        asm volatile ("csrc mstatus, 0x8");
    }
};

pub fn wfi() void {
    asm volatile ("wfi");
}

pub fn wfe() void {
    asm volatile ("csrs 0x810, 0x1");
    wfi();
    asm volatile ("csrs 0x810, 0x1");
}

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

        microzig_main();
    }

    // TODO: implement interrupts
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });

    @export(&startup_logic._start_c, .{
        .name = "_start_c",
    });
}
