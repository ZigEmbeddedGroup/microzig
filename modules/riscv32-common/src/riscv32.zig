const std = @import("std");

pub const Exception = enum(u32) {
    InstructionMisaligned = 0x0,
    InstructionFault = 0x1,
    IllegalInstruction = 0x2,
    Breakpoint = 0x3,
    LoadMisaligned = 0x4,
    LoadFault = 0x5,
    StoreMisaligned = 0x6,
    StoreFault = 0x7,
    UserEnvCall = 0x8,
    SupervisorEnvCall = 0x9,
    MachineEnvCall = 0xb,
    InstructionPageFault = 0xc,
    LoadPageFault = 0xd,
    StorePageFault = 0xf,
};

pub const CoreInterrupt = enum(u5) {
    SupervisorSoftware = 0x1,
    MachineSoftware = 0x3,
    SupervisorTimer = 0x1,
    MachineTimer = 0x7,
    SupervisorExternal = 0x9,
    MachineExternal = 0xb,
};

pub const interrupt = struct {
    pub const core = struct {
        pub fn globally_enabled() bool {
            return csr.core.mstatus.read().mie == 1;
        }

        pub fn enable_interrupts() void {
            csr.core.mstatus.set(.{ .mie = 1 });
        }

        pub fn disable_interrupts() void {
            csr.core.mstatus.clear(.{ .mie = 1 });
        }

        pub fn is_enabled(int: CoreInterrupt) bool {
            return csr.core.mie.read() & (1 << @intFromEnum(int)) != 0;
        }

        pub fn enable(comptime int: CoreInterrupt) void {
            csr.core.mie.set(1 << @intFromEnum(int));
        }

        pub fn disable(comptime int: CoreInterrupt) void {
            csr.core.mie.clear(1 << @intFromEnum(int));
        }

        pub fn is_pending(comptime int: CoreInterrupt) bool {
            return csr.core.mip.read() & (1 << @intFromEnum(int));
        }

        pub fn set_pending(comptime int: CoreInterrupt) void {
            csr.core.mip.set(1 << @intFromEnum(int));
        }

        pub fn clear_pending(comptime int: CoreInterrupt) void {
            csr.core.mip.clear(1 << @intFromEnum(int));
        }
    };
};

pub export fn _vector_table() align(64) callconv(.naked) noreturn {
    comptime {
        // NOTE: using the union variant .naked here is fine because both variants have the same layout
        @export(if (microzig_options.interrupts.Exception) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_exception_handler" });
        @export(if (microzig_options.interrupts.MachineSoftware) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_software_handler" });
        @export(if (microzig_options.interrupts.MachineTimer) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_timer_handler" });
        @export(if (microzig_options.interrupts.MachineExternal) |handler| handler.naked else &machine_external_interrupt, .{ .name = "_machine_external_handler" });
    }

    asm volatile (
        \\j _exception_handler
        \\.word 0
        \\.word 0
        \\j _machine_software_handler
        \\.word 0
        \\.word 0
        \\.word 0
        \\j _machine_timer_handler
        \\.word 0
        \\.word 0
        \\.word 0
        \\j _machine_external_handler
    );
}

pub fn nop() void {
    asm volatile ("nop");
}

pub fn wfi() void {
    asm volatile ("wfi");
}

pub fn wfe() void {
    // MAGIC: This instruction which seems to accomplishes nothing, is actually
    //        a hint instruction that blocks the current core.
    asm volatile ("slt zero, zero, x0");
}

pub fn sev() void {
    // MAGIC: This instruction which seems to accomplishes nothing, is actually
    //        a hint instruction that unblocks the other core.
    asm volatile ("slt zero, zero, x1");
}

pub const csr = struct {
    pub const core = struct {
        pub const mvendorid = CSR(0xF11, u32);
        pub const marchid = CSR(0xF12, u32);
        pub const mimpid = CSR(0xF13, u32);
        pub const mhartid = CSR(0xF14, u32);

        pub const mstatus = CSR(0x300, packed struct {
            reserved0: u3,
            mie: u1,
            reserved1: u28,
        });
        pub const misa = CSR(0x301, u32);
        pub const medeleg = CSR(0x302, u32);
        pub const mideleg = CSR(0x303, u32);
        pub const mie = CSR(0x304, u32);
        pub const mtvec = CSR(0x305, packed struct {
            pub const Mode = enum(u2) {
                direct = 0b00,
                vectored = 0b01,
            };

            mode: Mode,
            base: u30,
        });
        pub const mcounteren = CSR(0x306, u32);

        pub const mscratch = CSR(0x340, u32);
        pub const mepc = CSR(0x341, u32);
        pub const mcause = CSR(0x342, u32);
        pub const mtval = CSR(0x343, u32);
        pub const mip = CSR(0x344, u32);

        pub const pmpcfg0 = CSR(0x3A0, u32);
        pub const pmpcfg1 = CSR(0x3A1, u32);
        pub const pmpcfg2 = CSR(0x3A2, u32);
        pub const pmpcfg3 = CSR(0x3A3, u32);

        pub const pmpaddr0 = CSR(0x3B0, u32);
        pub const pmpaddr1 = CSR(0x3B1, u32);
        pub const pmpaddr2 = CSR(0x3B2, u32);
        pub const pmpaddr3 = CSR(0x3B3, u32);
        pub const pmpaddr4 = CSR(0x3B4, u32);
        pub const pmpaddr5 = CSR(0x3B5, u32);
        pub const pmpaddr6 = CSR(0x3B6, u32);
        pub const pmpaddr7 = CSR(0x3B7, u32);
        pub const pmpaddr8 = CSR(0x3B8, u32);
        pub const pmpaddr9 = CSR(0x3B9, u32);
        pub const pmpaddr10 = CSR(0x3BA, u32);
        pub const pmpaddr11 = CSR(0x3BB, u32);
        pub const pmpaddr12 = CSR(0x3BC, u32);
        pub const pmpaddr13 = CSR(0x3BD, u32);
        pub const pmpaddr14 = CSR(0x3BE, u32);
        pub const pmpaddr15 = CSR(0x3BF, u32);

        pub const mcycle = CSR(0xB00, u32);
        pub const minstret = CSR(0xB02, u32);
        pub const mhpmcounter3 = CSR(0xB03, u32);
        pub const mhpmcounter4 = CSR(0xB04, u32);
        pub const mhpmcounter5 = CSR(0xB05, u32);
        pub const mhpmcounter6 = CSR(0xB06, u32);
        pub const mhpmcounter7 = CSR(0xB07, u32);
        pub const mhpmcounter8 = CSR(0xB08, u32);
        pub const mhpmcounter9 = CSR(0xB09, u32);
        pub const mhpmcounter10 = CSR(0xB0A, u32);
        pub const mhpmcounter11 = CSR(0xB0B, u32);
        pub const mhpmcounter12 = CSR(0xB0C, u32);
        pub const mhpmcounter13 = CSR(0xB0D, u32);
        pub const mhpmcounter14 = CSR(0xB0E, u32);
        pub const mhpmcounter15 = CSR(0xB0F, u32);
        pub const mhpmcounter16 = CSR(0xB10, u32);
        pub const mhpmcounter17 = CSR(0xB11, u32);
        pub const mhpmcounter18 = CSR(0xB12, u32);
        pub const mhpmcounter19 = CSR(0xB13, u32);
        pub const mhpmcounter20 = CSR(0xB14, u32);
        pub const mhpmcounter21 = CSR(0xB15, u32);
        pub const mhpmcounter22 = CSR(0xB16, u32);
        pub const mhpmcounter23 = CSR(0xB17, u32);
        pub const mhpmcounter24 = CSR(0xB18, u32);
        pub const mhpmcounter25 = CSR(0xB19, u32);
        pub const mhpmcounter26 = CSR(0xB1A, u32);
        pub const mhpmcounter27 = CSR(0xB1B, u32);
        pub const mhpmcounter28 = CSR(0xB1C, u32);
        pub const mhpmcounter29 = CSR(0xB1D, u32);
        pub const mhpmcounter30 = CSR(0xB1E, u32);
        pub const mhpmcounter31 = CSR(0xB1F, u32);
        pub const mcycleh = CSR(0xB80, u32);
        pub const minstreth = CSR(0xB82, u32);
        pub const mhpmcounter3h = CSR(0xB83, u32);
        pub const mhpmcounter4h = CSR(0xB84, u32);
        pub const mhpmcounter5h = CSR(0xB85, u32);
        pub const mhpmcounter6h = CSR(0xB86, u32);
        pub const mhpmcounter7h = CSR(0xB87, u32);
        pub const mhpmcounter8h = CSR(0xB88, u32);
        pub const mhpmcounter9h = CSR(0xB89, u32);
        pub const mhpmcounter10h = CSR(0xB8A, u32);
        pub const mhpmcounter11h = CSR(0xB8B, u32);
        pub const mhpmcounter12h = CSR(0xB8C, u32);
        pub const mhpmcounter13h = CSR(0xB8D, u32);
        pub const mhpmcounter14h = CSR(0xB8E, u32);
        pub const mhpmcounter15h = CSR(0xB8F, u32);
        pub const mhpmcounter16h = CSR(0xB90, u32);
        pub const mhpmcounter17h = CSR(0xB91, u32);
        pub const mhpmcounter18h = CSR(0xB92, u32);
        pub const mhpmcounter19h = CSR(0xB93, u32);
        pub const mhpmcounter20h = CSR(0xB94, u32);
        pub const mhpmcounter21h = CSR(0xB95, u32);
        pub const mhpmcounter22h = CSR(0xB96, u32);
        pub const mhpmcounter23h = CSR(0xB97, u32);
        pub const mhpmcounter24h = CSR(0xB98, u32);
        pub const mhpmcounter25h = CSR(0xB99, u32);
        pub const mhpmcounter26h = CSR(0xB9A, u32);
        pub const mhpmcounter27h = CSR(0xB9B, u32);
        pub const mhpmcounter28h = CSR(0xB9C, u32);
        pub const mhpmcounter29h = CSR(0xB9D, u32);
        pub const mhpmcounter30h = CSR(0xB9E, u32);
        pub const mhpmcounter31h = CSR(0xB9F, u32);

        pub const mhpmevent3 = CSR(0x323, u32);
        pub const mhpmevent4 = CSR(0x324, u32);
        pub const mhpmevent5 = CSR(0x325, u32);
        pub const mhpmevent6 = CSR(0x326, u32);
        pub const mhpmevent7 = CSR(0x327, u32);
        pub const mhpmevent8 = CSR(0x328, u32);
        pub const mhpmevent9 = CSR(0x329, u32);
        pub const mhpmevent10 = CSR(0x32A, u32);
        pub const mhpmevent11 = CSR(0x32B, u32);
        pub const mhpmevent12 = CSR(0x32C, u32);
        pub const mhpmevent13 = CSR(0x32D, u32);
        pub const mhpmevent14 = CSR(0x32E, u32);
        pub const mhpmevent15 = CSR(0x32F, u32);
        pub const mhpmevent16 = CSR(0x330, u32);
        pub const mhpmevent17 = CSR(0x331, u32);
        pub const mhpmevent18 = CSR(0x332, u32);
        pub const mhpmevent19 = CSR(0x333, u32);
        pub const mhpmevent20 = CSR(0x334, u32);
        pub const mhpmevent21 = CSR(0x335, u32);
        pub const mhpmevent22 = CSR(0x336, u32);
        pub const mhpmevent23 = CSR(0x337, u32);
        pub const mhpmevent24 = CSR(0x338, u32);
        pub const mhpmevent25 = CSR(0x339, u32);
        pub const mhpmevent26 = CSR(0x33A, u32);
        pub const mhpmevent27 = CSR(0x33B, u32);
        pub const mhpmevent28 = CSR(0x33C, u32);
        pub const mhpmevent29 = CSR(0x33D, u32);
        pub const mhpmevent30 = CSR(0x33E, u32);
        pub const mhpmevent31 = CSR(0x33F, u32);

        pub const tselect = CSR(0x7A0, u32);
        pub const tdata1 = CSR(0x7A1, u32);
        pub const tdata2 = CSR(0x7A2, u32);
        pub const tdata3 = CSR(0x7A3, u32);

        pub const dcsr = CSR(0x7B0, u32);
        pub const dpc = CSR(0x7B1, u32);
        pub const dscratch = CSR(0x7B2, u32);
    };

    pub fn CSR(addr: u24, T: type) type {
        const size = @bitSizeOf(T);
        if (size != 32)
            @compileError("size must be 32!");
        const ident = std.fmt.comptimePrint("{}", .{addr});

        return struct {
            const Self = @This();

            pub inline fn read_raw() u32 {
                return asm volatile ("csrr %[value], " ++ ident
                    : [value] "=r" (-> u32),
                );
            }

            pub inline fn read() T {
                return @bitCast(read_raw());
            }

            pub inline fn write_raw(value: u32) void {
                asm volatile ("csrw " ++ ident ++ ", %[value]"
                    :
                    : [value] "r" (value),
                );
            }

            pub inline fn write(value: T) void {
                write_raw(@bitCast(value));
            }

            pub inline fn modify(modifier: anytype) void {
                switch (@typeInfo(T)) {
                    .@"struct" => {
                        var value = read();
                        inline for (@typeInfo(@TypeOf(modifier)).Struct.fields) |field| {
                            @field(value, field.name) = @field(modifier, field.name);
                        }
                        write(value);
                    },
                    .int => write(modifier),
                    else => @compileError("unsupported type"),
                }
            }

            pub inline fn set_raw(bits: u32) void {
                asm volatile ("csrs " ++ ident ++ ", %[bits]"
                    :
                    : [bits] "r" (bits),
                );
            }

            pub inline fn set(fields: anytype) void {
                set_raw(get_bits(fields));
            }

            pub inline fn clear_raw(bits: u32) void {
                asm volatile ("csrc " ++ ident ++ ", %[bits]"
                    :
                    : [bits] "r" (bits),
                );
            }

            pub inline fn clear(fields: anytype) void {
                clear_raw(get_bits(fields));
            }

            pub inline fn read_set_raw(bits: u32) u32 {
                return asm volatile ("csrrs %[value], " ++ ident ++ ", %[bits]"
                    : [value] "=r" (-> u32),
                    : [bits] "r" (bits),
                );
            }

            pub inline fn read_set(fields: anytype) T {
                return @bitCast(read_set_raw(get_bits(fields)));
            }

            pub inline fn read_clear_raw(bits: u32) u32 {
                return asm volatile ("csrrc %[value], " ++ ident ++ ", %[bits]"
                    : [value] "=r" (-> u32),
                    : [bits] "r" (bits),
                );
            }

            pub inline fn read_clear(fields: anytype) T {
                return @bitCast(read_clear_raw(get_bits(fields)));
            }

            inline fn get_bits(fields: anytype) u32 {
                return switch (@typeInfo(T)) {
                    .@"struct" => blk: {
                        var bits: T = @bitCast(@as(u32, 0));
                        inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                            @field(bits, field.name) = @field(fields, field.name);
                        }
                        break :blk @bitCast(bits);
                    },
                    .int => fields,
                    else => @compileError("unsupported type"),
                };
            }
        };
    }
};
