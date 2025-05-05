const microzig = @import("microzig");
const root = @import("root");

const common = @import("ch32v_common.zig");

pub const cpu_frequency = 24_000_000; // 24 MHz

pub const interrupt = common.interrupt;

pub const wfi = common.wfi;
pub const wfe = common.wfe;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub fn _start() callconv(.c) void {
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

        asm volatile (
            \\jal _start_c
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

    pub fn _start_c() callconv(.c) void {
        root.initialize_system_memories();

        // Vendor-defined CSRs
        // 3.2 Interrupt-related CSR Registers
        asm volatile ("csrsi 0x804, 0b111"); // INTSYSCR: enable EABI + Interrupt nesting + HPE
        asm volatile ("csrsi mtvec, 0b11"); // mtvec: absolute address + vector table mode

        // Enable interrupts.
        // Set MPIE and MIE.
        asm volatile (
            \\li t0, 0x88
            \\csrw mstatus, t0
        );

        // init system clock
        const RCC = microzig.chip.peripherals.RCC;
        RCC.CTLR.modify(.{ .HSION = 1 });
        RCC.CFGR0.raw &= 0xF8FF0000;
        RCC.CTLR.modify(.{ .HSEON = 0, .CSSON = 0 });
        RCC.CTLR.modify(.{ .HSEBYP = 0 });
        RCC.CFGR0.modify(.{ .PLLSRC = 0 });
        RCC.INTR.raw = 0x009F0000;
    }

    export fn _reset_vector() linksection("microzig_flash_start") callconv(.naked) void {
        asm volatile ("j _start");
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
    @export(&startup_logic._start_c, .{ .name = "_start_c" });
}

pub const csr = common.csr;
