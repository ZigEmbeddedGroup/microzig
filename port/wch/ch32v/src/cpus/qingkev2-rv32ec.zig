const microzig = @import("microzig");
const root = @import("root");
const peripherals = microzig.chip.peripherals;

const common = @import("ch32v_common.zig");

pub const cpu_frequency = 24_000_000; // 24 MHz

pub const interrupt = common.interrupt;

pub const wfi = common.wfi;
pub const wfe = common.wfe;

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
        csr.intsyscr_v2.write(.{ .hwstken = 1, .inesten = 1, .eabien = 1 });
        csr.mtvec.write(.{ .mode0 = 1, .mode1 = 1, .base = 0 });
        // Enable interrupts.
        csr.mstatus.write(.{ .mie = 1, .mpie = 1 });

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

    pub fn _system_init() callconv(.c) void {
        const FLASH = peripherals.FLASH;
        const RCC = peripherals.RCC;

        FLASH.ACTLR.modify(.{ .LATENCY = 0 });

        RCC.CTLR.modify(.{ .HSION = 1 });
        RCC.CFGR0.modify(.{
            .SW = 0,
            .SWS = 0,
            .HPRE = 0,
            .ADCPRE = 0,
            .MCO = 0,
        });
        RCC.CTLR.modify(.{ .HSEON = 0, .CSSON = 0, .PLLON = 0 });
        RCC.CTLR.modify(.{ .HSEBYP = 0 });
        RCC.CFGR0.modify(.{ .PLLSRC = 0 });
        RCC.INTR.write(.{
            // Read-only ready flags.
            .LSIRDYF = 0,
            .HSIRDYF = 0,
            .HSERDYF = 0,
            .PLLRDYF = 0,
            .CSSF = 0,
            // Disable ready interrupts.
            .LSIRDYIE = 0,
            .HSIRDYIE = 0,
            .HSERDYIE = 0,
            .PLLRDYIE = 0,
            // Clear ready flags.
            .LSIRDYC = 1,
            .HSIRDYC = 1,
            .HSERDYC = 1,
            .PLLRDYC = 1,
            .CSSC = 1,
        });

        // Adjusts the Internal High Speed oscillator (HSI) calibration value.
        RCC.CTLR.modify(.{ .HSITRIM = 0x10 });
    }

    export fn _reset_vector() linksection("microzig_flash_start") callconv(.naked) void {
        asm volatile ("j _start");
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
}

pub const csr = common.csr;
