const std = @import("std");
const microzig = @import("microzig");
const mmio = microzig.mmio;
const root = @import("root");

const scs_base = 0xE000E000;
const itm_base = 0xE0000000;
const dwt_base = 0xE0001000;
const tpi_base = 0xE0040000;
const coredebug_base = 0xE000EDF0;
const systick_base = scs_base + 0x0010;
const nvic_base = scs_base + 0x0100;
const scb_base = scs_base + 0x0D00;
const mpu_base = scs_base + 0x0D90;

const Core = enum {
    @"ARM Cortex-M0",
    @"ARM Cortex-M0+",
    @"ARM Cortex-M3",
    @"ARM Cortex-M33",
    @"ARM Cortex-M4",
    cortex_m7,
};

const core: type = blk: {
    const cortex_m = std.meta.stringToEnum(Core, microzig.config.cpu_name) orelse @compileError(std.fmt.comptimePrint("Unrecognized Cortex-M core name: {s}", .{microzig.config.cpu_name}));
    break :blk switch (cortex_m) {
        .@"ARM Cortex-M0" => @import("cortex_m/m0"),
        .@"ARM Cortex-M0+" => @import("cortex_m/m0plus.zig"),
        .@"ARM Cortex-M3" => @import("cortex_m/m3.zig"),
        .@"ARM Cortex-M33" => @import("cortex_m/m33.zig"),
        .@"ARM Cortex-M4" => @import("cortex_m/m4.zig"),
        .cortex_m7 => @import("cortex_m/m7.zig"),
    };
};

const properties = microzig.chip.properties;
// TODO: will have to standardize this with regz code generation
const mpu_present = @hasDecl(properties, "__MPU_PRESENT") and std.mem.eql(u8, properties.__MPU_PRESENT, "1");

/// System Control Block (SCB)
pub const scb: *volatile core.SystemControlBlock = @ptrFromInt(scb_base);
/// Nested Vector Interrupt Controller (NVIC)
pub const nvic: *volatile core.NestedVectorInterruptController = @ptrFromInt(nvic_base);
/// Memory Protection Unit (MPU)
pub const mpu: *volatile core.MemoryProtectionUnit = if (mpu_present)
    @ptrFromInt(mpu_base)
else
    @compileError("Cortex-M does not have an MPU");

pub const dbg: if (@hasDecl(core, "DebugRegisters")) *volatile core.DebugRegisters else *volatile anyopaque = @ptrFromInt(dwt_base);

pub const itm: if (@hasDecl(core, "ITM")) *volatile core.ITM else *volatile anyopaque = @ptrFromInt(itm_base);

pub const tpiu: if (@hasDecl(core, "TPIU")) *volatile core.TPIU else *volatile anyopaque = @ptrFromInt(tpi_base);

pub fn executing_isr() bool {
    return scb.ICSR.read().VECTACTIVE != 0;
}

pub fn enable_interrupts() void {
    asm volatile ("cpsie i");
}

pub fn disable_interrupts() void {
    asm volatile ("cpsid i");
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

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    // it looks odd to just use a u8 here, but in C it's common to use a
    // char when linking these values from the linkerscript. What's
    // important is the addresses of these values.
    extern var microzig_data_start: u8;
    extern var microzig_data_end: u8;
    extern var microzig_bss_start: u8;
    extern var microzig_bss_end: u8;
    extern const microzig_data_load_start: u8;

    pub fn _start() callconv(.C) noreturn {

        // fill .bss with zeroes
        {
            const bss_start: [*]u8 = @ptrCast(&microzig_bss_start);
            const bss_end: [*]u8 = @ptrCast(&microzig_bss_end);
            const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss_start);

            @memset(bss_start[0..bss_len], 0);
        }

        // load .data from flash
        {
            const data_start: [*]u8 = @ptrCast(&microzig_data_start);
            const data_end: [*]u8 = @ptrCast(&microzig_data_end);
            const data_len = @intFromPtr(data_end) - @intFromPtr(data_start);
            const data_src: [*]const u8 = @ptrCast(&microzig_data_load_start);

            @memcpy(data_start[0..data_len], data_src[0..data_len]);
        }

        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(startup_logic._start, .{
        .name = "_start",
    });
}

fn is_valid_field(field_name: []const u8) bool {
    return !std.mem.startsWith(u8, field_name, "reserved") and
        !std.mem.eql(u8, field_name, "initial_stack_pointer") and
        !std.mem.eql(u8, field_name, "reset");
}

const VectorTable = microzig.chip.VectorTable;

// will be imported by microzig.zig to allow system startup.
pub const vector_table: VectorTable = blk: {
    var tmp: VectorTable = .{
        .initial_stack_pointer = microzig.config.end_of_stack,
        .Reset = .{ .C = microzig.cpu.startup_logic._start },
    };

    if (@hasDecl(root, "microzig_options")) {
        for (@typeInfo(root.VectorTableOptions).Struct.fields) |field|
            @field(tmp, field.name) = @field(root.microzig_options.interrupts, field.name);
    }

    break :blk tmp;
};

fn create_interrupt_vector(
    comptime function: anytype,
) microzig.interrupt.Handler {
    const calling_convention = @typeInfo(@TypeOf(function)).Fn.calling_convention;
    return switch (calling_convention) {
        .C => .{ .C = function },
        .Naked => .{ .Naked = function },
        // for unspecified calling convention we are going to generate small wrapper
        .Unspecified => .{
            .C = struct {
                fn wrapper() callconv(.C) void {
                    if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                        @call(.always_inline, function, .{});
                }
            }.wrapper,
        },

        else => |val| {
            const conv_name = inline for (std.meta.fields(std.builtin.CallingConvention)) |field| {
                if (val == @field(std.builtin.CallingConvention, field.name))
                    break field.name;
            } else unreachable;

            @compileError("unsupported calling convention for interrupt vector: " ++ conv_name);
        },
    };
}

pub const peripherals = struct {
    ///  System Tick Timer
    pub const SysTick = @as(*volatile types.peripherals.SysTick, @ptrFromInt(0xe000e010));

    ///  System Control Space
    pub const NVIC = @compileError("TODO"); // @ptrFromInt(*volatile types.peripherals.NVIC, 0xe000e100);

    ///  System Control Block
    pub const SCB = @as(*volatile types.peripherals.SCB, @ptrFromInt(0xe000ed00));
};

pub const types = struct {
    pub const peripherals = struct {
        ///  System Tick Timer
        pub const SysTick = extern struct {
            ///  SysTick Control and Status Register
            CTRL: mmio.Mmio(packed struct(u32) {
                ENABLE: u1,
                TICKINT: u1,
                CLKSOURCE: u1,
                reserved16: u13,
                COUNTFLAG: u1,
                padding: u15,
            }),
            ///  SysTick Reload Value Register
            LOAD: mmio.Mmio(packed struct(u32) {
                RELOAD: u24,
                padding: u8,
            }),
            ///  SysTick Current Value Register
            VAL: mmio.Mmio(packed struct(u32) {
                CURRENT: u24,
                padding: u8,
            }),
            ///  SysTick Calibration Register
            CALIB: mmio.Mmio(packed struct(u32) {
                TENMS: u24,
                reserved30: u6,
                SKEW: u1,
                NOREF: u1,
            }),
        };

        ///  System Control Block
        pub const SCB = extern struct {
            CPUID: mmio.Mmio(packed struct(u32) {
                REVISION: u4,
                PARTNO: u12,
                ARCHITECTURE: u4,
                VARIANT: u4,
                IMPLEMENTER: u8,
            }),
            ///  Interrupt Control and State Register
            ICSR: mmio.Mmio(packed struct(u32) {
                VECTACTIVE: u9,
                reserved12: u3,
                VECTPENDING: u9,
                reserved22: u1,
                ISRPENDING: u1,
                ISRPREEMPT: u1,
                reserved25: u1,
                PENDSTCLR: u1,
                PENDSTSET: u1,
                PENDSVCLR: u1,
                PENDSVSET: u1,
                reserved31: u2,
                NMIPENDSET: u1,
            }),
            ///  Vector Table Offset Register
            VTOR: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                TBLOFF: u24,
            }),
            ///  Application Interrupt and Reset Control Register
            AIRCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                VECTCLRACTIVE: u1,
                SYSRESETREQ: u1,
                reserved15: u12,
                ENDIANESS: u1,
                VECTKEY: u16,
            }),
            ///  System Control Register
            SCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                SLEEPONEXIT: u1,
                SLEEPDEEP: u1,
                reserved4: u1,
                SEVONPEND: u1,
                padding: u27,
            }),
            ///  Configuration Control Register
            CCR: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                UNALIGN_TRP: u1,
                reserved9: u5,
                STKALIGN: u1,
                padding: u22,
            }),
            reserved28: [4]u8,
            ///  System Handlers Priority Registers. [0] is RESERVED
            SHP: u32,
            reserved36: [4]u8,
            ///  System Handler Control and State Register
            SHCSR: mmio.Mmio(packed struct(u32) {
                reserved15: u15,
                SVCALLPENDED: u1,
                padding: u16,
            }),
        };
    };
};
