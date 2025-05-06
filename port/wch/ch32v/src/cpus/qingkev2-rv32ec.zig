const microzig = @import("microzig");
const root = @import("root");
const peripherals = microzig.chip.peripherals;

const common = @import("ch32v_common.zig");

pub const cpu_frequency = 24_000_000; // 24 MHz

pub const riscv_calling_convention = common.riscv_calling_convention;
pub const Exception = common.Exception;
pub const Interrupt = enum(u8) {
    /// Non-maskable interrupt
    NMI = 2,
    /// Abnormal interruptions
    HardFault = 3,
    /// System timer interrupt
    SysTick = 12,
    /// Software interrupt
    SW = 14,
    /// Window Watchdog interrupt
    WWDG = 16,
    /// PVD through EXTI line detection interrupt
    PVD = 17,
    /// Flash global interrupt
    FLASH = 18,
    /// Reset and clock control interrupt
    RCC = 19,
    /// EXTI Line[7:0] interrupt
    EXTI7_0 = 20,
    /// AWU global interrupt
    AWU = 21,
    /// DMA1 Channel 1 global interrupt
    DMA1_Channel1 = 22,
    /// DMA1 Channel 2 global interrupt
    DMA1_Channel2 = 23,
    /// DMA1 Channel 3 global interrupt
    DMA1_Channel3 = 24,
    /// DMA1 Channel 4 global interrupt
    DMA1_Channel4 = 25,
    /// DMA1 Channel 5 global interrupt
    DMA1_Channel5 = 26,
    /// DMA1 Channel 6 global interrupt
    DMA1_Channel6 = 27,
    /// DMA1 Channel 7 global interrupt
    DMA1_Channel7 = 28,
    /// ADC global interrupt
    ADC = 29,
    /// I2C1 event interrupt
    I2C1_EV = 30,
    /// I2C1 error interrupt
    I2C1_ER = 31,
    /// USART1 global interrupt
    USART1 = 32,
    /// SPI1 global interrupt
    SPI1 = 33,
    /// TIM1 Break interrupt
    TIM1BRK = 34,
    /// TIM1 Update interrupt
    TIM1UP = 35,
    /// TIM1 Trigger and Commutation interrupts
    TIM1RG = 36,
    /// TIM1 Capture Compare interrupt
    TIM1CC = 37,
    /// TIM2 global interrupt
    TIM2 = 38,
};
pub const InterruptHandler = common.InterruptHandler;
pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = Interrupt, .HandlerFn = InterruptHandler },
});

pub const interrupt = common.GenerateInterruptFuncs(Interrupt);

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

const vector_table = common.generate_vector_table(Interrupt);

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
    @export(&vector_table, .{
        .name = "vector_table",
        .section = "microzig_flash_start",
    });
}

pub const csr = common.csr;
