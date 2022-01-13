const std = @import("std");

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
    const InterruptVector = fn () callconv(.C) void;

    const VectorTable = extern struct {
        initial_stack_pointer: u32,
        reset: InterruptVector,
        nmi: InterruptVector = makeUnhandledHandler("nmi"),
        hard_fault: InterruptVector = makeUnhandledHandler("hard_fault"),
        mpu_fault: InterruptVector = makeUnhandledHandler("mpu_fault"),
        bus_fault: InterruptVector = makeUnhandledHandler("bus_fault"),
        usage_fault: InterruptVector = makeUnhandledHandler("usage_fault"),

        reserved: u32 = 0,
    };

    export const vectors linksection("microzig_flash_start") = VectorTable{
        // TODO: How to compute/get the initial stack pointer?
        .initial_stack_pointer = 0x2000_A000, // HACK: hardcoded, do not keep!
        .reset = _start,
    };

    fn makeUnhandledHandler(comptime str: []const u8) fn () callconv(.C) noreturn {
        return struct {
            fn unhandledInterrupt() callconv(.C) noreturn {
                @panic("unhandled interrupt: " ++ str);
            }
        }.unhandledInterrupt;
    }

    extern fn microzig_main() noreturn;

    extern var microzig_data_start: anyopaque;
    extern var microzig_data_end: anyopaque;
    extern var microzig_bss_start: anyopaque;
    extern var microzig_bss_end: anyopaque;
    extern const microzig_data_load_start: anyopaque;

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
