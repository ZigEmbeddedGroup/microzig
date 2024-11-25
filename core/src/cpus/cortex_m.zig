const std = @import("std");
const microzig = @import("microzig");
const mmio = microzig.mmio;
const root = @import("root");

pub fn executing_isr() bool {
    return peripherals.scb.ICSR.read().VECTACTIVE != 0;
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

const scs_base = 0xE000E000;
const itm_base = 0xE0000000;
const dwt_base = 0xE0001000;
const tpi_base = 0xE0040000;
const coredebug_base = 0xE000EDF0;
const systick_base = scs_base + 0x0010;
const nvic_base = scs_base + 0x0100;
const scb_base = scs_base + 0x0D00;
const mpu_base = scs_base + 0x0D90;

const properties = microzig.chip.properties;
// TODO: will have to standardize this with regz code generation
const mpu_present = @hasDecl(properties, "__MPU_PRESENT") and std.mem.eql(u8, properties.__MPU_PRESENT, "1");

const core = blk: {
    const Core = enum {
        cortex_m0,
        cortex_m0p,
        cortex_m3,
        cortex_m33,
        cortex_m4,
    };

    const cortex_m = std.meta.stringToEnum(Core, microzig.config.cpu_name) orelse
        @panic(std.fmt.comptimePrint("Unrecognized Cortex-M core name: {s}", .{microzig.config.cpu_name}));

    break :blk switch (cortex_m) {
        .cortex_m0 => @import("cortex_m/m0"),
        .cortex_m0p => @import("cortex_m/m0plus.zig"),
        .cortex_m3 => @import("cortex_m/m3.zig"),
        .cortex_m33 => @import("cortex_m/m33.zig"),
        .cortex_4 => @import("cortex_m/m4.zig"),
    };
};

pub const peripherals = struct {
    /// System Control Block (SCB)
    pub const scb: *volatile types.peripherals.SystemControlBlock = @ptrFromInt(scb_base);

    /// Nested Vector Interrupt Controller (NVIC)
    pub const nvic: *volatile types.peripherals.NestedVectorInterruptController = @ptrFromInt(nvic_base);

    /// System Timer
    pub const systick: *volatile types.peripherals.SysTick = @ptrFromInt(systick_base);

    /// Memory Protection Unit (MPU)
    pub const mpu: *volatile types.peripherals.MemoryProtectionUnit = if (mpu_present)
        @ptrFromInt(mpu_base)
    else
        @compileError("This chip does not have a MPU.");
};

pub const types = struct {
    pub const peripherals = struct {
        /// System Control Block
        pub const SystemControlBlock = core.SystemControlBlock;

        /// Nested Vector Interrupt Controller
        pub const NestedVectorInterruptController = core.NestedVectorInterruptController;

        /// System Timer
        pub const SysTick = extern struct {
            ///  SysTick Control and Status Register
            CTRL: mmio.Mmio(packed struct(u32) {
                ENABLE: u1,
                TICKINT: u1,
                CLKSOURCE: u1,
                reserved0: u13,
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
                reserved0: u6,
                SKEW: u1,
                NOREF: u1,
            }),
        };

        pub const MemoryProtectionUnit = if (@hasDecl(core, "MemoryProtectionUnit"))
            core.MemoryProtectionUnit
        else
            @compileError("This cpu does not have a MPU.");
    };
};
