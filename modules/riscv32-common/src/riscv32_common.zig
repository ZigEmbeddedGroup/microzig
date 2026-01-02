const builtin = @import("builtin");
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
    SupervisorTimer = 0x5,
    MachineTimer = 0x7,
    SupervisorExternal = 0x9,
    MachineExternal = 0xb,
};

pub const interrupt = struct {
    pub fn globally_enabled() bool {
        return csr.mstatus.read().mie == 1;
    }

    pub fn enable_interrupts() void {
        csr.mstatus.set(.{ .mie = 1 });
    }

    pub fn disable_interrupts() void {
        csr.mstatus.clear(.{ .mie = 1 });
    }

    pub const core = utilities.interrupt.CoreImpl(CoreInterrupt);
};

// TODO: Verbose exception handler

pub fn nop() void {
    asm volatile ("nop");
}

pub fn wfi() void {
    asm volatile ("wfi");
}

pub fn fence() void {
    asm volatile ("fence");
}

// NOTE: Contains all CSRs (Control Status Registers) from the riscv manual and should follow their
// spec. Cpu implementations can reexport what they need from here.
// See https://docs.riscv.org/reference/isa/priv/priv-csrs.html
>>>>>>> main
pub const csr = struct {
    pub const fflags = Csr(0x001, u32);
    pub const frm = Csr(0x002, u32);
    pub const fcsr = Csr(0x003, u32);

    pub const cycle = Csr(0xC00, u32);
    pub const time = Csr(0xC01, u32);
    pub const instret = Csr(0xC02, u32);
    pub const hpmcounter3 = Csr(0xC03, u32);
    pub const hpmcounter4 = Csr(0xC04, u32);
    pub const hpmcounter5 = Csr(0xC05, u32);
    pub const hpmcounter6 = Csr(0xC06, u32);
    pub const hpmcounter7 = Csr(0xC07, u32);
    pub const hpmcounter8 = Csr(0xC08, u32);
    pub const hpmcounter9 = Csr(0xC09, u32);
    pub const hpmcounter10 = Csr(0xC0A, u32);
    pub const hpmcounter11 = Csr(0xC0B, u32);
    pub const hpmcounter12 = Csr(0xC0C, u32);
    pub const hpmcounter13 = Csr(0xC0D, u32);
    pub const hpmcounter14 = Csr(0xC0E, u32);
    pub const hpmcounter15 = Csr(0xC0F, u32);
    pub const hpmcounter16 = Csr(0xC10, u32);
    pub const hpmcounter17 = Csr(0xC11, u32);
    pub const hpmcounter18 = Csr(0xC12, u32);
    pub const hpmcounter19 = Csr(0xC13, u32);
    pub const hpmcounter20 = Csr(0xC14, u32);
    pub const hpmcounter21 = Csr(0xC15, u32);
    pub const hpmcounter22 = Csr(0xC16, u32);
    pub const hpmcounter23 = Csr(0xC17, u32);
    pub const hpmcounter24 = Csr(0xC18, u32);
    pub const hpmcounter25 = Csr(0xC19, u32);
    pub const hpmcounter26 = Csr(0xC1A, u32);
    pub const hpmcounter27 = Csr(0xC1B, u32);
    pub const hpmcounter28 = Csr(0xC1C, u32);
    pub const hpmcounter29 = Csr(0xC1D, u32);
    pub const hpmcounter30 = Csr(0xC1E, u32);
    pub const hpmcounter31 = Csr(0xC1F, u32);

    pub const cycleh = Csr(0xC80, u32);
    pub const timeh = Csr(0xC81, u32);
    pub const instreth = Csr(0xC82, u32);
    pub const hpmcounter3h = Csr(0xC83, u32);
    pub const hpmcounter4h = Csr(0xC84, u32);
    pub const hpmcounter5h = Csr(0xC85, u32);
    pub const hpmcounter6h = Csr(0xC86, u32);
    pub const hpmcounter7h = Csr(0xC87, u32);
    pub const hpmcounter8h = Csr(0xC88, u32);
    pub const hpmcounter9h = Csr(0xC89, u32);
    pub const hpmcounter10h = Csr(0xC8A, u32);
    pub const hpmcounter11h = Csr(0xC8B, u32);
    pub const hpmcounter12h = Csr(0xC8C, u32);
    pub const hpmcounter13h = Csr(0xC8D, u32);
    pub const hpmcounter14h = Csr(0xC8E, u32);
    pub const hpmcounter15h = Csr(0xC8F, u32);
    pub const hpmcounter16h = Csr(0xC90, u32);
    pub const hpmcounter17h = Csr(0xC91, u32);
    pub const hpmcounter18h = Csr(0xC92, u32);
    pub const hpmcounter19h = Csr(0xC93, u32);
    pub const hpmcounter20h = Csr(0xC94, u32);
    pub const hpmcounter21h = Csr(0xC95, u32);
    pub const hpmcounter22h = Csr(0xC96, u32);
    pub const hpmcounter23h = Csr(0xC97, u32);
    pub const hpmcounter24h = Csr(0xC98, u32);
    pub const hpmcounter25h = Csr(0xC99, u32);
    pub const hpmcounter26h = Csr(0xC9A, u32);
    pub const hpmcounter27h = Csr(0xC9B, u32);
    pub const hpmcounter28h = Csr(0xC9C, u32);
    pub const hpmcounter29h = Csr(0xC9D, u32);
    pub const hpmcounter30h = Csr(0xC9E, u32);
    pub const hpmcounter31h = Csr(0xC9F, u32);

    // TODO: supervisor level csrs

    pub const mvendorid = Csr(0xF11, u32);
    pub const marchid = Csr(0xF12, u32);
    pub const mimpid = Csr(0xF13, u32);
    pub const mhartid = Csr(0xF14, u32);
    pub const mconfigptr = Csr(0xF15, u32);

    pub const mstatus = Csr(0x300, packed struct {
        reserved0: u3,
        mie: u1,
        reserved1: u28,
    });
    pub const misa = Csr(0x301, u32);
    pub const medeleg = Csr(0x302, u32);
    pub const mideleg = Csr(0x303, u32);
    pub const mie = Csr(0x304, u32);
    pub const mtvec = Csr(0x305, packed struct {
        pub const Mode = enum(u2) {
            direct = 0b00,
            vectored = 0b01,
        };

        mode: Mode,
        base: u30,
    });
    pub const mcounteren = Csr(0x306, u32);
    pub const mstatush = Csr(0x310, u32);
    pub const medelegh = Csr(0x312, u32);

    pub const mscratch = Csr(0x340, u32);
    pub const mepc = Csr(0x341, u32);
    pub const mcause = Csr(0x342, packed struct(u32) {
        code: u31,
        is_interrupt: u1,
    });
    pub const mtval = Csr(0x343, u32);
    pub const mip = Csr(0x344, u32);
    pub const mtinst = Csr(0x34A, u32);
    pub const mtval2 = Csr(0x34B, u32);

    pub const menvcfg = Csr(0x30A, u32);
    pub const menvcfgh = Csr(0x31A, u32);
    pub const mseccfg = Csr(0x747, u32);
    pub const mseccfgh = Csr(0x757, u32);

    pub const pmpcfg0 = Csr(0x3A0, u32);
    pub const pmpcfg1 = Csr(0x3A1, u32);
    pub const pmpcfg2 = Csr(0x3A2, u32);
    pub const pmpcfg3 = Csr(0x3A3, u32);
    pub const pmpcfg4 = Csr(0x3A4, u32);
    pub const pmpcfg5 = Csr(0x3A5, u32);
    pub const pmpcfg6 = Csr(0x3A6, u32);
    pub const pmpcfg7 = Csr(0x3A7, u32);
    pub const pmpcfg8 = Csr(0x3A8, u32);
    pub const pmpcfg9 = Csr(0x3A9, u32);
    pub const pmpcfg10 = Csr(0x3AA, u32);
    pub const pmpcfg11 = Csr(0x3AB, u32);
    pub const pmpcfg12 = Csr(0x3AC, u32);
    pub const pmpcfg13 = Csr(0x3AD, u32);
    pub const pmpcfg14 = Csr(0x3AE, u32);
    pub const pmpcfg15 = Csr(0x3AF, u32);

    pub const pmpaddr0 = Csr(0x3B0, u32);
    pub const pmpaddr1 = Csr(0x3B1, u32);
    pub const pmpaddr2 = Csr(0x3B2, u32);
    pub const pmpaddr3 = Csr(0x3B3, u32);
    pub const pmpaddr4 = Csr(0x3B4, u32);
    pub const pmpaddr5 = Csr(0x3B5, u32);
    pub const pmpaddr6 = Csr(0x3B6, u32);
    pub const pmpaddr7 = Csr(0x3B7, u32);
    pub const pmpaddr8 = Csr(0x3B8, u32);
    pub const pmpaddr9 = Csr(0x3B9, u32);
    pub const pmpaddr10 = Csr(0x3BA, u32);
    pub const pmpaddr11 = Csr(0x3BB, u32);
    pub const pmpaddr12 = Csr(0x3BC, u32);
    pub const pmpaddr13 = Csr(0x3BD, u32);
    pub const pmpaddr14 = Csr(0x3BE, u32);
    pub const pmpaddr15 = Csr(0x3BF, u32);
    pub const pmpaddr16 = Csr(0x3C0, u32);
    pub const pmpaddr17 = Csr(0x3C1, u32);
    pub const pmpaddr18 = Csr(0x3C2, u32);
    pub const pmpaddr19 = Csr(0x3C3, u32);
    pub const pmpaddr20 = Csr(0x3C4, u32);
    pub const pmpaddr21 = Csr(0x3C5, u32);
    pub const pmpaddr22 = Csr(0x3C6, u32);
    pub const pmpaddr23 = Csr(0x3C7, u32);
    pub const pmpaddr24 = Csr(0x3C8, u32);
    pub const pmpaddr25 = Csr(0x3C9, u32);
    pub const pmpaddr26 = Csr(0x3CA, u32);
    pub const pmpaddr27 = Csr(0x3CB, u32);
    pub const pmpaddr28 = Csr(0x3CC, u32);
    pub const pmpaddr29 = Csr(0x3CD, u32);
    pub const pmpaddr30 = Csr(0x3CE, u32);
    pub const pmpaddr31 = Csr(0x3CF, u32);
    pub const pmpaddr32 = Csr(0x3D0, u32);
    pub const pmpaddr33 = Csr(0x3D1, u32);
    pub const pmpaddr34 = Csr(0x3D2, u32);
    pub const pmpaddr35 = Csr(0x3D3, u32);
    pub const pmpaddr36 = Csr(0x3D4, u32);
    pub const pmpaddr37 = Csr(0x3D5, u32);
    pub const pmpaddr38 = Csr(0x3D6, u32);
    pub const pmpaddr39 = Csr(0x3D7, u32);
    pub const pmpaddr40 = Csr(0x3D8, u32);
    pub const pmpaddr41 = Csr(0x3D9, u32);
    pub const pmpaddr42 = Csr(0x3DA, u32);
    pub const pmpaddr43 = Csr(0x3DB, u32);
    pub const pmpaddr44 = Csr(0x3DC, u32);
    pub const pmpaddr45 = Csr(0x3DD, u32);
    pub const pmpaddr46 = Csr(0x3DE, u32);
    pub const pmpaddr47 = Csr(0x3DF, u32);
    pub const pmpaddr48 = Csr(0x3E0, u32);
    pub const pmpaddr49 = Csr(0x3E1, u32);
    pub const pmpaddr50 = Csr(0x3E2, u32);
    pub const pmpaddr51 = Csr(0x3E3, u32);
    pub const pmpaddr52 = Csr(0x3E4, u32);
    pub const pmpaddr53 = Csr(0x3E5, u32);
    pub const pmpaddr54 = Csr(0x3E6, u32);
    pub const pmpaddr55 = Csr(0x3E7, u32);
    pub const pmpaddr56 = Csr(0x3E8, u32);
    pub const pmpaddr57 = Csr(0x3E9, u32);
    pub const pmpaddr58 = Csr(0x3EA, u32);
    pub const pmpaddr59 = Csr(0x3EB, u32);
    pub const pmpaddr60 = Csr(0x3EC, u32);
    pub const pmpaddr61 = Csr(0x3ED, u32);
    pub const pmpaddr62 = Csr(0x3EE, u32);
    pub const pmpaddr63 = Csr(0x3EF, u32);

    pub const mstateen0 = Csr(0x30C, u32);
    pub const mstateen1 = Csr(0x30D, u32);
    pub const mstateen2 = Csr(0x30E, u32);
    pub const mstateen3 = Csr(0x30F, u32);
    pub const mstateen0h = Csr(0x31C, u32);
    pub const mstateen1h = Csr(0x31D, u32);
    pub const mstateen2h = Csr(0x31E, u32);
    pub const mstateen3h = Csr(0x31F, u32);

    pub const mnscratch = Csr(0x740, u32);
    pub const mnepc = Csr(0x741, u32);
    pub const mncause = Csr(0x742, u32);
    pub const mnstatus = Csr(0x744, u32);

    pub const mcycle = Csr(0xB00, u32);
    pub const minstret = Csr(0xB02, u32);
    pub const mhpmcounter3 = Csr(0xB03, u32);
    pub const mhpmcounter4 = Csr(0xB04, u32);
    pub const mhpmcounter5 = Csr(0xB05, u32);
    pub const mhpmcounter6 = Csr(0xB06, u32);
    pub const mhpmcounter7 = Csr(0xB07, u32);
    pub const mhpmcounter8 = Csr(0xB08, u32);
    pub const mhpmcounter9 = Csr(0xB09, u32);
    pub const mhpmcounter10 = Csr(0xB0A, u32);
    pub const mhpmcounter11 = Csr(0xB0B, u32);
    pub const mhpmcounter12 = Csr(0xB0C, u32);
    pub const mhpmcounter13 = Csr(0xB0D, u32);
    pub const mhpmcounter14 = Csr(0xB0E, u32);
    pub const mhpmcounter15 = Csr(0xB0F, u32);
    pub const mhpmcounter16 = Csr(0xB10, u32);
    pub const mhpmcounter17 = Csr(0xB11, u32);
    pub const mhpmcounter18 = Csr(0xB12, u32);
    pub const mhpmcounter19 = Csr(0xB13, u32);
    pub const mhpmcounter20 = Csr(0xB14, u32);
    pub const mhpmcounter21 = Csr(0xB15, u32);
    pub const mhpmcounter22 = Csr(0xB16, u32);
    pub const mhpmcounter23 = Csr(0xB17, u32);
    pub const mhpmcounter24 = Csr(0xB18, u32);
    pub const mhpmcounter25 = Csr(0xB19, u32);
    pub const mhpmcounter26 = Csr(0xB1A, u32);
    pub const mhpmcounter27 = Csr(0xB1B, u32);
    pub const mhpmcounter28 = Csr(0xB1C, u32);
    pub const mhpmcounter29 = Csr(0xB1D, u32);
    pub const mhpmcounter30 = Csr(0xB1E, u32);
    pub const mhpmcounter31 = Csr(0xB1F, u32);

    pub const mcycleh = Csr(0xB80, u32);
    pub const minstreth = Csr(0xB82, u32);
    pub const mhpmcounter3h = Csr(0xB83, u32);
    pub const mhpmcounter4h = Csr(0xB84, u32);
    pub const mhpmcounter5h = Csr(0xB85, u32);
    pub const mhpmcounter6h = Csr(0xB86, u32);
    pub const mhpmcounter7h = Csr(0xB87, u32);
    pub const mhpmcounter8h = Csr(0xB88, u32);
    pub const mhpmcounter9h = Csr(0xB89, u32);
    pub const mhpmcounter10h = Csr(0xB8A, u32);
    pub const mhpmcounter11h = Csr(0xB8B, u32);
    pub const mhpmcounter12h = Csr(0xB8C, u32);
    pub const mhpmcounter13h = Csr(0xB8D, u32);
    pub const mhpmcounter14h = Csr(0xB8E, u32);
    pub const mhpmcounter15h = Csr(0xB8F, u32);
    pub const mhpmcounter16h = Csr(0xB90, u32);
    pub const mhpmcounter17h = Csr(0xB91, u32);
    pub const mhpmcounter18h = Csr(0xB92, u32);
    pub const mhpmcounter19h = Csr(0xB93, u32);
    pub const mhpmcounter20h = Csr(0xB94, u32);
    pub const mhpmcounter21h = Csr(0xB95, u32);
    pub const mhpmcounter22h = Csr(0xB96, u32);
    pub const mhpmcounter23h = Csr(0xB97, u32);
    pub const mhpmcounter24h = Csr(0xB98, u32);
    pub const mhpmcounter25h = Csr(0xB99, u32);
    pub const mhpmcounter26h = Csr(0xB9A, u32);
    pub const mhpmcounter27h = Csr(0xB9B, u32);
    pub const mhpmcounter28h = Csr(0xB9C, u32);
    pub const mhpmcounter29h = Csr(0xB9D, u32);
    pub const mhpmcounter30h = Csr(0xB9E, u32);
    pub const mhpmcounter31h = Csr(0xB9F, u32);

    pub const mcountinhibit = Csr(0x320, u32);
    pub const mhpmevent3 = Csr(0x323, u32);
    pub const mhpmevent4 = Csr(0x324, u32);
    pub const mhpmevent5 = Csr(0x325, u32);
    pub const mhpmevent6 = Csr(0x326, u32);
    pub const mhpmevent7 = Csr(0x327, u32);
    pub const mhpmevent8 = Csr(0x328, u32);
    pub const mhpmevent9 = Csr(0x329, u32);
    pub const mhpmevent10 = Csr(0x32A, u32);
    pub const mhpmevent11 = Csr(0x32B, u32);
    pub const mhpmevent12 = Csr(0x32C, u32);
    pub const mhpmevent13 = Csr(0x32D, u32);
    pub const mhpmevent14 = Csr(0x32E, u32);
    pub const mhpmevent15 = Csr(0x32F, u32);
    pub const mhpmevent16 = Csr(0x330, u32);
    pub const mhpmevent17 = Csr(0x331, u32);
    pub const mhpmevent18 = Csr(0x332, u32);
    pub const mhpmevent19 = Csr(0x333, u32);
    pub const mhpmevent20 = Csr(0x334, u32);
    pub const mhpmevent21 = Csr(0x335, u32);
    pub const mhpmevent22 = Csr(0x336, u32);
    pub const mhpmevent23 = Csr(0x337, u32);
    pub const mhpmevent24 = Csr(0x338, u32);
    pub const mhpmevent25 = Csr(0x339, u32);
    pub const mhpmevent26 = Csr(0x33A, u32);
    pub const mhpmevent27 = Csr(0x33B, u32);
    pub const mhpmevent28 = Csr(0x33C, u32);
    pub const mhpmevent29 = Csr(0x33D, u32);
    pub const mhpmevent30 = Csr(0x33E, u32);
    pub const mhpmevent31 = Csr(0x33F, u32);

    pub const tselect = Csr(0x7A0, u32);
    pub const tdata1 = Csr(0x7A1, u32);
    pub const tdata2 = Csr(0x7A2, u32);
    pub const tdata3 = Csr(0x7A3, u32);
    pub const mcontext = Csr(0x7A8, u32);

    pub const dcsr = Csr(0x7B0, u32);
    pub const dpc = Csr(0x7B1, u32);
    pub const dscratch0 = Csr(0x7B2, u32);
    pub const dscratch1 = Csr(0x7B3, u32);

    pub fn Csr(addr: u24, T: type) type {
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

pub const utilities = struct {
    pub const interrupt = struct {
        pub fn CoreImpl(CoreInterruptEnum: type) type {
            std.debug.assert(@typeInfo(CoreInterruptEnum).@"enum".tag_type == u5);

            return struct {
                pub fn is_enabled(int: CoreInterruptEnum) bool {
                    return csr.mie.read() & (@as(u32, 1) << @intFromEnum(int)) != 0;
                }

                pub fn enable(int: CoreInterruptEnum) void {
                    csr.mie.set(@as(u32, 1) << @intFromEnum(int));
                }

                pub fn disable(int: CoreInterruptEnum) void {
                    csr.mie.clear(@as(u32, 1) << @intFromEnum(int));
                }

                pub fn is_pending(int: CoreInterruptEnum) bool {
                    return csr.mip.read() & (@as(u32, 1) << @intFromEnum(int)) != 0;
                }

                pub fn set_pending(int: CoreInterruptEnum) void {
                    csr.mip.set(@as(u32, 1) << @intFromEnum(int));
                }

                pub fn clear_pending(int: CoreInterruptEnum) void {
                    csr.mip.clear(@as(u32, 1) << @intFromEnum(int));
                }
            };
        }
    };
};
