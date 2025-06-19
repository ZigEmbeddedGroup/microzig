const std = @import("std");
const logger = std.log.scoped(.cortex_m);

pub fn executing_isr() bool {
    return registers.system_control_block.icsr.read().VECTACTIVE != 0;
}

pub fn enable_interrupts() void {
    asm volatile ("cpsie i");
}

pub fn disable_interrupts() void {
    asm volatile ("cpsid i");
}

pub fn are_interrupts_enabled() bool {
    // Read PRIMASK register. When bit 0 is 0, interrupts are enabled.
    // When bit 0 is 1, interrupts are disabled.
    var primask: u32 = undefined;
    asm volatile ("mrs %[ret], primask"
        : [ret] "=r" (primask),
    );
    return (primask & 1) == 0;
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

pub const start = struct {
    //

    extern fn ashet_kernelMain() callconv(.C) noreturn;

    export fn _start() noreturn {
        // Force instantiation of vector table:
        _ = cortexM_initial_vector_table;

        // We want the hardfault to be split into smaller parts:
        registers.system_control_block.shcrs.modify(.{
            .memfault_enabled = true,
            .busfault_enabled = true,
            .usagefault_enabled = true,
        });

        enable_fault_irq();

        ashet_kernelMain();
    }

    pub const InterruptTable = extern struct {
        initial_stack_pointer: *anyopaque, // "Exception 0" => initial stack pointer value
        reset: FunctionPointer, // Exception 1
        nmi: FunctionPointer = panic_handler("nmi"), // Exception 2
        hard_fault: FunctionPointer = panic_handler("hard_fault"), // Exception 3
        mem_manage: FunctionPointer = panic_handler("mem_manage"), // Exception 4
        bus_fault: FunctionPointer = make_fault_handler(default_bus_fault_handler), // Exception 5
        usage_fault: FunctionPointer = make_fault_handler(default_usage_fault_handler), // Exception 6
        reserved_exception_7: FunctionPointer = panic_handler("reserved exception 7"), // Exception 7
        reserved_exception_8: FunctionPointer = panic_handler("reserved exception 8"), // Exception 8
        reserved_exception_9: FunctionPointer = panic_handler("reserved exception 9"), // Exception 9
        reserved_exception_10: FunctionPointer = panic_handler("reserved exception 10"), // Exception 10
        svcall: FunctionPointer = panic_handler("svcall"), // Exception 11
        debug_monitor: FunctionPointer = panic_handler("debug_monitor"), // Exception 12
        reserved_exception_13: FunctionPointer = panic_handler("reserved exception 13"), // Exception 13
        pendsv: FunctionPointer = panic_handler("pendsv"), // Exception 14
        systick: FunctionPointer = panic_handler("systick"), // Exception 15
    };

    extern var __kernel_stack_end: anyopaque;

    pub const initial_vector_table = &cortexM_initial_vector_table;

    export const cortexM_initial_vector_table: InterruptTable linksection(".text.vector_table") = .{
        .initial_stack_pointer = &__kernel_stack_end,
        .reset = _start,
    };

    const ContextStateFrame = extern struct {
        r0: u32,
        r1: u32,
        r2: u32,
        r3: u32,
        r12: u32,
        lr: u32,
        return_address: u32,
        xpsr: u32,
    };

    fn make_fault_handler(comptime handler: *const fn (context: *ContextStateFrame) callconv(.C) void) *const fn () callconv(.C) void {
        return struct {
            fn invoke() callconv(.C) void {
                // See this article on how we use that:
                // https://interrupt.memfault.com/blog/cortex-m-hardfault-debug
                asm volatile (
                    \\
                    // Check 2th bit of LR.
                    \\tst lr, #4
                    // Do "if then else" equal
                    \\ite eq
                    // if equals, we use the MSP
                    \\mrseq r0, msp
                    // otherwise, we use the PSP
                    \\mrsne r0, psp
                    // Then we branch to our handler:
                    \\b %[handler]
                    :
                    : [handler] "s" (handler),
                );
            }
        }.invoke;
    }

    fn default_bus_fault_handler(context: *ContextStateFrame) callconv(.C) void {
        const bfsr = registers.system_control_block.bfsr.read();

        logger.err("Bus Fault:", .{});
        logger.err("  context                         =  r0:0x{X:0>8}  r1:0x{X:0>8}  r2:0x{X:0>8}    r3:0x{X:0>8}", .{
            context.r0,
            context.r1,
            context.r2,
            context.r3,
        });
        logger.err("                                    r12:0x{X:0>8}  lr:0x{X:0>8}  ra:0x{X:0>8}  xpsr:0x{X:0>8}", .{
            context.r12,
            context.lr,
            context.return_address,
            context.xpsr,
        });
        logger.err("  instruction bus error           = {}", .{bfsr.instruction_bus_error});
        logger.err("  precice data bus error          = {}", .{bfsr.precice_data_bus_error});
        logger.err("  imprecice data bus error        = {}", .{bfsr.imprecice_data_bus_error});
        logger.err("  unstacking exception error      = {}", .{bfsr.unstacking_exception_error});
        logger.err("  exception stacking error        = {}", .{bfsr.exception_stacking_error});
        logger.err("  busfault address register valid = {}", .{bfsr.busfault_address_register_valid});
        if (bfsr.busfault_address_register_valid) {
            const address = registers.system_control_block.bfar.read().ADDRESS;
            logger.err("    busfault address register = 0x{X:0>8}", .{address});
        }
    }

    fn default_usage_fault_handler(context: *ContextStateFrame) callconv(.C) void {
        const ufsr = registers.system_control_block.ufsr.read();

        logger.err("Usage Fault:", .{});
        logger.err("  context                         =  r0:0x{X:0>8}  r1:0x{X:0>8}  r2:0x{X:0>8}    r3:0x{X:0>8}", .{
            context.r0,
            context.r1,
            context.r2,
            context.r3,
        });
        logger.err("                                    r12:0x{X:0>8}  lr:0x{X:0>8}  ra:0x{X:0>8}  xpsr:0x{X:0>8}", .{
            context.r12,
            context.lr,
            context.return_address,
            context.xpsr,
        });
        logger.err("  undefined instruction     = {}", .{ufsr.undefined_instruction});
        logger.err("  invalid state             = {}", .{ufsr.invalid_state});
        logger.err("  invalid pc load           = {}", .{ufsr.invalid_pc_load});
        logger.err("  missing coprocessor usage = {}", .{ufsr.missing_coprocessor_usage});
        logger.err("  unaligned memory access   = {}", .{ufsr.unaligned_memory_access});
        logger.err("  divide by zero            = {}", .{ufsr.divide_by_zero});

        @panic("usage fault");
    }

    fn panic_handler(comptime msg: []const u8) FunctionPointer {
        return struct {
            fn do_panic() callconv(.C) noreturn {
                @panic(msg);
            }
        }.do_panic;
    }

    export fn hang() noreturn {
        while (true) {
            // burn cycles:
            asm volatile ("" ::: "memory");
        }
    }
};

pub const FunctionPointer = *const fn () callconv(.C) void;

const ashet = struct {
    const utils = struct {
        const mmio = @import("mmio.zig");
    };
};

pub const registers = struct {
    const MmioRegister = ashet.utils.mmio.MmioRegister;
    const mmioRegister = ashet.utils.mmio.mmioRegister;

    // Memory regions:
    //   0xE000E008-0xE000E00F System control block
    //   0xE000E010-0xE000E01F System timer
    //   0xE000E100-0xE000E4EF Nested Vectored Interrupt Controller
    //   0xE000ED00-0xE000ED3F System control block
    //   0xE000ED90-0xE000ED93 MPU Type Register Reads as zero, indicating MPU is not
    //   0xE000ED90-0xE000EDB8 Memory Protection Unit
    //   0xE000EF00-0xE000EF03 Nested Vectored Interrupt Controller

    pub const system_control_block = struct {

        // 0xE000E008    ACTLR    RW    Privileged    0x00000000    Auxiliary Control Register
        // 0xE000ED00    CPUID    RO    Privileged    0x412FC230    CPUID Base Register
        // 0xE000ED04    ICSR     RW    Privileged    0x00000000    Interrupt Control and State Register
        // 0xE000ED08    VTOR     RW    Privileged    0x00000000    Vector Table Offset Register
        // 0xE000ED0C    AIRCR    RW    Privileged    0xFA050000    Application Interrupt and Reset Control Register
        // 0xE000ED10    SCR      RW    Privileged    0x00000000    System Control Register
        // 0xE000ED14    CCR      RW    Privileged    0x00000200    Configuration and Control Register
        // 0xE000ED18    SHPR1    RW    Privileged    0x00000000    System Handler Priority Register 1
        // 0xE000ED1C    SHPR2    RW    Privileged    0x00000000    System Handler Priority Register 2
        // 0xE000ED20    SHPR3    RW    Privileged    0x00000000    System Handler Priority Register 3
        // 0xE000ED24    SHCRS    RW    Privileged    0x00000000    System Handler Control and State Register
        // 0xE000ED28    CFSR     RW    Privileged    0x00000000    Configurable Fault Status Register
        // 0xE000ED28    MMSR     RW    Privileged    0x00          MemManage Fault Status Register
        // 0xE000ED29    BFSR     RW    Privileged    0x00          BusFault Status Register
        // 0xE000ED2A    UFSR     RW    Privileged    0x0000        UsageFault Status Register
        // 0xE000ED2C    HFSR     RW    Privileged    0x00000000    HardFault Status Register
        // 0xE000ED34    MMAR     RW    Privileged    Unknown       MemManage Fault Address Register
        // 0xE000ED38    BFAR     RW    Privileged    Unknown       BusFault Address Register
        // 0xE000ED3C    AFSR     RW    Privileged    0x00000000    Auxiliary Fault Status Register

        /// Auxiliary Control Register
        ///
        /// The ACTLR provides disable bits for the following processor functions:
        /// - IT folding
        /// - write buffer use for accesses to the default memory map
        /// - interruption of multi-cycle instructions.
        ///
        /// By default this register is set to provide optimum performance from the Cortex-M3 processor, and does not normally require modification.
        pub const actlr = mmioRegister(0xE000E008, packed struct(u32) {
            /// When set to 1, disables interruption of load multiple and store multiple instructions. This increases the interrupt latency of the processor because any LDM or STM must complete before the processor can stack the current state and enter the interrupt handler.
            disable_multiple_load_store: bool,

            /// When set to 1, disables write buffer use during default memory map accesses. This causes all BusFaults to be precise BusFaults but decreases performance because any store to memory must complete before the processor can execute the next instruction.
            /// Note: This bit only affects write buffers implemented in the Cortex-M3 processor.
            disable_write_buffers: bool,

            /// When set to 1, disables IT folding.
            ///
            /// In some situations, the processor can start executing the first instruction in an IT block while it is still executing the IT instruction. This behavior is called IT folding, and improves performance, However, IT folding can cause jitter in looping. If a task must avoid jitter, set the DISFOLD bit to 1 before executing the task, to disable IT folding.
            disable_it_folding: bool,

            _reserved: u29, // [31:3]
        }, .{});

        /// CPUID Base Register
        ///
        /// The CPUID register contains the processor part number, version, and implementation information.
        pub const cpuid = mmioRegister(0xE000ED00, packed struct(u32) {
            // values here are taken from the following sources:
            // - Arm documentation
            // - https://github.com/ARMmbed/mbed-os-example-sys-info/blob/master/main.cpp
            // - https://github.com/shirou/gopsutil/blob/master/cpu/cpu_linux.go

            /// Revision number, the P value in the rnPn product revision identifier:
            /// 0x0 = Patch 0
            revision: u4, // [3:0]

            /// Part number of the processor:
            /// 0xC23 = Cortex-M3
            part_number: enum(u12) { // [15:4]

                ARM810 = 0x810,
                ARM920 = 0x920,
                ARM922 = 0x922,
                ARM926 = 0x926,
                ARM940 = 0x940,
                ARM946 = 0x946,
                ARM966 = 0x966,
                ARM1020 = 0xa20,
                ARM1022 = 0xa22,
                ARM1026 = 0xa26,
                @"ARM11 MPCore" = 0xb02,
                ARM1136 = 0xb36,
                ARM1156 = 0xb56,
                ARM1176 = 0xb76,
                @"Cortex-A5" = 0xc05,
                @"Cortex-A7" = 0xc07,
                @"Cortex-A8" = 0xc08,
                @"Cortex-A9" = 0xc09,
                @"Cortex-A15" = 0xc0f,
                @"Cortex-A17_v0" = 0xc0d,
                @"Cortex-A17_v1" = 0xc0e,
                @"Cortex-R4" = 0xc14,
                @"Cortex-R5" = 0xc15,
                @"Cortex-R7" = 0xc17,
                @"Cortex-R8" = 0xc18,
                @"Cortex-M0" = 0xc20,
                @"Cortex-M1" = 0xc21,
                @"Cortex-M3" = 0xc23,
                @"Cortex-M4" = 0xc24,
                @"Cortex-M7" = 0xc27,
                @"Cortex-M0+" = 0xc60,
                @"Cortex-A32" = 0xd01,
                @"Cortex-A34" = 0xd02,
                @"Cortex-A53" = 0xd03,
                @"Cortex-A35" = 0xd04,
                @"Cortex-A55" = 0xd05,
                @"Cortex-A65" = 0xd06,
                @"Cortex-A57" = 0xd07,
                @"Cortex-A72" = 0xd08,
                @"Cortex-A73" = 0xd09,
                @"Cortex-A75" = 0xd0a,
                @"Cortex-A76" = 0xd0b,
                @"Neoverse-N1" = 0xd0c,
                @"Cortex-A77" = 0xd0d,
                @"Cortex-A76AE" = 0xd0e,
                @"Cortex-R52" = 0xd13,
                @"Cortex-M23" = 0xd20,
                @"Cortex-M33" = 0xd21,
                @"Neoverse-V1" = 0xd40,
                @"Cortex-A78" = 0xd41,
                @"Cortex-A78AE" = 0xd42,
                @"Cortex-A65AE" = 0xd43,
                @"Cortex-X1" = 0xd44,
                @"Cortex-A510" = 0xd46,
                @"Cortex-A710" = 0xd47,
                @"Cortex-X2" = 0xd48,
                @"Neoverse-N2" = 0xd49,
                @"Neoverse-E1" = 0xd4a,
                @"Cortex-A78C" = 0xd4b,
                @"Cortex-X1C" = 0xd4c,
                @"Cortex-A715" = 0xd4d,
                @"Cortex-X3" = 0xd4e,

                _,
            },

            /// Reads as 0xF
            constant_0xf: u4, // [19:16]

            /// Variant number, the R value in the Rnpn product revision identifier:
            /// 0x2 = Revision 2
            variant: u4, // [23:20]

            /// Implementer code
            implementer: enum(u8) { // [31:24]

                Arm = 0x41,
                Broadcom = 0x42,
                Cavium = 0x43,
                DEC = 0x44,
                Fujitsu = 0x46,
                HiSilicon = 0x48,
                Infineon = 0x49,
                @"Motorola/Freescale" = 0x4d,
                NVIDIA = 0x4e,
                APM = 0x50,
                Qualcomm = 0x51,
                Marvell = 0x56,
                Apple = 0x61,
                Intel = 0x69,
                Ampere = 0xc0,

                _,
            },

            pub fn format(self: @This(), comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
                _ = options;

                const fmt_ok = (fmt.len == 1) and switch (fmt[0]) {
                    'n', 's', 'f' => true,
                    else => false,
                };
                if (!fmt_ok)
                    @compileError(
                        \\Invalid format specifier for Arm CPUID. Legal options are:
                        \\ - 'n': Numeric display as a hexadecimal value
                        \\ - 's': Displays as a string representation
                        \\ - 'f': Displays as separate fields
                    );

                switch (fmt[0]) {
                    's' => {
                        try writer.print("{s} {s} {d}n{d}n", .{
                            @tagName(self.implementer),
                            @tagName(self.part_number),
                            self.variant,
                            self.revision,
                        });
                    },
                    'n' => {
                        try writer.print("CPUID(0x{X:0>8})", .{@as(u32, @bitCast(self))});
                    },
                    'f' => {
                        try writer.print("CPUID()", .{
                            self.implementer,
                            self.part_number,
                            self.variant,
                            self.revision,
                        });
                    },

                    else => unreachable,
                }
            }
        }, .{ .access = .read_only });

        /// Interrupt Control and State Register
        ///
        /// The ICSR:
        ///     provides:
        ///         - a set-pending bit for the Non-Maskable Interrupt (NMI) exception
        ///         - set-pending and clear-pending bits for the PendSV and SysTick exceptions
        ///     indicates:
        ///         - the exception number of the exception being processed
        ///         - whether there are preempted active exceptions
        ///         - the exception number of the highest priority pending exception
        ///         - whether any interrupts are pending.
        ///
        pub const icsr = mmioRegister(0xE000ED04, packed struct(u32) {
            /// Contains the active exception number:
            ///
            /// 0 = Thread mode
            ///
            /// Nonzero = The exception number of the currently active exception.
            ///
            /// NOTE: Subtract 16 from this value to obtain the CMSIS IRQ number required to index into the Interrupt Clear-Enable, Set-Enable, Clear-Pending, Set-Pending, or Priority Registers, see Table 2.5.
            ///
            /// NOTE: This is the same value as IPSR bits[8:0], see Interrupt Program Status Register.
            VECTACTIVE: u9, // [8:0], RO

            /// Reserved.
            _reserved4: u2, // [10:9], -

            /// Indicates whether there are preempted active exceptions:
            ///
            /// 0 = there are preempted active exceptions to execute
            /// 1 = there are no active exceptions, or the currently-executing exception is the only active exception.
            RETTOBASE: u1, // [11], RO

            /// Indicates the exception number of the highest priority pending enabled exception:
            ///
            /// 0 = no pending exceptions
            ///
            /// Nonzero = the exception number of the highest priority pending enabled exception.
            ///
            /// The value indicated by this field includes the effect of the BASEPRI and FAULTMASK registers, but not any effect of the PRIMASK register.
            VECTPENDING: u6, // [17:12], RO

            /// Reserved.
            _reserved3: u4, // [21:18], -

            /// Interrupt pending flag, excluding NMI and Faults:
            ///
            /// 0 = interrupt not pending
            /// 1 = interrupt pending.
            ISRPENDING: u1, // [22], RO

            /// This bit is reserved for Debug use and reads-as-zero when the processor is not in Debug.
            _reserved2: u1, // [23], RO

            /// Reserved.
            _reserved1: u1, // [24], -

            /// SysTick exception clear-pending bit.
            ///
            /// Write:
            ///
            /// 0 = no effect
            /// 1 = removes the pending state from the SysTick exception.
            ///
            /// This bit is WO. On a register read its value is Unknown.
            PENDSTCLR: u1, // [25], WO

            /// SysTick exception set-pending bit.
            ///
            /// Write:
            ///     0 = no effect
            ///     1 = changes SysTick exception state to pending.
            ///
            /// Read:
            ///     0 = SysTick exception is not pending
            ///     1 = SysTick exception is pending.
            PENDSTSET: u1, // [26], RW

            /// PendSV clear-pending bit.
            ///
            /// Write:
            ///     0 = no effect
            ///     1 = removes the pending state from the PendSV exception.
            PENDSVCLR: u1, // [27], WO

            /// PendSV set-pending bit.
            ///
            /// Write:
            ///     0 = no effect
            ///     1 = changes PendSV exception state to pending.
            ///
            /// Read:
            ///     0 = PendSV exception is not pending
            ///     1 = PendSV exception is pending.
            ///
            /// Writing 1 to this bit is the only way to set the PendSV exception state to pending.
            PENDSVSET: u1, // [28], RW

            /// Reserved.
            _reserved0: u2, // [30:29], -

            /// NMI set-pending bit.
            ///
            /// Write:
            ///     0 = no effect
            ///     1 = changes NMI exception state to pending.
            /// Read:
            ///     0 = NMI exception is not pending
            ///     1 = NMI exception is pending.
            ///
            /// Because NMI is the highest-priority exception, normally the processor enter the NMI exception handler as soon as it registers a write of 1 to this bit, and entering the handler clears this bit to 0. A read of this bit by the NMI exception handler returns 1 only if the NMI signal is reasserted while the processor is executing that handler.
            NMIPENDSET: u1, // [31], RW
        }, .{});

        /// Vector Table Offset Register
        pub const vtor = mmioRegister(0xE000ED08, packed struct(u32) {
            /// Reserved.
            _reserved0: u7 = 0, // [6:0], RW

            /// Vector table base offset field. It contains bits[29:7] of the offset of the table base from the bottom of the memory map.
            /// Note
            /// Bit[29] determines whether the vector table is in the code or SRAM memory region:
            /// 0 = code
            /// 1 = SRAM.
            /// In implementations bit[29] is sometimes called the TBLBASE bit.
            table_offset: u25, // [31:7], RW
        }, .{});

        /// Application Interrupt and Reset Control Register
        pub const aircr = mmioRegister(0xE000ED0C, packed struct(u32) {
            /// Reserved for Debug use. This bit reads as 0. When writing to the register you must write 0 to this bit, otherwise behavior is Unpredictable.
            VECTRESET: u1, // [0], WO

            /// Reserved for Debug use. This bit reads as 0. When writing to the register you must write 0 to this bit, otherwise behavior is Unpredictable.
            VECTCLRACTIVE: u1, // [1], WO

            /// System reset request bit is implementation defined:
            /// 0 = no system reset request
            /// 1 = asserts a signal to the outer system that requests a reset.
            /// This is intended to force a large system reset of all major components except for debug.
            /// This bit reads as 0.
            /// See you vendor documentation for more information about the use of this signal in your implementation.
            SYSRESETREQ: u1, // [2], WO

            /// Reserved.
            _reserved1: u5, // [7:3], -

            /// Interrupt priority grouping field is implementation defined. This field determines the split of group priority from subpriority, see Binary point.
            ///     PRIGROUP    Binary point    Group priority bits     Subpriority bits    Group priorities    Subpriorities
            ///     0b000       bxxxxxxx.y      [7:1]                   [0]                 128                 2
            ///     0b001       bxxxxxx.yy      [7:2]                   [1:0]               64                  4
            ///     0b010       bxxxxx.yyy      [7:3]                   [2:0]               32                  8
            ///     0b011       bxxxx.yyyy      [7:4]                   [3:0]               16                  16
            ///     0b100       bxxx.yyyyy      [7:5]                   [4:0]               8                   32
            ///     0b101       bxx.yyyyyy      [7:6]                   [5:0]               4                   64
            ///     0b110       bx.yyyyyyy      [7]                     [6:0]               2                   128
            ///     0b111       b.yyyyyyyy      None                    [7:0]               1                   256
            PRIGROUP: u3, // [10:8], R/W

            /// Reserved
            _reserved0: u4, // [14:11], -

            /// Data endianness bit is implementation defined:
            /// 0 = Little-endian
            /// 1 = Big-endian.
            ENDIANNESS: u1, // [15], RO

            /// Register key:
            /// Reads as 0xFA05
            /// On writes, write 0x5FA to VECTKEY, otherwise the write is ignored.
            VECTKEY: u16, // [31:16], RW
        }, .{});

        /// System Control Register
        pub const scr = mmioRegister(0xE000ED10, packed struct(u32) {
            /// Reserved.
            _reserved2: u1, // [0], RW

            /// Indicates sleep-on-exit when returning from Handler mode to Thread mode:
            /// 0 = do not sleep when returning to Thread mode
            /// 1 = enter sleep, or deep sleep, on return from an ISR.
            /// Setting this bit to 1 enables an interrupt driven application to avoid returning to an empty main application.
            sleep_on_exit: u1, // [1], RW

            /// Controls whether the processor uses sleep or deep sleep as its low power mode:
            /// 0 = sleep
            /// 1 = deep sleep.
            deep_sleep_enabled: u1, // [2], RW

            /// Reserved.
            _reserved1: u1, // [3], RW

            /// Send Event on Pending bit:
            /// 0 = only enabled interrupts or events can wakeup the processor, disabled interrupts are excluded1 = enabled events and all interrupts, including disabled interrupts, can wakeup the processor.
            /// When an event or interrupt enters pending state, the event signal wakes up the processor from WFE. If the processor is not waiting for an event, the event is registered and affects the next WFE.
            /// The processor also wakes up on execution of an SEV instruction or an external event.
            sevonpend: u1, // [4], RW

            /// Reserved.
            _reserved0: u27, // [31:5], RW
        }, .{});

        /// Configuration and Control Register
        pub const ccr = mmioRegister(0xE000ED14, packed struct(u32) {
            /// Indicates how the processor enters Thread mode:
            /// 0 = processor can enter Thread mode only when no exception is active
            /// 1 = processor can enter Thread mode from any level under the control of an EXC_RETURN value, see Exception return.
            nonbasethrdena: u1, // [0], RW

            /// Enables unprivileged software access to the STIR, see Software Trigger Interrupt Register:
            /// 0 = disable
            /// 1 = enable.
            enable_stir_user_access: u1, // [1], RW

            /// Reserved.
            _reserved2: u1, // [2], RW

            /// Enables unaligned access traps:
            /// 0 = do not trap unaligned halfword and word accesses
            /// 1 = trap unaligned halfword and word accesses.
            /// If this bit is set to 1, an unaligned access generates a UsageFault.
            /// Unaligned LDM, STM, LDRD, and STRD instructions always fault irrespective of whether UNALIGN_TRP is set to 1.
            trap_on_unaligned: bool, // [3], RW

            /// Enables faulting or halting when the processor executes an SDIV or UDIV instruction with a divisor of 0:
            /// 0 = do not trap divide by 0
            /// 1 = trap divide by 0.
            /// When this bit is set to 0, a divide by zero returns a quotient of 0.
            trap_on_div0: bool, // [4], RW

            /// Reserved.
            _reserved1: u3, // [7:5], RW

            /// Enables handlers with priority -1 or -2 to ignore data BusFaults caused by load and store instructions. This applies to the hard fault, NMI, and FAULTMASK escalated handlers:
            /// 0 = data bus faults caused by load and store instructions cause a lock-up
            /// 1 = handlers running at priority -1 and -2 ignore data bus faults caused by load and store instructions.
            /// Set this bit to 1 only when the handler and its data are in absolutely safe memory. The normal use of this bit is to probe system devices and bridges to detect control path problems and fix them.
            bfhfnmign: u1, // [8], RW

            /// Indicates stack alignment on exception entry:
            /// 0 = 4-byte aligned
            /// 1 = 8-byte aligned.
            /// On exception entry, the processor uses bit[9] of the stacked PSR to indicate the stack alignment. On return from the exception it uses this stacked bit to restore the correct stack alignment.
            stack_alignment: enum(u1) { // [9], RW
                @"4 byte" = 0,
                @"8 byte" = 1,
            },

            /// Reserved.
            _reserved0: u22, // [31:10], RW
        }, .{});

        /// System Handler Priority Register 1
        pub const shpr1 = mmioRegister(0xE000ED18, packed struct(u32) {
            /// Priority of system handler 4, MemManage
            mem_manage_priority: u8, // [7:0], RW

            /// Priority of system handler 5, BusFault
            bus_fault_priority: u8, // [15:8], RW

            /// Priority of system handler 6, UsageFault
            usage_fault_priority: u8, // [23:16], RW

            /// Reserved
            PRI_7: u8, // [31:24], RW
        }, .{});

        /// System Handler Priority Register 2
        pub const shpr2 = mmioRegister(0xE000ED1C, packed struct(u32) {
            /// Reserved
            _reserved0: u24, // [23:0], RW

            /// Priority of system handler 11, SVCall
            svcall_priority: u8, // [31:24], RW
        }, .{});

        /// System Handler Priority Register 3
        pub const shpr3 = mmioRegister(0xE000ED20, packed struct(u32) {
            /// Reserved
            _reserved0: u16, // [15:0], RW

            /// Priority of system handler 14, PendSV
            pendsv_priority: u8, // [23:16], RW

            /// Priority of system handler 15, SysTick exception
            systick_priority: u8, // [31:24], RW
        }, .{});

        /// System Handler Control and State Register
        pub const shcrs = mmioRegister(0xE000ED24, packed struct(u32) {
            /// MemManage exception active bit, reads as 1 if exception is active
            memfault_active: bool, // [0], RW

            /// BusFault exception active bit, reads as 1 if exception is active
            busfault_active: bool, // [1], RW

            /// Reserved
            _reserved3: u1, // [2], RW

            /// UsageFault exception active bit, reads as 1 if exception is active
            usagefault_active: bool, // [3], RW

            /// Reserved
            _reserved2: u3, // [6:4], RW

            /// SVCall active bit, reads as 1 if SVC call is active
            svcall_active: bool, // [7], RW

            /// Debug monitor active bit, reads as 1 if Debug monitor is active
            monitor_active: bool, // [8], RW

            /// Reserved
            _reserved1: u1, // [9], RW

            /// PendSV exception active bit, reads as 1 if exception is active
            pendsv_active: bool, // [10], RW

            /// SysTick exception active bit, reads as 1 if exception is active [c]
            systick_active: bool, // [11], RW

            /// UsageFault exception pending bit, reads as 1 if exception is pending [b]
            usagefault_pending: u1, // [12], RW

            /// MemManage exception pending bit, reads as 1 if exception is pending [b]
            memmanage_pending: u1, // [13], RW

            /// BusFault exception pending bit, reads as 1 if exception is pending [b]
            busfault_pending: bool, // [14], RW

            /// SVCall pending bit, reads as 1 if exception is pending [b]
            svcall_pending: bool, // [15], RW

            /// MemManage enable bit, set to 1 to enable [a]
            memfault_enabled: bool, // [16], RW

            /// BusFault enable bit, set to 1 to enable [a]
            busfault_enabled: bool, // [17], RW

            /// UsageFault enable bit, set to 1 to enable [a]
            usagefault_enabled: bool, // [18], RW

            /// Reserved
            _reserved0: u13, // [31:19], RW
        }, .{});

        /// MemManage Fault Status Register
        pub const MMFSR = packed struct(u8) {
            /// Instruction access violation flag:
            ///     0 = no instruction access violation fault
            ///     1 = the processor attempted an instruction fetch from a location that does not permit execution.
            /// This fault occurs on any access to an XN region, even when the MPU is disabled or not present.
            /// When this bit is 1, the PC value stacked for the exception return points to the faulting instruction. The processor has not written a fault address to the MMAR.
            IACCVIOL: u1, // [0], RW

            /// Data access violation flag:
            ///     0 = no data access violation fault
            ///     1 = the processor attempted a load or store at a location that does not permit the operation.
            /// When this bit is 1, the PC value stacked for the exception return points to the faulting instruction. The processor has loaded the MMAR with the address of the attempted access.
            DACCVIOL: u1, // [1], RW

            /// Reserved
            _reserved1: u1, // [2], RW

            /// MemManage fault on unstacking for a return from exception:
            ///     0 = no unstacking fault
            ///     1 = unstack for an exception return has caused one or more access violations.
            /// This fault is chained to the handler. This means that when this bit is 1, the original return stack is still present. The processor has not adjusted the SP from the failing return, and has not performed a new save. The processor has not written a fault address to the MMAR.
            MUNSTKERR: u1, // [3], RW

            /// MemManage fault on stacking for exception entry:
            ///     0 = no stacking fault
            ///     1 = stacking for an exception entry has caused one or more access violations.
            /// When this bit is 1, the SP is still adjusted but the values in the context area on the stack might be incorrect. The processor has not written a fault address to the MMAR.
            MSTKERR: u1, // [4], RW

            /// Reserved.
            _reserved0: u2, // [6:5], RW

            /// MemManage Fault Address Register (MMFAR) valid flag:
            ///     0 = value in MMAR is not a valid fault address
            ///     1 = MMAR holds a valid fault address.
            /// If a MemManage fault occurs and is escalated to a HardFault because of priority, the HardFault handler must set this bit to 0. This prevents problems on return to a stacked active MemManage fault handler whose MMAR value has been overwritten.
            MMARVALID: u1, // [7], RW
        };

        /// BusFault Status Register
        pub const BFSR = packed struct(u8) {
            /// Instruction bus error:
            ///     0 = no instruction bus error
            ///     1 = instruction bus error.
            /// The processor detects the instruction bus error on prefetching an instruction, but it sets the IBUSERR flag to 1 only if it attempts to issue the faulting instruction.
            /// When the processor sets this bit is 1, it does not write a fault address to the BFAR.
            instruction_bus_error: bool, // [0], RW

            /// Precise data bus error:
            ///     0 = no precise data bus error
            ///     1 = a data bus error has occurred, and the PC value stacked for the exception return points to the instruction that caused the fault.
            /// When the processor sets this bit is 1, it writes the faulting address to the BFAR.
            precice_data_bus_error: bool, // [1], RW

            /// Imprecise data bus error:
            ///     0 = no imprecise data bus error
            ///     1 = a data bus error has occurred, but the return address in the stack frame is not related to the instruction that caused the error.
            /// When the processor sets this bit to 1, it does not write a fault address to the BFAR.
            /// This is an asynchronous fault. Therefore, if it is detected when the priority of the current process is higher than the BusFault priority, the BusFault becomes pending and becomes active only when the processor returns from all higher priority processes. If a precise fault occurs before the processor enters the handler for the imprecise BusFault, the handler detects both IMPRECISERR set to 1 and one of the precise fault status bits set to 1.
            imprecice_data_bus_error: bool, // [2], RW

            /// BusFault on unstacking for a return from exception:
            ///     0 = no unstacking fault
            ///     1 = unstack for an exception return has caused one or more BusFaults.
            /// This fault is chained to the handler. This means that when the processor sets this bit to 1, the original return stack is still present. The processor does not adjust the SP from the failing return, does not performed a new save, and does not write a fault address to the BFAR.
            unstacking_exception_error: bool, // [3], RW

            /// BusFault on stacking for exception entry:
            ///     0 = no stacking fault
            ///     1 = stacking for an exception entry has caused one or more BusFaults.
            /// When the processor sets this bit to 1, the SP is still adjusted but the values in the context area on the stack might be incorrect. The processor does not write a fault address to the BFAR.
            exception_stacking_error: bool, // [4], RW

            /// Reserved.
            _reserved0: u2, // [6:5], RW

            /// BusFault Address Register (BFAR) valid flag:
            ///     0 = value in BFAR is not a valid fault address
            ///     1 = BFAR holds a valid fault address.
            /// The processor sets this bit to 1 after a BusFault where the address is known. Other faults can set this bit to 0, such as a MemManage fault occurring later.
            /// If a BusFault occurs and is escalated to a hard fault because of priority, the hard fault handler must set this bit to 0. This prevents problems if returning to a stacked active BusFault handler whose BFAR value has been overwritten.
            busfault_address_register_valid: bool, // [7], RW

        };

        pub const UFSR = packed struct(u16) {
            /// Undefined instruction UsageFault:
            /// 0 = no undefined instruction UsageFault
            /// 1 = the processor has attempted to execute an undefined instruction.
            /// When this bit is set to 1, the PC value stacked for the exception return points to the undefined instruction.
            /// An undefined instruction is an instruction that the processor cannot decode.
            undefined_instruction: bool, // [0], RW

            /// Invalid state UsageFault:
            /// 0 = no invalid state UsageFault
            /// 1 = the processor has attempted to execute an instruction that makes illegal use of the EPSR.
            /// When this bit is set to 1, the PC value stacked for the exception return points to the instruction that attempted the illegal use of the EPSR.
            /// This bit is not set to 1 if an undefined instruction uses the EPSR.
            invalid_state: bool, // [1], RW

            /// Invalid PC load UsageFault, caused by an invalid PC load by EXC_RETURN:
            /// 0 = no invalid PC load UsageFault
            /// 1 = the processor has attempted an illegal load of EXC_RETURN to the PC, as a result of an invalid context, or an invalid EXC_RETURN value.
            /// When this bit is set to 1, the PC value stacked for the exception return points to the instruction that tried to perform the illegal load of the PC.
            invalid_pc_load: bool, // [2], RW

            /// No coprocessor UsageFault. The processor does not support coprocessor instructions:
            /// 0 = no UsageFault caused by attempting to access a coprocessor
            /// 1 = the processor has attempted to access a coprocessor.
            missing_coprocessor_usage: bool, // [3], RW

            /// Reserved.
            _reserved1: u4, // [7:4], RW

            /// Unaligned access UsageFault:
            /// 0 = no unaligned access fault, or unaligned access trapping not enabled
            /// 1 = the processor has made an unaligned memory access.
            /// Enable trapping of unaligned accesses by setting the UNALIGN_TRP bit in the CCR to 1, see Configuration and Control Register.
            /// Unaligned LDM, STM, LDRD, and STRD instructions always fault irrespective of the setting of UNALIGN_TRP.
            unaligned_memory_access: bool, // [8], RW

            /// Divide by zero UsageFault:
            /// 0 = no divide by zero fault, or divide by zero trapping not enabled
            /// 1 = the processor has executed an SDIV or UDIV instruction with a divisor of 0.
            /// When the processor sets this bit to 1, the PC value stacked for the exception return points to the instruction that performed the divide by zero.
            /// Enable trapping of divide by zero by setting the DIV_0_TRP bit in the CCR to 1, see Configuration and Control Register.
            divide_by_zero: bool, // [9], RW

            /// Reserved.
            _reserved0: u6, // [15:10], RW
        };

        /// Configurable Fault Status Register
        pub const cfsr = mmioRegister(0xE000ED28, packed struct(u32) {
            mmsr: MMFSR, // [7:0]
            bfsr: BFSR, // [15:8]
            ufsr: UFSR, // [31:16]
        }, .{});

        /// MemManage Fault Status Register
        pub const mmfsr = mmioRegister(0xE000ED28, MMFSR, .{});

        /// BusFault Status Register
        pub const bfsr = mmioRegister(0xE000ED29, BFSR, .{});

        /// UsageFault Status Register
        pub const ufsr = mmioRegister(0xE000ED2A, UFSR, .{});

        /// HardFault Status Register
        pub const hfsr = mmioRegister(0xE000ED2C, packed struct(u32) {
            /// Reserved.
            _reserved1: u1, // [0], RW

            /// Indicates a BusFault on a vector table read during exception processing:
            /// 0 = no BusFault on vector table read
            /// 1 = BusFault on vector table read.
            /// This error is always handled by the hard fault handler.
            /// When this bit is set to 1, the PC value stacked for the exception return points to the instruction that was preempted by the exception.
            VECTTBL: u1, // [1], RW

            /// Reserved.
            _reserved0: u28, // [29:2], RW

            /// Indicates a forced hard fault, generated by escalation of a fault with configurable priority that cannot be handles, either because of priority or because it is disabled:
            /// 0 = no forced HardFault
            /// 1 = forced HardFault.
            /// When this bit is set to 1, the HardFault handler must read the other fault status registers to find the cause of the fault.
            FORCED: u1, // [30], RW

            /// Reserved for Debug use. When writing to the register you must write 0 to this bit, otherwise behavior is Unpredictable.
            DEBUGEVT: u1, // [31], RW
        }, .{});

        /// MemManage Fault Address Register
        pub const mmar = mmioRegister(0xE000ED34, packed struct(u32) {
            /// When the MMARVALID bit of the MMFSR is set to 1, this field holds the address of the location that generated the MemManage fault
            ADDRESS: u32, // [31:0], RW
        }, .{});

        /// BusFault Address Register
        pub const bfar = mmioRegister(0xE000ED38, packed struct(u32) {
            /// When the BFARVALID bit of the BFSR is set to 1, this field holds the address of the location that generated the BusFault
            ADDRESS: u32, // [31:0], RW
        }, .{});

        /// Auxiliary Fault Status Register
        pub const afsr = mmioRegister(0xE000ED3C, packed struct(u32) {
            /// Implementation defined. The bits map to the AUXFAULT input signals.
            IMPDEF: u32, // [31:0], RW
        }, .{});
    };

    /// https://developer.arm.com/documentation/dui0552/a/cortex-m3-peripherals/nested-vectored-interrupt-controller?lang=en
    pub const nvic = struct {
        // Address                  Name                    Type    Required privilege      Reset value     Description
        // 0xE000E100-0xE000E11C    NVIC_ISER0-NVIC_ISER7   RW      Privileged              0x00000000      Interrupt Set-enable Registers
        // 0XE000E180-0xE000E19C    NVIC_ICER0-NVIC_ICER7   RW      Privileged              0x00000000      Interrupt Clear-enable Registers
        // 0XE000E200-0xE000E21C    NVIC_ISPR0-NVIC_ISPR7   RW      Privileged              0x00000000      Interrupt Set-pending Registers
        // 0XE000E280-0xE000E29C    NVIC_ICPR0-NVIC_ICPR7   RW      Privileged              0x00000000      Interrupt Clear-pending Registers
        // 0xE000E300-0xE000E31C    NVIC_IABR0-NVIC_IABR7   RW      Privileged              0x00000000      Interrupt Active Bit Registers
        // 0xE000E400-0xE000E4EF    NVIC_IPR0-NVIC_IPR59    RW      Privileged              0x00000000      Interrupt Priority Registers
        // 0xE000EF00               STIR                    WO      Configurable [a]        0x00000000      Software Trigger Interrupt Register

        /// Interrupt Set-enable Registers
        ///
        /// Each 1-bit written enables the associated IRQ.
        /// Reading returns if the interrupt is enabled (1) or not (0).
        ///
        /// NOTE: Each bit in the array corresponds to an IRQ.
        pub const iser: *volatile [8]u32 = @ptrFromInt(0xE000E100);

        /// Interrupt Clear-enable Registers
        ///
        /// Each 1-bit written disables the associated IRQ.
        /// Reading returns if the interrupt is enabled (1) or not (0).
        ///
        /// NOTE: Each bit in the array corresponds to an IRQ.
        pub const icer: *volatile [8]u32 = @ptrFromInt(0xE000E180);

        /// Interrupt Set-pending Registers
        ///
        /// Each 1-bit written sets the associated IRQ as pending.
        /// Reading returns if the interrupt is pending (1) or not (0).
        ///
        /// NOTE: Each bit in the array corresponds to an IRQ.
        pub const ispr: *volatile [8]u32 = @ptrFromInt(0xE000E200);

        /// Interrupt Clear-pending Registers
        ///
        /// Each 1-bit written sets the associated IRQ as non-pending.
        /// Reading returns if the interrupt is pending (1) or not (0).
        ///
        /// NOTE: Each bit in the array corresponds to an IRQ.
        pub const icpr: *volatile [8]u32 = @ptrFromInt(0xE000E280);

        /// Interrupt Active Bit Registers
        ///
        /// Each bit marks the interrupt as active or not.
        ///
        /// NOTE: Each bit in the array corresponds to an IRQ.
        pub const iabr: *volatile [8]u32 = @ptrFromInt(0xE000E300);

        /// Interrupt Priority Registers
        ///
        /// Each implementation-defined priority field can hold a priority value, 0-255. The lower the value, the greater the priority of the corresponding interrupt. Register priority value fields are 8 bits wide, and un-implemented low-order bits read as zero and ignore writes.
        /// Find the IPR number and byte offset for interrupt m as follows:
        ///
        ///     the corresponding IPR number, see Table 4.8 n is given by n = m DIV 4
        ///     the byte offset of the required Priority field in this register is m MOD 4, where:
        ///         byte offset 0 refers to register bits[7:0]
        ///         byte offset 1 refers to register bits[15:8]
        ///         byte offset 2 refers to register bits[23:16]
        ///         byte offset 3 refers to register bits[31:24].
        ///
        /// NOTE: Each byte in the array corresponds to an IRQ.
        pub const ipr: *volatile [60]u32 = @ptrFromInt(0xE000E400);

        /// Software Trigger Interrupt Register
        ///
        /// Write to the STIR to generate an interrupt from software.
        ///
        /// When the USERSETMPEND bit in the SCR is set to 1, unprivileged software can access the STIR, see System Control Register .
        pub const stir = mmioRegister(0xE000EF00, packed struct(u32) {
            /// Interrupt ID of the interrupt to trigger, in the range 0-239. For example, a value of 0x03 specifies interrupt IRQ3.
            intterrupt_id: u9, // [8:0]

            _reserved: u23, // [31:9]
        }, .{ .access = .write_only });
    };

    pub const sys_tick = struct {

        // 0xE000E010 SYST_CSR    RW  Privileged  SysTick Control and Status Register
        // 0xE000E014 SYST_RVR    RW  Privileged  SysTick Reload Value Register
        // 0xE000E018 SYST_CVR    RW  Privileged  SysTick Current Value Register
        // 0xE000E01C SYST_CALIB  RO  Privileged  SysTick Calibration Value Register

        /// SysTick Control and Status Register
        ///
        /// The SysTick CSR register enables the SysTick features.
        ///
        /// The register resets to 0x00000000, or to 0x00000004 if your device does not implement a reference clock.
        ///
        /// When ENABLE is set to 1, the counter loads the RELOAD value from the SYST_RVR register and then counts down. On reaching 0, it sets the COUNTFLAG to 1 and optionally asserts the SysTick depending on the value of TICKINT. It then loads the RELOAD value again, and begins counting.
        pub const csr = mmioRegister(0xE000E010, packed struct(u32) {
            enabled: bool, // [0]
            interrupt: enum(u1) { // [1]
                /// 0 = counting down to zero does not assert the SysTick exception request
                disabled = 0,

                /// 1 = counting down to zero asserts the SysTick exception request.
                /// Software can use `count_flag` to determine if SysTick has ever counted to zero.
                enabled = 1,
            },
            clock_source: enum(u1) { // [2]
                external_clock = 0,
                processor_clock = 1,
            },

            _reserved0: u13, // [15:3]

            /// Returns `true` if timer counted to 0 since last time this was read.
            count_flag: bool, // [16]

            _reserved1: u15, // [31:17]
        }, .{});

        /// SysTick Reload Value Register
        ///
        /// The SYST_RVR register specifies the start value to load into the SYST_CVR register.
        ///
        /// ## Calculating the `reload` value
        ///
        /// The `reload` value can be any value in the range 0x00000001-0x00FFFFFF. A start value of 0 is possible, but has no effect because the SysTick exception request and COUNTFLAG are activated when counting from 1 to 0.
        ///
        /// The `reload` value is calculated according to its use. For example, to generate a multi-shot timer with a period of N processor clock cycles, use a RELOAD value of N-1. If the SysTick interrupt is required every 100 clock pulses, set RELOAD to 99.
        pub const rvr = mmioRegister(0xE000E014, packed struct(u32) {
            /// Value to load into the CVR register when the counter is enabled and when it reaches 0.
            reload: u24, // [23:0]

            _reserved: u8 = 0, // [31:24]
        }, .{});

        /// SysTick Current Value Register
        ///
        /// The SYST_CVR register contains the current value of the SysTick counter.
        ///
        /// A write of any value clears the field to 0, and also clears the `CSR.count_flag` bit to 0.
        pub const cvr = mmioRegister(0xE000E018, packed struct(u32) {
            /// Return the current value of the SysTick counter.
            current: u24, // [23:0]

            _reserved: u8 = 0, // [31:24]
        }, .{});

        /// SysTick Calibration Value Register
        ///
        /// The SYST_CALIB register indicates the SysTick calibration properties.The reset value of this register is implementation-defined. See the documentation supplied by your device vendor for more information about the meaning of the SYST_CALIB field values.
        ///
        /// If calibration information is not known, calculate the calibration value required from the frequency of the processor clock or external clock.
        pub const calib = mmioRegister(0xE000E01C, packed struct(u32) {
            /// Reload value for 10ms (100Hz) timing, subject to system clock skew errors. If the value reads as zero, the calibration value is not known.
            ten_ms: u24, // [23:0]

            _reserved: u6, // [29:24]

            /// Indicates whether the TENMS value is exact
            skew: enum(u1) { // [30]
                /// 0 = `ten_ms` value is exact
                exact = 0,

                /// 1 = TENMS value is inexact, or not given.
                /// An inexact TENMS value can affect the suitability of SysTick as a software real time clock.
                inexact_or_missing = 1,
            },

            ///Indicates whether the device provides a reference clock to the processor:
            ///
            /// `false` = reference clock provided
            ///
            /// `true` = no reference clock provided
            ///
            /// If your device does not provide a reference clock, the SYST_CSR.CLKSOURCE bit reads-as-one and ignores writes.
            no_reference_clock: bool,
        }, .{ .access = .read_only });
    };

    pub const mpu = struct {
        // 0xE000ED90  MPU_TYPE     RO  Privileged  0x00000800  MPU Type Register
        // 0xE000ED94  MPU_CTRL     RW  Privileged  0x00000000  MPU Control Register
        // 0xE000ED98  MPU_RNR      RW  Privileged  0x00000000  MPU Region Number Register
        // 0xE000ED9C  MPU_RBAR     RW  Privileged  0x00000000  MPU Region Base Address Register
        // 0xE000EDA0  MPU_RASR     RW  Privileged  0x00000000  MPU Region Attribute and Size Register
        // 0xE000EDA4  MPU_RBAR_A1  RW  Privileged  0x00000000  Alias of RBAR, see MPU Region Base Address Register
        // 0xE000EDA8  MPU_RASR_A1  RW  Privileged  0x00000000  Alias of RASR, see MPU Region Attribute and Size Register
        // 0xE000EDAC  MPU_RBAR_A2  RW  Privileged  0x00000000  Alias of RBAR, see MPU Region Base Address Register
        // 0xE000EDB0  MPU_RASR_A2  RW  Privileged  0x00000000  Alias of RASR, see MPU Region Attribute and Size Register
        // 0xE000EDB4  MPU_RBAR_A3  RW  Privileged  0x00000000  Alias of RBAR, see MPU Region Base Address Register
        // 0xE000EDB8  MPU_RASR_A3  RW  Privileged  0x00000000  Alias of RASR, see MPU Region Attribute and Size Register

        /// MPU Type Register
        const @"type" = mmioRegister(0xE000ED90, packed struct(u32) {
            /// Indicates support for unified or separate instruction and date memory maps:
            /// 0 = unified.
            separate: bool, // [0]

            _reserved0: u7, // [7:1]

            /// Indicates the number of supported MPU data regions:
            /// 0x08 = eight MPU regions.
            data_region_count: u8, // [15:8]

            /// Indicates the number of supported MPU instruction regions.
            /// Always contains 0x00. The MPU memory map is unified and is described by the DREGION field.
            instruction_region_count: u8, // [23:16]

            _reserved1: u8, // [31:24]
        }, .{ .access = .read_only });

        /// MPU Control Register
        const ctrl = mmioRegister(0xE000ED94, packed struct(u32) {
            enabled: bool, // [0]

            /// Enables the operation of MPU during hard fault, NMI, and FAULTMASK handlers.
            fault_handler_protection: enum(u1) {
                /// When the MPU is enabled:
                /// 0 = MPU is disabled during hard fault, NMI, and FAULTMASK handlers, regardless of the value of the ENABLE bit
                disabled = 0,

                /// 1 = the MPU is enabled during hard fault, NMI, and FAULTMASK handlers.
                /// When the MPU is disabled, if this bit is set to 1 the behavior is Unpredictable.
                enabled = 1,
            },

            /// Enables privileged software access to the default memory map:
            priviledged_access: enum(u1) {
                /// 0 = If the MPU is enabled, disables use of the default memory map. Any memory access to a location not covered by any enabled region causes a fault.
                mpu_protected = 0,

                /// 1 = If the MPU is enabled, enables use of the default memory map as a background region for privileged software accesses.
                /// When enabled, the background region acts as if it is region number -1. Any region that is defined and enabled has priority over this default map.
                /// If the MPU is disabled, the processor ignores this bit.
                default_memory_map = 1,
            },

            _reserved: u29, // [31:3]
        }, .{});

        /// MPU Region Number Register
        ///
        /// The MPU_RNR selects which memory region is referenced by the MPU_RBAR and MPU_RASR registers.
        ///
        /// Normally, you write the required region number to this register before accessing the MPU_RBAR or MPU_RASR.
        /// However you can change the region number by writing to the MPU RBAR with the VALID bit set to 1, see MPU Region Base Address Register.
        ///
        /// This write updates the value of the REGION field.
        const rnr = mmioRegister(0xE000ED98, packed struct(u32) {
            /// Indicates the MPU region referenced by the MPU_RBAR and MPU_RASR registers.
            ///
            /// The MPU supports 8 memory regions, so the permitted values of this field are 0-7.
            region: u8, // [7:0]

            _reserved: u24, // [31:8]
        }, .{});

        ///  MPU Region Base Address Register
        /// The MPU_RBAR defines the base address of the MPU region selected by the MPU_RNR, and can update the value of the MPU_RNR. See the register summary in Table 4.38 for its attributes.
        ///
        /// Write MPU_RBAR with the VALID bit set to 1 to change the current region number and update the MPU_RNR. The bit assignments are:
        pub const RBAR = MmioRegister(packed struct(u32) {
            /// MPU region field:
            /// For the behavior on writes, see the description of the VALID field.
            ///
            /// On reads, returns the current region number, as specified by the RNR.
            region: u3, // [2:0]

            /// MPU Region Number valid bit:
            ///
            /// Write:
            ///     0 = MPU_RNR not changed, and the processor:
            ///         updates the base address for the region specified in the MPU_RNR
            ///         ignores the value of the REGION field
            ///
            ///     1 = the processor:
            ///         updates the value of the MPU_RNR to the value of the REGION field
            ///         updates the base address for the region specified in the REGION field.
            ///
            /// Always reads as zero.
            valid: bool, // [3]

            /// The ADDR field
            /// The ADDR field is bits[31:N] of the MPU_RBAR. The region size, as specified by the SIZE field in the MPU_RASR, defines the value of N:
            ///
            /// N = Log2(Region size in bytes),
            ///
            /// If the region size is configured to 4GB, in the MPU_RASR, there is no valid ADDR field. In this case, the region occupies the complete memory map, and the base address is 0x00000000.
            ///
            /// The base address is aligned to the size of the region. For example, a 64KB region must be aligned on a multiple of 64KB, for example, at 0x00010000 or 0x00020000.
            address: u28,
        }, .{});

        /// MPU Region Base Address Register
        ///
        /// The MPU_RASR defines the region size and memory attributes of the MPU region specified by the MPU_RNR, and enables that region and any subregions. See the register summary in Table 4.38 for its attributes.
        ///
        /// MPU_RASR is accessible using word or halfword accesses:
        ///
        /// the most significant halfword holds the region attributes
        ///
        /// the least significant halfword holds the region size and the region and subregion enable bits.
        ///
        /// https://developer.arm.com/documentation/dui0552/a/cortex-m3-peripherals/optional-memory-protection-unit/mpu-access-permission-attributes?lang=en
        pub const RASR = MmioRegister(packed struct(u32) {
            enable: bool, // [0]

            /// SIZE field values
            /// The SIZE field defines the size of the MPU memory region specified by the RNR. as follows:
            ///
            /// (Region size in bytes) = 2(SIZE+1)
            ///
            /// The smallest permitted region size is 32B, corresponding to a SIZE value of 4.
            ///
            ///     SIZE value    | Region size | Value of N | Note
            ///     --------------+-------------+------------+-----------------------
            ///     0b00100 (4)   | 32B         | 5          | Minimum permitted size
            ///     0b01001 (9)   | 1KB         | 10         | -
            ///     0b10011 (19)  | 1MB         | 20         | -
            ///     0b11101 (29)  | 1GB         | 30         | -
            ///     0b11111 (31)  | 4GB         | 32         | Maximum possible size
            ///
            size: u5, // [5:1]

            reserved: u2, // [7:6]

            ///Subregion disable bits. For each bit in this field:
            /// 0 = corresponding sub-region is enabled
            /// 1 = corresponding sub-region is disabled.
            ///
            /// See Subregions for more information.
            ///
            /// Region sizes of 128 bytes and less do not support subregions. When writing the attributes for such a region, write the SRD field as 0x00.
            subregion_disabled: u8, // [15:8]

            b: bool, // [16]
            c: bool, // [17]

            /// Shareable bit, see Table 4.45.
            sharable: bool, // [18]

            tex: u3, // [21:19]

            _reserved1: u2, // [23:22]

            /// Access permission field, see Table 4.47.
            access_permissions: AccessPermission, // [26:24]

            _reserved2: u1, // [27]

            ///Instruction access disable bit:
            ///     0 = instruction fetches enabled
            ///     1 = instruction fetches disabled.
            execute_disable: bool,

            _reserved3: u3, // [31:29]
        }, .{});

        /// AP[2:0]     Privileged permissions  Unprivileged permissions    Description
        /// 000         No access               No access                   All accesses generate a permission fault
        /// 001         RW                      No access                   Access from privileged software only
        /// 010         RW                      RO                          Writes by unprivileged software generate a permission fault
        /// 011         RW                      RW                          Full access
        /// 100         Unpredictable           Unpredictable               Reserved
        /// 101         RO                      No access                   Reads by privileged software only
        /// 110         RO                      RO                          Read only, by privileged or unprivileged software
        /// 111         RO                      RO                          Read only, by privileged or unprivileged software
        pub const AccessPermission = enum(u3) {
            no_access = 0b000,
        };

        /// MPU Region Base Address Register
        pub const rbar: *volatile RBAR = @ptrFromInt(0xE000ED9C);

        /// MPU Region Attribute and Size Register
        pub const rbar_a1: *volatile RBAR = @ptrFromInt(0xE000EDA4);

        /// Alias of RBAR, see MPU Region Base Address Register
        pub const rbar_a2: *volatile RBAR = @ptrFromInt(0xE000EDAC);

        /// Alias of RASR, see MPU Region Attribute and Size Register
        pub const rbar_a3: *volatile RBAR = @ptrFromInt(0xE000EDB4);

        /// Alias of RBAR, see MPU Region Base Address Register
        pub const rasr: *volatile RASR = @ptrFromInt(0xE000EDA0);

        /// Alias of RASR, see MPU Region Attribute and Size Register
        pub const rasr_a1: *volatile RASR = @ptrFromInt(0xE000EDA8);

        /// Alias of RBAR, see MPU Region Base Address Register
        pub const rasr_a2: *volatile RASR = @ptrFromInt(0xE000EDB0);

        /// Alias of RASR, see MPU Region Attribute and Size Register
        pub const rasr_a3: *volatile RASR = @ptrFromInt(0xE000EDB8);
    };
};
