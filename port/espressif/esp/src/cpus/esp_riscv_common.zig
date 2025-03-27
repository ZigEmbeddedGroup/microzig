pub const Interrupt = enum(u8) {
    @"1" = 1,
    @"2" = 2,
    @"3" = 3,
    @"4" = 4,
    @"5" = 5,
    @"6" = 6,
    @"7" = 7,
    @"8" = 8,
    @"9" = 9,
    @"10" = 10,
    @"11" = 11,
    @"12" = 12,
    @"13" = 13,
    @"14" = 14,
    @"15" = 15,
    @"16" = 16,
    @"17" = 17,
    @"18" = 18,
    @"19" = 19,
    @"20" = 20,
    @"21" = 21,
    @"22" = 22,
    @"23" = 23,
    @"24" = 24,
    @"25" = 25,
    @"26" = 26,
    @"27" = 27,
    @"28" = 28,
    @"29" = 29,
    @"30" = 30,
    @"31" = 31,
};

pub const interrupt = struct {
    // TODO: to be moved to a common riscv implementation
    pub fn globally_enabled() bool {
        return asm volatile ("csrr %[value], mstatus"
            : [value] "=r" (-> u32),
        ) & 0x8 != 0;
    }

    // TODO: to be moved to a common riscv implementation
    pub fn enable_interrupts() void {
        asm volatile ("csrs mstatus, 0x8");
    }

    // TODO: to be moved to a common riscv implementation
    pub fn disable_interrupts() void {
        asm volatile ("csrc mstatus, 0x8");
    }
};

// TODO: to be moved to a common riscv implementation
pub fn wfi() void {
    asm volatile ("wfi");
}

// TODO: to be moved to a common riscv implementation
pub fn wfe() void {
    asm volatile ("csrs 0x810, 0x1");
    wfi();
    asm volatile ("csrs 0x810, 0x1");
}
