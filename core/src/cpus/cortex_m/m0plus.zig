const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register.
    CPUID: u32,
    /// Interrupt Control and State Register.
    ICSR: mmio.Mmio(packed struct(u32) {
        /// Contains the active exception number:
        /// 0 = Thread mode
        /// Nonzero = The exception number[a] of the currently active exception.
        VECTACTIVE: u6,
        reserved0: u6,
        /// Indicates the exception number of the highest priority pending enabled exception:
        /// 0 = no pending exceptions
        /// Nonzero = the exception number of the highest priority pending enabled exception.
        VECTPENDING: u6,
        reserved1: u4,
        /// Interrupt pending flag, excluding NMI and Faults:
        /// 0 = interrupt not pending
        /// 1 = interrupt pending.
        ISRPENDING: u1,
        reserved2: u2,
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
        reserved3: u2,
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
        reserved0: u1,
        /// Reserved for debug use. This bit reads as 0. When writing to the register you must
        /// write 0 to this bit, otherwise behavior is Unpredictable.
        VECTCLRACTIVE: u1,
        /// System reset request:
        /// 0 = no effect
        /// 1 = requests a system level reset.
        ///
        /// This bit reads as 0.
        SYSRESETREQ: u1,
        reserved1: u12,
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
        reserved0: u1,
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
        reserved1: u1,
        /// Send Event on Pending bit:
        /// 0 = only enabled interrupts or events can wakeup the processor, disabled interrupts are excluded
        /// 1 = enabled events and all interrupts, including disabled interrupts, can wakeup the processor.
        ///
        /// When an event or interrupt enters pending state, the event signal wakes up the processor from WFE.
        /// If the processor is not waiting for an event, the event is registered and affects the next WFE.
        ///
        /// The processor also wakes up on execution of an SEV instruction or an external event.
        SEVONPEND: u1,
        reserved2: u27,
    }),
    /// Configuration Control Register.
    CCR: mmio.Mmio(packed struct(u32) {
        reserved0: u3,
        /// Always reads as one, indicates that all unaligned accesses generate a HardFault.
        UNALIGN_TRP: u1,
        reserved1: u5,
        /// Always reads as one, indicates 8-byte stack alignment on exception entry.
        ///
        /// On exception entry, the processor uses bit[9] of the stacked PSR to indicate the stack
        /// alignment. On return from the exception it uses this stacked bit to restore the correct
        /// stack alignment.
        STKALIGN: u1,
        reserved2: u22,
    }),
    /// System Handlers Priority Registers.
    SHPR: [3]u32,
};

pub const NestedVectorInterruptController = extern struct {
    /// Interrupt Set-Enable Register.
    ISER: u32,
    reserved0: [31]u32,
    /// Interrupt Clear-Enable Register.
    ICER: u32,
    reserved1: [31]u32,
    /// Interrupt Set-Pending Register.
    ISPR: u32,
    reserved2: [31]u32,
    /// Interrupt Clear-Pending Register.
    ICPR: u32,
    reserved3: [95]u32,
    /// Interrupt Priority Registers.
    ///
    /// Each priority field holds a priority value, 0-192. The lower the value, the greater the
    /// priority of the corresponding interrupt. The processor implements only bits [7:6] of each
    /// field, bits [5:0] read as zero and ignore writes. This means writing 255 to a priority
    /// register saves value 192 to the register.
    IPR: [8]u32,

    pub fn is_enabled(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        return nvic.ISER & (1 << num) != 0;
    }

    pub fn enable(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ISER |= 1 << num;
    }

    pub fn disable(nvic: *volatile NestedVectorInterruptController, num: comptime_int) void {
        nvic.ISER &= !(1 << num);
    }
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        /// Indicates support for unified or separate instructions and data address regions.
        SEPARATE: u1,
        reserved0: u7,
        /// Number of data regions supported by the MPU.
        DREGION: u8,
        /// Number of instruction regions supported by the MPU.
        IREGION: u8,
        reserved1: u8,
    }),
    /// MPU Control Register
    CTRL: mmio.Mmio(packed struct(u32) {
        /// Enables the MPU
        ENABLE: u1,
        /// Enables of operation of MPU during HardFault and MNIHandlers.
        HFNMIENA: u1,
        /// Enables priviledged software access to default memory map.
        PRIVDEFENA: u1,
        reserved0: u29,
    }),
    /// MPU Region Number Register
    RNR: mmio.Mmio(packed struct(u32) {
        /// Indicates the memory region accessed by MPU RBAR and PMU RLAR.
        REGION: u8,
        reserved0: u24,
    }),
    /// MPU Region Base Address Register
    RBAR: mmio.Mmio(packed struct(u32) {
        /// MPU region field.
        REGION: u4,
        /// MPU region number valid bit.
        VALID: u1,
        /// Region base address field.
        ADDR: u27,
    }),
    /// MPU Attribute and Size Register
    RASR: mmio.Mmio(packed struct(u32) {
        /// Region enable bit.
        ENABLE: u1,
        /// Specifies the size of the MPU region. The minimum permitted value is 7 (b00111).
        SIZE: u5,
        reserved0: u2,
        /// Subregion disable bits.
        SRD: u3,
        /// Bufferable bit.
        B: u1,
        /// Cacheable bit.
        C: u1,
        /// Shareable bit.
        S: u1,
        reserved1: u5,
        /// Access permission field.
        AP: u3,
        reserved2: u1,
        /// Instruction access disable bit.
        XN: u1,
        reserved3: u3,
    }),
};
