const root = @import("root");
const microzig = @import("microzig");

pub const cpu_frequency = 8_000_000; // 8 MHz

pub const interrupt = struct {
    pub inline fn enable_interrupts() void {
        asm volatile ("csrsi mstatus, 0b1000");
    }

    pub inline fn disable_interrupts() void {
        asm volatile ("csrci mstatus, 0b1000");
    }
};

pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn wfe() void {
    const PFIC = microzig.chip.peripherals.PFIC;
    // Treats the subsequent wfi instruction as wfe
    PFIC.SCTLR.modify(.{ .WFITOWFE = 1 });
    asm volatile ("wfi");
}

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub fn _start() callconv(.c) noreturn {
        // set global pointer
        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );
        // set stack pointer
        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );
        root.initialize_system_memories();

        // Vendor-defined CSRs
        // 3.2 Interrupt-related CSR Registers
        asm volatile ("csrsi 0x804, 0b0111"); // INTSYSCR: enable Interrupt nesting + HPE and the configured interrupt nesting depth is 2.
        asm volatile ("csrsi mtvec, 0b11"); // mtvec: absolute address + vector table mode
        microzig.cpu.interrupt.enable_interrupts();

        // init system clock
        const RCC = microzig.chip.peripherals.RCC;
        RCC.CTLR.modify(.{ .HSION = 1 });
        RCC.CFGR0.raw &= 0xF8FF0000;
        RCC.CTLR.modify(.{ .HSEON = 0, .CSSON = 0 });
        RCC.CTLR.modify(.{ .HSEBYP = 0 });
        RCC.CFGR0.raw &= 0xFF80FFFF;
        RCC.CTLR.raw &= 0xEBFFFFFF;
        RCC.INTR.raw = 0x00FF0000;
        RCC.CFGR2.raw = 0x00000000;

        microzig_main();
    }

    export fn _reset_vector() linksection("microzig_flash_start") callconv(.naked) void {
        asm volatile ("j _start");
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });
}

const VectorTable = microzig.chip.VectorTable;
pub const vector_table: VectorTable = blk: {
    var tmp: VectorTable = .{};
    if (@hasDecl(root, "microzig_options")) {
        for (@typeInfo(microzig.VectorTableOptions).@"struct".fields) |field|
            @field(tmp, field.name) = @field(root.microzig_options.interrupts, field.name);
    }

    break :blk tmp;
};
