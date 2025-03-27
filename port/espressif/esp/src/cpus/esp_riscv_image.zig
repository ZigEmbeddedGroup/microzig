const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");
const microzig_options = root.microzig_options;

const common = @import("esp_riscv_common.zig");

const riscv_calling_convention: std.builtin.CallingConvention = .{ .riscv32_interrupt = .{ .mode = .machine } };

pub const InterruptHandler = extern union {
    naked: *const fn () callconv(.naked) noreturn,
    riscv: *const fn () callconv(riscv_calling_convention) void,
};

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = common.Interrupt, .HandlerFn = InterruptHandler },
});

pub const interrupt = common.interrupt;

pub const wfi = common.wfi;
pub const wfe = common.wfe;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub const sections = struct {
        extern var microzig_bss_start: u8;
        extern var microzig_bss_end: u8;
    };

    pub export fn _start() callconv(.naked) noreturn {
        asm volatile (
            \\mv sp, %[eos]
            \\jal _start_c
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );
    }

    pub export fn _start_c() callconv(.c) noreturn {
        interrupt.disable_interrupts();

        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        asm volatile (
            \\la a0, _vector_table
            \\csrw mtvec, a0
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

    fn unhandled_interrupt() callconv(riscv_calling_convention) void {
        @panic("unhandled interrupt");
    }

    pub export fn _vector_table() align(256) callconv(.naked) noreturn {
        const vector_table_asm = comptime blk: {
            var vtable: []const u8 =
                \\j _exception_handler
                \\
            ;
            for (1..32) |i| {
                vtable = vtable ++ std.fmt.comptimePrint(
                    \\j _interrupt_handler_{}
                    \\
                , .{i});
            }
            break :blk vtable;
        };

        comptime {
            // NOTE: using the union variant .naked here is fine because both variants have the same layout
            @export(if (microzig_options.interrupts.Exception) |handler|
                handler.naked
            else
                &unhandled_interrupt, .{ .name = "_exception_handler" });

            for (1..32) |i| {
                @export(
                    if (@field(microzig_options.interrupts, std.fmt.comptimePrint("{}", .{i}))) |handler|
                        handler.naked
                    else
                        &unhandled_interrupt,
                    .{ .name = std.fmt.comptimePrint("_interrupt_handler_{}", .{i}) },
                );
            }
        }

        asm volatile (vector_table_asm);
    }
};

pub fn export_startup_logic() void {
    std.testing.refAllDecls(startup_logic);
}
