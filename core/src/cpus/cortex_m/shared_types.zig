//!
//! This file contains types shared between different CPUs
//!

const builtin = @import("builtin");

pub const CpuFlags = struct {
    has_hard_fault: bool = true,
    has_bus_fault: bool,
    has_usage_fault: bool,
    has_mem_manage_fault: bool,
};

pub const options = struct {
    pub const Basic_Options = struct {
        /// If true, the Cortex-M interrupts will be initialized with a more verbose variant
        /// of the interrupt handlers which print the interrupt name.
        ///
        /// NOTE: This option is enabled in debug builds by default.
        verbose_unhandled_irq: bool = (builtin.mode == .Debug),
    };

    pub const Ram_Vector_Options = struct {
        /// When true, interrupt vectors are moved to RAM so handlers can be set at runtime.
        ram_vectors: bool = false,
        /// When true, the vector table lives in RAM.
        ram_vector_table: bool = false,

        /// If true, the Cortex-M interrupts will be initialized with a more verbose variant
        /// of the interrupt handlers which print the interrupt name.
        ///
        /// NOTE: This option is enabled in debug builds by default.
        verbose_unhandled_irq: bool = (builtin.mode == .Debug),
    };
};

pub const scb = struct {
    pub const SHCSR = packed struct(u32) {
        /// [0]
        /// MemManage exception active bit, reads as 1 if exception is active.
        /// This bit is banked between Security states.
        MEMFAULTACT: u1,

        /// [1]
        /// BusFault exception active bit, reads as 1 if exception is active.
        /// If AIRCR.BFHFNMINS is zero this bit is RAZ/WI from Non-secure state.
        /// This bit is not banked between Security states.
        BUSFAULTACT: u1,

        /// [2]
        /// HardFault exception active bit, reads as 1 if exception is active.
        /// This bit is banked between Security states.
        HARDFAULTACT: u1,

        /// [3]
        /// UsageFault exception active bit, reads as 1 if exception is active.
        /// This bit is banked between Security states.
        USGFAULTACT: u1,

        /// [4]
        /// SecureFault exception active state bit, reads as 1 if exception is active.
        /// This bit is not banked between Security states.
        SECUREFAULTACT: u1,

        /// [5]
        /// NMI exception active state bit, reads as 1 if exception is active.
        /// This bit is not banked between Security states.
        NMIACT: u1,

        /// [6] Reserved, res0.
        _reserved6: u1 = 0,

        /// [7]
        /// SVCall active bit, reads as 1 if SVC call is active.
        /// This bit is banked between Security states.
        SVCALLACT: u1,

        /// [8]
        /// Debug monitor active bit, reads as 1 if Debug monitor is active.
        /// This bit is not banked between Security states.
        MONITORACT: u1,

        /// [9] Reserved, res0.
        _reserved9: u1 = 0,

        /// [10]
        /// PendSV exception active bit, reads as 1 if exception is active.
        /// This bit is banked between Security states.
        PENDSVACT: u1,

        /// [11]
        /// SysTick exception active bit, reads as 1 if exception is active.3
        /// This bit is banked between Security states.
        SYSTICKACT: u1,

        /// [12]
        /// UsageFault exception pending bit, reads as 1 if exception is pending.2
        /// This bit is banked between Security states.
        USGFAULTPENDED: u1,

        /// [13]
        /// MemManage exception pending bit, reads as 1 if exception is pending.2
        /// This bit is banked between Security states.
        MEMFAULTPENDED: u1,

        /// [14]
        /// BusFault exception pending bit, reads as 1 if exception is pending. 2
        /// If AIRCR.BFHFNMINS is zero this bit is RAZ/WI from Non-secure state.
        /// This bit is not banked between Security states.
        BUSFAULTPENDED: u1,

        /// [15]
        /// SVCall pending bit, reads as 1 if exception is pending. 2
        /// This bit is banked between Security states.
        SVCALLPENDED: u1,

        /// [16]
        /// MemManage enable bit, set to 1 to enable. 1
        /// This bit is banked between Security states.
        MEMFAULTENA: u1,

        /// [17]
        /// BusFault enable bit, set to 1 to enable.1
        /// If AIRCR.BFHFNMINS is zero this bit is RAZ/WI from Non-secure state.
        /// This bit is not banked between Security states.
        BUSFAULTENA: u1,

        /// [18]
        /// UsageFault enable bit, set to 1 to enable.1
        /// This bit is banked between Security states.
        USGFAULTENA: u1,

        /// [19]
        /// SecureFault exception enable bit, set to 1 to enable.
        /// This bit is not banked between Security states.
        SECUREFAULTENA: u1,

        /// [20]
        /// SecureFault exception pended state bit, set to 1 to allow exception modification.
        /// This bit is not banked between Security states.
        SECUREFAULTPENDED: u1,

        /// [21]
        /// HardFault exception pended state bit, set to 1 to allow exception modification.
        /// This bit is banked between Security states.
        /// Note
        /// The Non-secure HardFault exception does not preempt if AIRCR.BFHFNMINS is set to zero.
        HARDFAULTPENDED: u1,

        /// [31:22] Reserved, res0.
        _reserved22: u10 = 0,
    };

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

    pub const HFSR = packed struct(u32) {
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
    };
};
