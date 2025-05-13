//! Related documentation:
//! - ARM Cortex-M33 Reference: https://developer.arm.com/documentation/100230/latest/
const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const CPU_Options = struct {
    /// When true, interrupt vectors are moved to RAM so handlers can be set at runtime.
    ram_vectors: bool = false,
    /// When true, the RAM vectors are placed in section `ram_vectors`.
    has_ram_vectors_section: bool = false,
};

pub const scb_base_offset = 0x0cfc;

pub const SystemControlBlock = extern struct {
    /// REVIDR Register.
    REVIDR: u32,
    /// CPUID Base Register.
    CPUID: u32,
    /// Interrupt Control and State Register.
    ICSR: mmio.Mmio(packed struct(u32) {
        /// Contains the active exception number:
        /// 0 = Thread mode
        /// Nonzero = The exception number[a] of the currently active exception.
        VECTACTIVE: u9,
        reserved0: u2 = 0,
        /// Return to base. In Handler mode, indicates whether there is more than one active exception.
        /// 0 = more than one active exception
        /// 1 = only one active exception.
        RETTOBASE: u1,
        /// Indicates the exception number of the highest priority pending enabled exception:
        /// 0 = no pending exceptions
        /// Nonzero = the exception number of the highest priority pending enabled exception.
        VECTPENDING: u9,
        reserved1: u1 = 0,
        /// Interrupt pending flag, excluding NMI and Faults:
        /// 0 = interrupt not pending
        /// 1 = interrupt pending.
        ISRPENDING: u1 = 0,
        /// Indicates whether a pending exception will be serviced on exit from debug
        /// halt state:
        /// 0 = will not be serviced
        /// 1 = will be serviced.
        ISRPREEMPT: u1,
        /// SysTick Targets Non-secure. Controls whether in a single SysTick implementation, the SysTick is Secure or Non-secure.
        /// 0 = Secure
        /// 1 = Non-secure.
        STTNS: u1,
        /// SysTick exception clear-pending bit.
        ///
        /// Write:
        /// 0 = no effect
        /// 1 = removes the pending state from the SysTick exception.
        ///
        /// This bit is WO. On a register read its value is Unknown.
        /// If your device does not implement the SysTick timer, this bit is Reserved.
        PENDSTCLR: u1,
        /// SysTick exception set-pending bit.
        ///
        /// Write:
        /// 0 = no effect1 = changes SysTick exception state to pending.
        /// Read:
        /// 0 = SysTick exception is not pending
        /// 1 = SysTick exception is pending.
        ///
        /// If your device does not implement the SysTick timer, this bit is Reserved.
        PENDSTSET: u1,
        /// PendSV clear-pending bit.
        ///
        /// Write:
        /// 0 = no effect
        /// 1 = removes the pending state from the PendSV exception.
        PENDSVCLR: u1,
        /// PendSV set-pending bit.
        ///
        /// Write:
        /// 0 = no effect
        /// 1 = changes PendSV exception state to pending.
        /// Read:
        /// 0 = PendSV exception is not pending
        /// 1 = PendSV exception is pending.
        ///
        /// Writing 1 to this bit is the only way to set the PendSV exception state to pending.
        PENDSVSET: u1,
        reserved2: u1 = 0,
        /// NMI clear-pending bit.
        ///
        /// Write:
        /// 0 = no effect
        /// 1 = removes the pending state from the NMI exception.
        ///
        /// This bit is WO. On a register read its value is Unknown.
        PENDNMICLR: u1,
        /// NMI set-pending bit.
        ///
        /// Write:
        /// 0 = no effect
        /// 1 = changes NMI exception state to pending.
        /// Read:
        /// 0 = NMI exception is not pending
        /// 1 = NMI exception is pending.
        ///
        /// Because NMI is the highest-priority exception, normally the processor enters the NMI
        /// exception handler as soon as it detects a write of 1 to this bit. Entering the handler
        /// then clears this bit to 0. This means a read of this bit by the NMI exception handler
        /// returns 1 only if the NMI signal is reasserted while the processor is executing that handler.
        NMIPENDSET: u1,
    }),
    /// Vector Table Offset Register.
    VTOR: u32,
    /// Application Interrupt and Reset Control Register.
    AIRCR: mmio.Mmio(packed struct {
        reserved0: u1 = 0,
        /// Reserved for debug use. This bit reads as 0. When writing to the register you must
        /// write 0 to this bit, otherwise behavior is Unpredictable.
        VECTCLRACTIVE: u1,
        /// System reset request:
        /// 0 = no effect
        /// 1 = requests a system level reset.
        ///
        /// This bit reads as 0.
        SYSRESETREQ: u1,
        ///System reset request Secure only. The value of this bit defines whether the SYSRESETREQ bit is functional
        /// in Secure state.
        /// 0 = SYSRESETREQ functionality is available to both Security states.
        /// 1 = SYSRESETREQ functionality is available only in Secure state.
        SYSRESETREQS: u1,
        /// Data Independent Timing. This bit indicates and allows modification of whether for the selected Security
        /// state data independent timing operations are guaranteed to be timing invariant with respect to the data values
        /// being operated on.
        /// 0 = timing is not guaranteed
        /// 1 = timing is guaranteed
        DIT: u1,
        /// Implicit ESB Enable. This bit indicates and allows modification of whether an implicit Error Synchronization
        /// Bit is inserted into the instruction stream.
        /// 0 = No implicit Error Synchronization Bit
        /// 1 = Insert an implicit Error Synchronization Bit
        IESB: u1,
        reserved1: u2 = 0,
        /// Priority grouping. The value of this field defines the exception priority binary point position for the selected
        /// value of PRIS.
        PRIGROUP: u3,
        reserved2: u2 = 0,
        /// BusFault, HardFault, and NMI Non-secure enable. The value of this bit defines whether BusFault and NMI
        /// exceptions are Non-secure, and whether exceptions target the Non-secure HardFault exception.
        /// 0 = BusFault, HardFault, and NMI are Secure
        /// 1 = BusFault and NMI are Non-secure and exceptions can target Non-secure HardFault.
        BFHFNMINS: u1,
        /// Prioritize Secure exceptions. The value of this bit defines whether Secure exception priority boosting is enabled.
        /// 0 = Priority ranges of Secure and Non-secure exceptions are identical
        /// 1 = Secure exceptions have a higher priority than Non-secure exceptions
        PRIS: u1,
        /// Data endianness implemented:
        /// 0 = Little-endian
        /// 1 = Big-endian.
        ENDIANESS: u1,
        /// Register key:
        /// Reads as Unknown
        /// On writes, write 0x05FA to VECTKEY, otherwise the write is ignored.
        VECTKEY: u16,
    }),
    /// System Control Register.
    SCR: mmio.Mmio(packed struct(u32) {
        reserved0: u1 = 0,
        /// Indicates sleep-on-exit when returning from Handler mode to Thread mode:
        /// 0 = do not sleep when returning to Thread mode.
        /// 1 = enter sleep, or deep sleep, on return from an ISR to Thread mode.
        ///
        /// Setting this bit to 1 enables an interrupt driven application to avoid returning
        /// to an empty main application.
        SLEEPONEXIT: u1,
        /// Controls whether the processor uses sleep or deep sleep as its low power mode:
        /// 0 = sleep
        /// 1 = deep sleep.
        ///
        /// If your device does not support two sleep modes, the effect of changing the value
        /// of this bit is implementation-defined.
        SLEEPDEEP: u1,
        /// Sleep deep secure. This field controls whether the SLEEPDEEP bit is only accessible from the Secure state.
        /// 0 = The SLEEPDEEP bit accessible from both Security states.
        /// 1 = The SLEEPDEEP bit behaves as RAZ/WI when accessed from the Non-secure state..
        SLEEPDEEPS: u1,
        /// Send Event on Pending bit:
        /// 0 = only enabled interrupts or events can wakeup the processor, disabled interrupts are excluded
        /// 1 = enabled events and all interrupts, including disabled interrupts, can wakeup the processor.
        ///
        /// When an event or interrupt enters pending state, the event signal wakes up the processor from WFE.
        /// If the processor is not waiting for an event, the event is registered and affects the next WFE.
        ///
        /// The processor also wakes up on execution of an SEV instruction or an external event.
        SEVONPEND: u1,
        reserved1: u27 = 0,
    }),
    /// Configuration and Control Register.
    CCR: mmio.Mmio(packed struct(u32) {
        reserved0: u1 = 0,
        /// User set pending determines if unpriviledged access to the STIR generates a fault.
        USERSETMPEND: u1,
        reserved1: u1 = 0,
        /// Unaligned trap controls trapping of unaligned word and half word accesses.
        UNALIGN_TRP: u1,
        /// Divide by zero trap controls generation of DIVBYZERO usage fault.
        DIV_0_TRP: u1,
        reserved2: u3 = 0,
        /// Determines effect of precise bus faults running on handlers at requested priority less than 0.
        BFHFNMIGN: u1,
        reserved3: u1 = 0,
        /// Controls effect of stack limit violation while executing at a requested priority less than 0.
        STKOFHFNMIGN: u1,
        reserved4: u5 = 0,
        /// Read as zero/write ignored.
        DC: u1,
        /// Read as zero/write ignored.
        IC: u1,
        /// Read as zero/write ignored.
        BP: u1,
        reserved5: u13 = 0,
    }),
    /// System Handler Priority Registers.
    SHPR: [12]u8,
    /// System Handler Control and State Register.
    SHCSR: u32,
    /// Configurable Fault Status Register.
    CFSR: mmio.Mmio(packed struct(u32) {
        /// MemManage Fault Register.
        MMFSR: u8,
        /// BusFault Status Register.
        BFSR: u8,
        /// Usage Fault Status Register.
        UFSR: u16,
    }),
    /// HardFault Status Register.
    HFSR: u32,
    reserved0: u32 = 0,
    /// MemManage Fault Address Register.
    MMFAR: u32,
    /// BusFault Address Register.
    BFAR: u32,
    /// Auxiliary Fault Status Register not implemented.
    _AFSR: u32,
    reserved1: [18]u32,
    /// Coprocessor Access Control Register.
    CPACR: u32,
    /// Non-secure Access Control Register.
    NSACR: u32,
};

pub const NestedVectorInterruptController = extern struct {
    /// Interrupt Set Registers.
    ISER: [16]u32,
    reserved0: [16]u32,
    /// Interrupt Clear Enable Registers.
    ICER: [16]u32,
    reserved1: [16]u32,
    /// Interrupt Set Pending Registers.
    ISPR: [16]u32,
    reserved2: [16]u32,
    /// Interrupt Clear Pending Registers.
    ICPR: [16]u32,
    reserved3: [16]u32,
    /// Interrupt Active Bit Registers.
    IABR: [16]u32,
    reserved4: [16]u32,
    /// Interrupt Target Non-secure Registers.
    ITNS: [16]u32,
    reserved5: [16]u32,
    /// Interrupt Priority Registers.
    IPR: [480]u8,
    reserved6: [584]u32,
    /// Software Trigger Interrupt Register.
    STIR: u32,

    pub fn is_enabled(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        const reg = nvic.ISER[num / 32];
        return reg & (1 << (num % 32)) != 0;
    }

    pub fn enable(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ISER[num / 32] |= 1 << (num % 32);
    }

    pub fn disable(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ICER[num / 32] |= 1 << (num % 32);
    }

    pub fn is_pending(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        return nvic.ISPR[num / 32] & (1 << (num % 32)) != 0;
    }

    pub fn set_pending(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ISPR[num / 32] |= 1 << (num % 32);
    }

    pub fn clear_pending(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ICPR[num / 32] |= 1 << (num % 32);
    }
};

pub const SecurityAttributionUnit = extern struct {
    /// SAU Control Register.
    CTRL: u32,
    /// SAU Type Register.
    TYPE: u32,
    /// SAU Region Number Register.
    RNR: u32,
    /// SAU Region Base Address.
    RBAR: u32,
    /// SAU Region Limit Address.
    RLAR: u32,
    /// Secure Fault Status Register.
    SFSR: u32,
    /// Secure Fault Address Register.
    SFAR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register.
    TYPE: mmio.Mmio(packed struct(u32) {
        /// Indicates support for unified or separate instructions and data address regions.
        SEPARATE: u1,
        reserved0: u7 = 0,
        /// Number of data regions supported by the MPU.
        DREGION: u8,
        reserved1: u16 = 0,
    }),
    /// MPU Control Register.
    CTRL: mmio.Mmio(packed struct(u32) {
        /// Enables the MPU
        ENABLE: u1,
        /// Enables of operation of MPU during HardFault and MNIHandlers.
        HFNMIENA: u1,
        /// Enables priviledged software access to default memory map.
        PRIVDEFENA: u1,
        reserved0: u29 = 0,
    }),
    /// MPU Region Number Register.
    RNR: mmio.Mmio(packed struct(u32) {
        /// Indicates the memory region accessed by MPU RBAR and PMU RLAR.
        REGION: u8,
        reserved0: u24 = 0,
    }),
    /// MPU Region Base Address Register.
    RBAR: RBAR_Register,
    /// MPU Region Limit Address Register.
    RLAR: RLAR_Register,
    /// MPU Region Base Address Register Alias 1.
    RBAR_A1: RBAR_Register,
    /// MPU Region Base Address Register Alias 2.
    RBAR_A2: RBAR_Register,
    /// MPU Region Base Address Register Alias 3.
    RBAR_A3: RBAR_Register,
    /// MPU Region Limit Address Register Alias 1.
    RLAR_A1: RLAR_Register,
    /// MPU Region Base Address Register Alias 2.
    RLAR_A2: RLAR_Register,
    /// MPU Region Base Address Register Alias 3.
    RLAR_A3: RLAR_Register,
    reserved0: [20]u8,
    /// MPU Memory Addribute Indirection Register 0.
    MPU_MAIR0: u32,
    /// MPU Memory Addribute Indirection Register 1.
    MPU_MAIR1: u32,

    /// MPU Region Address Register format.
    pub const RBAR_Register = mmio.Mmio(packed struct(u32) {
        /// Execute Never defines if code can be executed from this region.
        XN: u1,
        /// Access permissions.
        AP: u2,
        /// Shareability.
        SH: u2,
        /// Contains bits[31:5] of the lower inclusive limit selectable of the selected MPU memory region. This value
        /// is zero extended to provide the base address to be checked against.
        BASE: u27,
    });

    /// MPU Region Limit Address Register format.
    pub const RLAR_Register = mmio.Mmio(packed struct(u32) {
        /// Enable the region.
        EN: u1,
        /// Attribue Index associates a set of attributes in the MPU MAIR0 and MPU MAIR1 fields.
        AttrIndx: u3,
        reserved0: u1 = 0,
        /// Limit Address contains bits [31:5] of the upper inclusive limit of the selected MPU memory region. This
        /// value is postfixed with 0x1F to provide the limit address to be checked against.
        LIMIT: u27,
    });
};
