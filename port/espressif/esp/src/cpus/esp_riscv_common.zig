const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");
const microzig_options = root.microzig_options;

pub const Interrupt = enum(u8) {
    Interrupt1 = 1,
    Interrupt2 = 2,
    Interrupt3 = 3,
    Interrupt4 = 4,
    Interrupt5 = 5,
    Interrupt6 = 6,
    Interrupt7 = 7,
    Interrupt8 = 8,
    Interrupt9 = 9,
    Interrupt10 = 10,
    Interrupt11 = 11,
    Interrupt12 = 12,
    Interrupt13 = 13,
    Interrupt14 = 14,
    Interrupt15 = 15,
    Interrupt16 = 16,
    Interrupt17 = 17,
    Interrupt18 = 18,
    Interrupt19 = 19,
    Interrupt20 = 20,
    Interrupt21 = 21,
    Interrupt22 = 22,
    Interrupt23 = 23,
    Interrupt24 = 24,
    Interrupt25 = 25,
    Interrupt26 = 26,
    Interrupt27 = 27,
    Interrupt28 = 28,
    Interrupt29 = 29,
    Interrupt30 = 30,
    Interrupt31 = 31,
};

const riscv_calling_convention: std.builtin.CallingConvention = .{ .riscv32_interrupt = .{ .mode = .machine } };

pub const InterruptHandler = extern union {
    naked: *const fn () callconv(.naked) noreturn,
    riscv: *const fn () callconv(riscv_calling_convention) void,
};

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = Interrupt, .HandlerFn = InterruptHandler },
});

pub const interrupt = struct {
    // TODO: to be replaced by a common riscv implementation
    pub fn globally_enabled() bool {
        return asm volatile ("csrr %[value], mstatus"
            : [value] "=r" (-> u32),
        ) & 0x8 != 0;
    }

    // TODO: to be replaced by a common riscv implementation
    pub fn enable_interrupts() void {
        asm volatile ("csrs mstatus, 0x8");
    }

    // TODO: to be replaced by a common riscv implementation
    pub fn disable_interrupts() void {
        asm volatile ("csrc mstatus, 0x8");
    }

    const INTERRUPT_CORE0 = microzig.chip.peripherals.INTERRUPT_CORE0;

    pub fn is_enabled(comptime int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_ENABLE.raw & (1 << @intFromEnum(int)) != 0;
    }

    pub fn enable(comptime int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw |= 1 << @intFromEnum(int);
    }

    pub fn disable(comptime int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw &= ~@as(u32, 1 << @intFromEnum(int));
    }

    /// Check if a given interrupt is pending.
    pub fn is_pending(comptime int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_EIP_STATUS.raw & (1 << @intFromEnum(int)) != 0;
    }

    /// Clear the pending state of claimed (executing) edge-type interrupt only.
    /// NOTE: Pending state of an unclaimed (not executing) edge type interrupt can be flushed,
    /// if required, by first disabling it and only then call clearing it.
    pub fn clear_pending(comptime int: Interrupt) bool {
        INTERRUPT_CORE0.CPU_INT_CLEAR.raw |= 1 << @intFromEnum(int);
    }

    pub const Priority = enum(u4) {
        pub const highest: Priority = @enumFromInt(15);
        pub const lowest: Priority = @enumFromInt(1);
        /// Interrupt is masked with this priority.
        pub const zero: Priority = @enumFromInt(0);

        _,
    };

    pub fn set_priority(comptime int: Interrupt, priority: Priority) void {
        const reg_name = std.fmt.comptimePrint("CPU_INT_PRI_{}", .{@intFromEnum(int)});
        const field_name = std.fmt.comptimePrint("CPU_PRI_{}_MAP", .{@intFromEnum(int)});

        var reg = @field(INTERRUPT_CORE0, reg_name);
        var value = reg.read();
        @field(value, field_name) = @intFromEnum(priority);
        reg.write(value);
    }

    pub fn get_priority(comptime int: Interrupt) Priority {
        const reg_name = std.fmt.comptimePrint("CPU_INT_PRI_{}", .{@intFromEnum(int)});
        const field_name = std.fmt.comptimePrint("CPU_PRI_{}_MAP", .{@intFromEnum(int)});

        return @enumFromInt(@field(@field(INTERRUPT_CORE0, reg_name).read(), field_name));
    }

    /// Set threshold for interrupt assertion. Only when the interrupt priority is equal to or
    /// higher than this threshold, the cpu will respond to this interrupt.
    pub fn set_priority_threshold(priority: Priority) void {
        INTERRUPT_CORE0.CPU_INT_THRESH.modify(.{ .CPU_INT_THRESH = @intFromEnum(priority) });
    }

    pub const Type = enum(u1) {
        level = 0,
        edge = 1,
    };

    /// Configure the interrupt type.
    pub fn set_type(comptime int: Interrupt, typ: Type) void {
        const num = @intFromEnum(int);
        switch (typ) {
            .level => INTERRUPT_CORE0.CPU_INT_TYPE.raw |= 1 << num,
            .edge => INTERRUPT_CORE0.CPU_INT_TYPE.raw &= ~@as(u32, 1 << num),
        }
    }

    pub fn get_type(comptime int: Interrupt) Type {
        const num = @intFromEnum(int);
        return @enumFromInt(INTERRUPT_CORE0.CPU_INT_TYPE.raw & ~@as(u32, 1 << num) >> num);
    }

    // TODO: interrupt mapping maybe? it can also be done in the hal of each peripheral?
};

// TODO: to be replaced by common riscv implementation
pub fn wfi() void {
    asm volatile ("wfi");
}

// TODO: to be replaced by a common riscv implementation
pub fn wfe() void {
    asm volatile ("csrs 0x810, 0x1");
    wfi();
    asm volatile ("csrs 0x810, 0x1");
}

fn unhandled_interrupt() callconv(riscv_calling_convention) void {
    @panic("unhandled interrupt");
}

pub fn _vector_table() align(256) callconv(.naked) noreturn {
    const vector_table_asm = comptime blk: {
        var vtable: []const u8 =
            \\j _exception_handler
            \\
        ;
        for (1..32) |i| {
            vtable = vtable ++ std.fmt.comptimePrint(
                \\j _interrupt_handler_{}
                \\
            , .{i});
        }
        break :blk vtable;
    };

    comptime {
        // NOTE: using the union variant .naked here is fine because both variants have the same layout
        @export(if (microzig_options.interrupts.Exception) |handler|
            handler.naked
        else
            &unhandled_interrupt, .{ .name = "_exception_handler" });

        for (1..32) |i| {
            @export(
                if (@field(microzig_options.interrupts, std.fmt.comptimePrint("Interrupt{}", .{i}))) |handler|
                    handler.naked
                else
                    &unhandled_interrupt,
                .{ .name = std.fmt.comptimePrint("_interrupt_handler_{}", .{i}) },
            );
        }
    }

    asm volatile (vector_table_asm);
}
