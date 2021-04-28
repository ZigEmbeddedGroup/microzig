const std = @import("std");

pub fn sei() void {
    __enable_irq();
}

pub fn cli() void {
    __disable_irq();
}

pub fn __enable_irq() void {
    asm volatile ("cpsie i");
}
pub fn __disable_irq() void {
    asm volatile ("cpsid i");
}

pub fn __enable_fault_irq() void {
    asm volatile ("cpsie f");
}
pub fn __disable_fault_irq() void {
    asm volatile ("cpsid f");
}

pub fn __NOP() void {
    asm volatile ("nop");
}
pub fn __WFI() void {
    asm volatile ("wfi");
}
pub fn __WFE() void {
    asm volatile ("wfe");
}
pub fn __SEV() void {
    asm volatile ("sev");
}
pub fn __ISB() void {
    asm volatile ("isb");
}
pub fn __DSB() void {
    asm volatile ("dsb");
}
pub fn __DMB() void {
    asm volatile ("dmb");
}
pub fn __CLREX() void {
    asm volatile ("clrex");
}

pub const startup_logic = struct {
    const InterruptVector = fn () callconv(.C) void;

    const VectorTable = extern struct {
        initial_stack_pointer: u32,
        reset: InterruptVector,
        nmi: InterruptVector = unhandledInterrupt,
        hard_fault: InterruptVector = unhandledInterrupt,
        mpu_fault: InterruptVector = unhandledInterrupt,
        bus_fault: InterruptVector = unhandledInterrupt,
        usage_fault: InterruptVector = unhandledInterrupt,

        reserved: u32 = 0,
    };

    export const vectors linksection("microzig_flash_start") = VectorTable{
        // TODO: How to compute/get the initial stack pointer?
        .initial_stack_pointer = 0x1000_7FFC, // HACK: hardcoded, do not keep!
        .reset = _start,
    };

    fn unhandledInterrupt() callconv(.C) noreturn {
        @panic("unhandled interrupt");
    }

    extern fn microzig_main() noreturn;

    extern var microzig_data_start: c_void;
    extern var microzig_data_end: c_void;
    extern var microzig_bss_start: c_void;
    extern var microzig_bss_end: c_void;
    extern const microzig_data_load_start: c_void;

    fn _start() callconv(.C) noreturn {

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
