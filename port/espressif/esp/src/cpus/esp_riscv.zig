const std = @import("std");
const microzig = @import("microzig");

const cpu_config = @import("cpu-config");
const riscv32_common = @import("riscv32-common");

pub const Exception = enum(u5) {
    InstructionFault = 0x1,
    IllegalInstruction = 0x2,
    Breakpoint = 0x3,
    LoadFault = 0x5,
    StoreFault = 0x7,
    UserEnvCall = 0x8,
    MachineEnvCall = 0xb,
};

pub const Interrupt = enum(u5) {
    interrupt1 = 1,
    interrupt2 = 2,
    interrupt3 = 3,
    interrupt4 = 4,
    interrupt5 = 5,
    interrupt6 = 6,
    interrupt7 = 7,
    interrupt8 = 8,
    interrupt9 = 9,
    interrupt10 = 10,
    interrupt11 = 11,
    interrupt12 = 12,
    interrupt13 = 13,
    interrupt14 = 14,
    interrupt15 = 15,
    interrupt16 = 16,
    interrupt17 = 17,
    interrupt18 = 18,
    interrupt19 = 19,
    interrupt20 = 20,
    interrupt21 = 21,
    interrupt22 = 22,
    interrupt23 = 23,
    interrupt24 = 24,
    interrupt25 = 25,
    interrupt26 = 26,
    interrupt27 = 27,
    interrupt28 = 28,
    interrupt29 = 29,
    interrupt30 = 30,
    interrupt31 = 31,
};

pub const InterruptHandler = *const fn (*TrapFrame) callconv(.c) void;

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = Interrupt, .HandlerFn = InterruptHandler },
});

pub const interrupt = struct {
    pub const globally_enabled = riscv32_common.interrupt.globally_enabled;
    pub const enable_interrupts = riscv32_common.interrupt.enable_interrupts;
    pub const disable_interrupts = riscv32_common.interrupt.disable_interrupts;

    const INTERRUPT_CORE0 = microzig.chip.peripherals.INTERRUPT_CORE0;

    pub fn is_enabled(int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_ENABLE.raw & (@as(u32, 1) << @intFromEnum(int)) != 0;
    }

    pub fn enable(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw |= @as(u32, 1) << @intFromEnum(int);
    }

    pub fn disable(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw &= ~(@as(u32, 1) << @intFromEnum(int));
    }

    /// Checks if a given interrupt is pending.
    pub fn is_pending(int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_EIP_STATUS.raw & (@as(u32, 1) << @intFromEnum(int)) != 0;
    }

    /// Clears the pending state of claimed (executing) edge-type interrupt only.
    /// NOTE: Pending state of an unclaimed (not executing) edge type interrupt can be flushed,
    /// if required, by first disabling it and only then call clearing it.
    pub fn clear_pending(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_CLEAR.raw |= @as(u32, 1) << @intFromEnum(int);
    }

    pub const Priority = enum(u4) {
        /// Setting this priority masks the interrupt.
        zero = 0,
        lowest = 1,
        highest = 15,

        _,
    };

    /// Sets the priority of an interrupt. Interrupts with priorities zero or less than the priority
    /// threshold value in are masked.
    pub fn set_priority(int: Interrupt, priority: Priority) void {
        get_priority_register_for(int).* = @intFromEnum(priority);
    }

    pub fn get_priority(int: Interrupt) Priority {
        return @enumFromInt(get_priority_register_for(int).*);
    }

    fn get_priority_register_for(int: Interrupt) *volatile u32 {
        // using CPU_INT_PRI_0 (which should be reserved because interrupts start from one) here so
        // that when I offset the register I don't have to subtract one from the interrupt number.
        const base: usize = @intFromPtr(&INTERRUPT_CORE0.CPU_INT_PRI_0);
        const reg: *volatile u32 = @ptrFromInt(base + @sizeOf(u32) * @as(usize, @intFromEnum(int)));
        return reg;
    }

    /// Set threshold for interrupt assertion. Only when the interrupt priority is equal to or
    /// higher than this threshold, the cpu will respond to this interrupt.
    pub fn set_priority_threshold(priority: Priority) void {
        INTERRUPT_CORE0.CPU_INT_THRESH.write(.{
            .CPU_INT_THRESH = @intFromEnum(priority),
        });
    }

    pub fn get_priority_threshold() Priority {
        return @enumFromInt(INTERRUPT_CORE0.CPU_INT_THRESH.read().CPU_INT_THRESH);
    }

    pub const Type = enum(u1) {
        level = 0,
        edge = 1,
    };

    pub fn set_type(int: Interrupt, typ: Type) void {
        const num = @intFromEnum(int);
        switch (typ) {
            .level => INTERRUPT_CORE0.CPU_INT_TYPE.raw &= ~(@as(u32, 1) << num),
            .edge => INTERRUPT_CORE0.CPU_INT_TYPE.raw |= @as(u32, 1) << num,
        }
    }

    pub fn get_type(int: Interrupt) Type {
        const num = @intFromEnum(int);
        return @enumFromInt(INTERRUPT_CORE0.CPU_INT_TYPE.raw & (@as(u32, 1) << num) >> num);
    }

    pub const Source = enum(u6) {
        wifi_mac = 0,
        wifi_mac_nmi = 1,
        wifi_pwr = 2,
        wifi_bb = 3,
        bt_mac = 4,
        bt_bb = 5,
        bt_bb_nmi = 6,
        rwbt = 7,
        rwble = 8,
        rwbt_nmi = 9,
        rwble_nmi = 10,
        i2c_master = 11,
        slc0 = 12,
        slc1 = 13,
        apb_ctrl = 14,
        uhci0 = 15,
        gpio = 16,
        gpio_nmi = 17,
        spi1 = 18,
        spi2 = 19,
        i2s0 = 20,
        uart0 = 21,
        uart1 = 22,
        ledc = 23,
        efuse = 24,
        twai0 = 25,
        usb_device = 26,
        rtc_core = 27,
        rmt = 28,
        i2c_ext0 = 29,
        timer1 = 30,
        timer2 = 31,
        tg0_t0_level = 32,
        tg0_wdt_level = 33,
        tg1_t0_level = 34,
        tg1_wdt_level = 35,
        cache_ia = 36,
        systimer_target0 = 37,
        systimer_target1 = 38,
        systimer_target2 = 39,
        spi_mem_reject_cache = 40,
        icache_preload0 = 41,
        icache_sync0 = 42,
        apb_adc = 43,
        dma_ch0 = 44,
        dma_ch1 = 45,
        dma_ch2 = 46,
        rsa = 47,
        aes = 48,
        sha = 49,
        from_cpu_intr0 = 50,
        from_cpu_intr1 = 51,
        from_cpu_intr2 = 52,
        from_cpu_intr3 = 53,
        assist_debug = 54,
        dma_apbperi_pms = 55,
        core0_iram0_pms = 56,
        core0_dram0_pms = 57,
        core0_pif_pms = 58,
        core0_pif_pms_size = 59,
        bak_pms_violate = 60,
        cache_core0_acs = 61,
    };

    pub fn map(source: Source, maybe_int: ?Interrupt) void {
        get_source_map_register_for(source).* = if (maybe_int) |int| @intFromEnum(int) else 0;
    }

    pub fn get_mapped_interrupt(source: Source) ?Interrupt {
        const source_raw: u4 = @truncate(get_source_map_register_for(source).*);
        if (source_raw != 0) {
            return @enumFromInt(source_raw);
        } else {
            return null;
        }
    }

    fn get_source_map_register_for(source: Source) *volatile u32 {
        // using MAC_INTR_MAP here as it's the first map register.
        const base: usize = @intFromPtr(&INTERRUPT_CORE0.MAC_INTR_MAP);
        return @ptrFromInt(base + @sizeOf(u32) * @as(usize, @intFromEnum(source)));
    }
};

pub const nop = riscv32_common.nop;
pub const wfi = riscv32_common.wfi;

pub const startup_logic = switch (cpu_config.boot_mode) {
    .direct => struct {
        comptime {
            // See this:
            // https://github.com/espressif/esp32c3-direct-boot-example

            // Direct Boot: does not support Security Boot and programs run directly in flash. To enable this mode, make
            // sure that the first two words of the bin file downloading to flash (address: 0x42000000) are 0xaedb041d.

            // In this case, the ROM bootloader sets up Flash MMU to map 4 MB of Flash to
            // addresses 0x42000000 (for code execution) and 0x3C000000 (for read-only data
            // access). The bootloader then jumps to address 0x42000008, i.e. to the
            // instruction at offset 8 in flash, immediately after the magic numbers.

            asm (
                \\.extern _start
                \\.section microzig_flash_start
                \\.align 4
                \\.byte 0x1d, 0x04, 0xdb, 0xae
                \\.byte 0x1d, 0x04, 0xdb, 0xae
            );
        }

        extern fn microzig_main() noreturn;

        fn _start() linksection("microzig_flash_start") callconv(.c) noreturn {
            interrupt.disable_interrupts();

            asm volatile ("mv sp, %[eos]"
                :
                : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
            );

            asm volatile (
                \\.option push
                \\.option norelax
                \\la gp, __global_pointer$
                \\.option pop
            );

            microzig.utilities.initialize_system_memories();

            init_interrupts();

            microzig_main();
        }

        fn export_impl() void {
            @export(&_start, .{ .name = "_start" });
        }
    },
    .image => struct {
        extern fn microzig_main() noreturn;

        const sections = struct {
            extern var microzig_bss_start: u8;
            extern var microzig_bss_end: u8;
        };

        fn _start() callconv(.naked) noreturn {
            asm volatile (
                \\mv sp, %[eos]
                \\jal _start_c
                :
                : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
            );
        }

        fn _start_c() callconv(.c) noreturn {
            interrupt.disable_interrupts();

            asm volatile (
                \\.option push
                \\.option norelax
                \\la gp, __global_pointer$
                \\.option pop
            );

            // fill .bss with zeroes
            {
                const bss_start: [*]u8 = @ptrCast(&sections.microzig_bss_start);
                const bss_end: [*]u8 = @ptrCast(&sections.microzig_bss_end);
                const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss_start);

                @memset(bss_start[0..bss_len], 0);
            }

            init_interrupts();

            microzig_main();
        }

        fn export_impl() void {
            @export(&_start, .{ .name = "_start" });
            @export(&_start_c, .{ .name = "_start_c" });
        }
    },
};

pub fn export_startup_logic() void {
    startup_logic.export_impl();
}

/// Gets interrupts into a known state after the bootloader.
fn init_interrupts() void {
    // unmap all sources
    for (std.enums.values(interrupt.Source)) |source| {
        interrupt.map(source, null);
    }

    interrupt.set_priority_threshold(.zero);

    for (std.enums.values(Interrupt)) |int| {
        interrupt.set_type(int, .level);
        interrupt.set_priority(int, .lowest);
        interrupt.disable(int);
    }

    csr.mtvec.write(.{
        .mode = .vectored,
        .base = @intCast(@intFromPtr(&_vector_table) >> 2),
    });
}

pub const TrapFrame = extern struct {
    ra: usize,
    t0: usize,
    t1: usize,
    t2: usize,
    t3: usize,
    t4: usize,
    t5: usize,
    t6: usize,
    a0: usize,
    a1: usize,
    a2: usize,
    a3: usize,
    a4: usize,
    a5: usize,
    a6: usize,
    a7: usize,
    s0: usize,
    s1: usize,
    s2: usize,
    s3: usize,
    s4: usize,
    s5: usize,
    s6: usize,
    s7: usize,
    s8: usize,
    s9: usize,
    s10: usize,
    s11: usize,
    gp: usize,
    tp: usize,
    sp: usize,
    pc: usize,
    mstatus: usize,
    mcause: usize,
    mtval: usize,
};

fn _vector_table() align(256) linksection(".ram_text") callconv(.naked) void {
    comptime {
        // TODO: make a better default exception handler
        @export(
            microzig.options.interrupts.Exception orelse &unhandled,
            .{ .name = "_exception_handler" },
        );

        for (std.meta.fieldNames(Interrupt)) |field_name| {
            @export(
                @field(microzig.options.interrupts, field_name) orelse &unhandled,
                .{ .name = std.fmt.comptimePrint("_{s}_handler", .{field_name}) },
            );
        }

        @export(&_update_priority, .{ .name = "_update_priority" });
        @export(&_restore_priority, .{ .name = "_restore_priority" });
    }

    const interrupts_jump_asm = comptime blk: {
        var s: []const u8 = &.{};
        for (1..32) |i| {
            s = s ++ std.fmt.comptimePrint(
                \\.balign 4
                \\    j interrupt{}
                \\
            , .{i});
        }
        break :blk s;
    };

    // adapted from https://github.com/esp-rs/esp-hal/blob/main/esp-riscv-rt/src/lib.rs
    asm volatile (
        \\    j exception
        \\
    ++ interrupts_jump_asm ++
        \\exception:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _exception_handler
        \\    j trap_common
        \\interrupt1:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt1_handler
        \\    j trap_common
        \\interrupt2:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt2_handler
        \\    j trap_common
        \\interrupt3:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt3_handler
        \\    j trap_common
        \\interrupt4:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt4_handler
        \\    j trap_common
        \\interrupt5:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt5_handler
        \\    j trap_common
        \\interrupt6:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt6_handler
        \\    j trap_common
        \\interrupt7:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt7_handler
        \\    j trap_common
        \\interrupt8:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt8_handler
        \\    j trap_common
        \\interrupt9:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt9_handler
        \\    j trap_common
        \\interrupt10:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt10_handler
        \\    j trap_common
        \\interrupt11:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt11_handler
        \\    j trap_common
        \\interrupt12:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt12_handler
        \\    j trap_common
        \\interrupt13:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt13_handler
        \\    j trap_common
        \\interrupt14:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt14_handler
        \\    j trap_common
        \\interrupt15:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt15_handler
        \\    j trap_common
        \\interrupt16:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt16_handler
        \\    j trap_common
        \\interrupt17:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt17_handler
        \\    j trap_common
        \\interrupt18:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt18_handler
        \\    j trap_common
        \\interrupt19:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt19_handler
        \\    j trap_common
        \\interrupt20:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt20_handler
        \\    j trap_common
        \\interrupt21:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt21_handler
        \\    j trap_common
        \\interrupt22:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt22_handler
        \\    j trap_common
        \\interrupt23:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt23_handler
        \\    j trap_common
        \\interrupt24:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt24_handler
        \\    j trap_common
        \\interrupt25:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt25_handler
        \\    j trap_common
        \\interrupt26:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt26_handler
        \\    j trap_common
        \\interrupt27:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt27_handler
        \\    j trap_common
        \\interrupt28:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt28_handler
        \\    j trap_common
        \\interrupt29:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt29_handler
        \\    j trap_common
        \\interrupt30:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt30_handler
        \\    j trap_common
        \\interrupt31:
        \\    addi sp, sp, -35*4
        \\    sw ra, 0(sp)
        \\    la ra, _interrupt31_handler
        \\    j trap_common
        \\trap_common:
        \\    sw t0, 1*4(sp)
        \\    sw t1, 2*4(sp)
        \\    sw t2, 3*4(sp)
        \\    sw t3, 4*4(sp)
        \\    sw t4, 5*4(sp)
        \\    sw t5, 6*4(sp)
        \\    sw t6, 7*4(sp)
        \\    sw a0, 8*4(sp)
        \\    sw a1, 9*4(sp)
        \\    sw a2, 10*4(sp)
        \\    sw a3, 11*4(sp)
        \\    sw a4, 12*4(sp)
        \\    sw a5, 13*4(sp)
        \\    sw a6, 14*4(sp)
        \\    sw a7, 15*4(sp)
        \\    sw s0, 16*4(sp)
        \\    sw s1, 17*4(sp)
        \\    sw s2, 18*4(sp)
        \\    sw s3, 19*4(sp)
        \\    sw s4, 20*4(sp)
        \\    sw s5, 21*4(sp)
        \\    sw s6, 22*4(sp)
        \\    sw s7, 23*4(sp)
        \\    sw s8, 24*4(sp)
        \\    sw s9, 25*4(sp)
        \\    sw s10, 26*4(sp)
        \\    sw s11, 27*4(sp)
        \\    sw gp, 28*4(sp)
        \\    sw tp, 29*4(sp)
        \\    addi t1, sp, 35*4  # what sp was on entry to trap
        \\    sw t1, 30*4(sp)
        \\    csrrs t1, mepc, x0
        \\    sw t1, 31*4(sp)
        \\    csrrs t1, mstatus, x0
        \\    sw t1, 32*4(sp)
        \\    csrrs t1, mcause, x0
        \\    sw t1, 33*4(sp)
        \\    csrrs t1, mtval, x0
        \\    sw t1, 34*4(sp)
        \\
        \\    mv s0, ra       # Save address of handler function
        \\
        \\    jal ra, _update_priority
        \\    mv s1, a0       # Save the return of _update_priority
        \\
        \\    mv a0, sp       # Pass a pointer to TrapFrame to the handler function
        \\    jalr ra, s0     # Call the handler function
        \\
        \\    mv a0, s1       # Pass stored priority to _restore_priority
        \\    jal ra, _restore_priority
        \\
        \\    lw t1, 31*4(sp)
        \\    csrrw x0, mepc, t1
        \\
        \\    lw t1, 32*4(sp)
        \\    csrrw x0, mstatus, t1
        \\
        \\    lw ra, 0*4(sp)
        \\    lw t0, 1*4(sp)
        \\    lw t1, 2*4(sp)
        \\    lw t2, 3*4(sp)
        \\    lw t3, 4*4(sp)
        \\    lw t4, 5*4(sp)
        \\    lw t5, 6*4(sp)
        \\    lw t6, 7*4(sp)
        \\    lw a0, 8*4(sp)
        \\    lw a1, 9*4(sp)
        \\    lw a2, 10*4(sp)
        \\    lw a3, 11*4(sp)
        \\    lw a4, 12*4(sp)
        \\    lw a5, 13*4(sp)
        \\    lw a6, 14*4(sp)
        \\    lw a7, 15*4(sp)
        \\    lw s0, 16*4(sp)
        \\    lw s1, 17*4(sp)
        \\    lw s2, 18*4(sp)
        \\    lw s3, 19*4(sp)
        \\    lw s4, 20*4(sp)
        \\    lw s5, 21*4(sp)
        \\    lw s6, 22*4(sp)
        \\    lw s7, 23*4(sp)
        \\    lw s8, 24*4(sp)
        \\    lw s9, 25*4(sp)
        \\    lw s10, 26*4(sp)
        \\    lw s11, 27*4(sp)
        \\    lw gp, 28*4(sp)
        \\    lw tp, 29*4(sp)
        \\    lw sp, 30*4(sp) # This removes the frame we allocated from the stack
        \\
        \\    mret
    );
}

fn unhandled(_: *TrapFrame) linksection(".ram_text") callconv(.c) void {
    const mcause = csr.mcause.read();

    if (mcause.is_interrupt != 0) {
        std.log.err("unhandled interrupt {} occurred!", .{mcause.code});
    } else {
        const exception: Exception = @enumFromInt(mcause.code);
        std.log.err("exception {s} occurred!", .{@tagName(exception)});
    }

    @panic("unhandled trap");
}

fn _update_priority() linksection(".ram_text") callconv(.c) u32 {
    const mcause = csr.mcause.read();

    const prev_priority = interrupt.get_priority_threshold();

    if (mcause.is_interrupt != 0) {
        // this is an interrupt (can also be exception in which case we don't enable interrupts).

        const int: Interrupt = @enumFromInt(mcause.code);
        const priority = interrupt.get_priority(int);

        if (@intFromEnum(priority) < 15) {
            // allow higher priority interrupts to preempt this one
            interrupt.set_priority_threshold(@enumFromInt(@intFromEnum(priority) + 1));
            interrupt.enable_interrupts();
        }
    }

    return @intFromEnum(prev_priority);
}

fn _restore_priority(priority_raw: u32) linksection(".ram_text") callconv(.c) void {
    interrupt.disable_interrupts();
    interrupt.set_priority_threshold(@enumFromInt(priority_raw));
}

pub const csr = struct {
    pub const mvendorid = riscv32_common.csr.mvendorid;
    pub const marchid = riscv32_common.csr.marchid;
    pub const mimpid = riscv32_common.csr.mimpid;
    pub const mhartid = riscv32_common.csr.mhartid;

    pub const mstatus = riscv32_common.csr.mstatus;
    pub const misa = riscv32_common.csr.misa;
    pub const mtvec = riscv32_common.csr.mtvec;

    pub const mscratch = riscv32_common.csr.mscratch;
    pub const mepc = riscv32_common.csr.mepc;
    pub const mcause = riscv32_common.csr.mcause;
    pub const mtval = riscv32_common.csr.mtval;

    pub const pmpcfg0 = riscv32_common.csr.pmpcfg0;
    pub const pmpcfg1 = riscv32_common.csr.pmpcfg1;
    pub const pmpcfg2 = riscv32_common.csr.pmpcfg2;
    pub const pmpcfg3 = riscv32_common.csr.pmpcfg3;

    pub const pmpaddr0 = riscv32_common.csr.pmpaddr0;
    pub const pmpaddr1 = riscv32_common.csr.pmpaddr1;
    pub const pmpaddr2 = riscv32_common.csr.pmpaddr2;
    pub const pmpaddr3 = riscv32_common.csr.pmpaddr3;
    pub const pmpaddr4 = riscv32_common.csr.pmpaddr4;
    pub const pmpaddr5 = riscv32_common.csr.pmpaddr5;
    pub const pmpaddr6 = riscv32_common.csr.pmpaddr6;
    pub const pmpaddr7 = riscv32_common.csr.pmpaddr7;
    pub const pmpaddr8 = riscv32_common.csr.pmpaddr8;
    pub const pmpaddr9 = riscv32_common.csr.pmpaddr9;
    pub const pmpaddr10 = riscv32_common.csr.pmpaddr10;
    pub const pmpaddr11 = riscv32_common.csr.pmpaddr11;
    pub const pmpaddr12 = riscv32_common.csr.pmpaddr12;
    pub const pmpaddr13 = riscv32_common.csr.pmpaddr13;
    pub const pmpaddr14 = riscv32_common.csr.pmpaddr14;
    pub const pmpaddr15 = riscv32_common.csr.pmpaddr15;

    pub const tselect = riscv32_common.csr.tselect;
    pub const tdata1 = riscv32_common.csr.tdata1;
    pub const tdata2 = riscv32_common.csr.tdata2;
    pub const tcontrol = Csr(0x7A5, packed struct {
        reserved0: u3,
        mte: u1,
        reserved1: u3,
        mpte: u1,
        reserved2: u24,
    });

    pub const dcsr = riscv32_common.csr.dcsr;
    pub const dpc = riscv32_common.csr.dpc;
    pub const dscratch0 = riscv32_common.csr.dscratch0;
    pub const dscratch1 = riscv32_common.csr.dscratch1;

    pub const mpcer = Csr(0x7E0, packed struct {
        cycle: u1,
        inst: u1,
        ld_hazard: u1,
        jmp_hazard: u1,
        idle: u1,
        load: u1,
        store: u1,
        jmp_uncond: u1,
        branch: u1,
        branch_taken: u1,
        inst_comp: u1,
        reserved0: u21,
    });
    pub const mpcmr = Csr(0x7E1, packed struct {
        count_en: u1,
        count_sat: u1,
        reserved0: u30,
    });
    pub const mpccr = Csr(0x7E2, u32);

    pub const cpu_gpio_oen = Csr(0x803, u32);
    pub const cpu_gpio_in = Csr(0x804, u32);
    pub const cpu_gpio_out = Csr(0x805, u32);

    pub const Csr = riscv32_common.csr.Csr;
};
