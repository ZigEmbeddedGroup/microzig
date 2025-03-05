const std = @import("std");
const root = @import("root");
const microzig = @import("microzig");

pub fn enable_interrupts() void {
    @panic("TODO");
}

pub fn disable_interrupts() void {
    @panic("TODO");
}

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

    pub fn _start() linksection("microzig_flash_start") callconv(.Naked) noreturn {
        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );

        asm volatile (
            \\la a0, vector_table
            \\csrw mtvec, a0
            \\
            \\csrr a0, mhartid // if core 1 gets here (through a miracle), send it back to bootrom
            \\bnez a0, reenter_bootrom
            \\
            \\j _start_c
            \\
            \\reenter_bootrom:
            \\li a0, 0x7dfc
            \\jr a0
        );
    }

    pub fn _start_c() callconv(.C) noreturn {
        root.initialize_system_memories();

        microzig_main();
    }

    pub fn trap_handler() callconv(.C) void {
        // TODO: something useful
        @panic("trap occured");
    }
};

pub const vector_table = wrap_trap_handler(startup_logic.trap_handler);

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });

    @export(&startup_logic._start_c, .{
        .name = "_start_c",
    });
}

pub inline fn wrap_trap_handler(inner: fn () callconv(.C) void) fn () callconv(.Naked) noreturn {
    return struct {
        const unique_call_inner_export_name = @typeName(@This()) ++ "_call_inner";

        comptime {
            @export(&call_inner, .{
                .name = unique_call_inner_export_name,
            });
        }

        pub fn wrapper() callconv(.Naked) noreturn {
            push_interrupt_state();

            asm volatile (std.fmt.comptimePrint("jal ra, {s}", .{unique_call_inner_export_name}));

            pop_interrupt_state();

            asm volatile (
                \\ mret
            );
        }

        const registers = [_][]const u8{
            "ra", "t0", "t1", "t2", "t3", "t4", "t5", "t6",
            "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
        };

        inline fn push_interrupt_state() void {
            asm volatile (std.fmt.comptimePrint("addi sp, sp, -{}", .{registers.len * @sizeOf(u32)}));

            inline for (registers, 0..) |reg, i| {
                asm volatile (std.fmt.comptimePrint("sw {s}, 4*{}(sp)", .{ reg, i }));
            }
        }

        inline fn pop_interrupt_state() void {
            inline for (registers, 0..) |reg, i| {
                asm volatile (std.fmt.comptimePrint("lw {s}, 4*{}(sp)", .{ reg, i }));
            }

            asm volatile (std.fmt.comptimePrint("addi sp, sp, {}", .{registers.len * @sizeOf(u32)}));
        }

        fn call_inner() callconv(.C) void {
            inner();
        }
    }.wrapper;
}
