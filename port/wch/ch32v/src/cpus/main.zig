const microzig = @import("microzig");

const common = @import("ch32v_common.zig");
const cpu_impl = @import("cpu_impl");

pub const cpu_frequency = cpu_impl.cpu_frequency;

// Interrupt

pub const Interrupt = cpu_impl.Interrupt;
pub const riscv_calling_convention = common.riscv_calling_convention;
pub const Exception = common.Exception;
pub const InterruptHandler = common.InterruptHandler;
pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = Interrupt, .HandlerFn = InterruptHandler },
});
pub const interrupt = common.GenerateInterruptFuncs(Interrupt);

pub const wfi = common.wfi;
pub const wfe = common.wfe;

// Startup

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub fn _start() callconv(.naked) void {
        // Set global pointer.
        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );
        // Set stack pointer.
        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );

        @call(.always_inline, common.initialize_system_memories, .{});

        // Configure the interrupts.
        // FIXME
        // csr.intsyscr_v2.write(.{ .hwstken = 1, .inesten = 1, .eabien = 1 });
        csr.intsyscr_v4.write(.{ .hwstken = 1, .inesten = 1, .pmtcfg = 0b10 });
        csr.corecfgr.write_raw(0x1f);
        csr.mstatus.write(.{ .mie = 1, .mpie = 1, .fs = .dirty });

        csr.mtvec.write(.{ .mode0 = 1, .mode1 = 1, .base = 0 });
        // Enable interrupts.
        // csr.mstatus.write(.{ .mie = 1, .mpie = 1 });

        // Initialize the system.
        @export(&startup_logic._system_init, .{ .name = "_system_init" });
        asm volatile (
            \\jal _system_init
        );

        // Load the address of the `microzig_main` function into the `mepc` register
        // and transfer control to it using the `mret` instruction.
        // This is necessary to ensure proper MCU startup after a power-off.
        // Directly calling the function from an interrupt would prevent the MCU from starting correctly.
        asm volatile (
            \\la t0, microzig_main
            \\csrw mepc, t0
        );

        // Return from the interrupt.
        asm volatile ("mret");
    }

    fn _system_init() callconv(.c) void {
        cpu_impl.system_init(microzig.chip);
    }

    export fn _reset_vector() linksection("microzig_flash_start") callconv(.naked) void {
        asm volatile ("j _start");
    }
};

// Vector table

const vector_table = common.generate_vector_table(Interrupt);

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
    @export(&vector_table, .{
        .name = "vector_table",
        .section = "microzig_flash_start",
    });
}

// CSR

pub const csr = common.csr;
