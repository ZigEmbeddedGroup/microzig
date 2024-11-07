// const std = @import("std");
const root = @import("root");
const microzig = @import("microzig");

pub const cpu_frequency = 8_000_000; // 8 MHz

pub inline fn enable_interrupts() void {
    asm volatile ("csrrs zero, mstatus, 0x8");
}

pub inline fn disable_interrupts() void {
    asm volatile ("csrrc zero, mstatus, 0x8");
}

pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn wfe() void {
    // TODO: impliment wfe()
    @compileError("wfe() is not implimented.");
    // set WFITOWFE on PFIC_SCTLR followed by
    // asm volatile ("wfi");
}

pub const startup_logic = struct {
    comptime {
        // Program codes are written from 0x800_0000.
        // The PC pointer after reset is 0x0000_0000 and reads codes from alias of flash memory.
        // This is not expected PC pointer on init.S. Thus jump to _abs_start is mandatory.
        asm (
            \\.section microzig_flash_start
            \\lui ra, %hi(_start)
            \\jr %lo(_start)(ra)
        );
    }

    extern fn microzig_main() noreturn;

    pub fn _start() linksection("microzig_flash_start") callconv(.C) noreturn {
        microzig.cpu.disable_interrupts(); // Power-on reset makes interrupts disbaled.

        // set global pointer
        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );
        // set stack pointer
        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );
        // root.initialize_system_memories();
        // smaller than initialize_system_memories() in start.zig
        initialize_system_memories();
        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(startup_logic._start, .{
        .name = "_start",
    });
}

inline fn initialize_system_memories() void {
    // clear .bss
    asm volatile (
        \\clear_bss_section:
        \\    la      t0, microzig_bss_start
        \\    la      t1, microzig_bss_end
        // \\    beq     t0, t1, clear_bss_done
        \\    j clear_bss_loop_end
        \\clear_bss_loop:
        \\    sw      zero, 0(t0)
        \\    addi    t0, t0, 4
        \\clear_bss_loop_end:
        \\    bltu    t0, t1, clear_bss_loop
        \\clear_bss_done:
    );

    // copy .data section to RAM
    asm volatile (
        \\copy_data_section:
        \\    la a0, microzig_data_load_start
        \\    la a1, microzig_data_start
        \\    la a2, microzig_data_end
        // \\    beq a1, a2, copy_data_done
        \\    j copy_data_loop_end
        \\copy_data_loop:
        \\    lw t0, 0(a0)
        \\    sw t0, 0(a1)
        \\    addi a0, a0, 4
        \\    addi a1, a1, 4
        \\copy_data_loop_end:
        \\    bltu a1, a2, copy_data_loop
        \\copy_data_done:
    );
}
