const microzig = @import("microzig");
const root = @import("root");

pub const cpu_frequency = 24_000_000; // 24 MHz

pub inline fn enable_interrupts() void {
    asm volatile ("csrsi mstatus, 0b1000");
}

pub inline fn disable_interrupts() void {
    asm volatile ("csrci mstatus, 0b1000");
}

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

    pub fn _start() callconv(.C) noreturn {
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
        asm volatile ("csrsi 0x804, 0b111"); // INTSYSCR: enable EABI + Interrupt nesting + HPE
        asm volatile ("csrsi mtvec, 0b11"); // mtvec: absolute address + vector table mode
        microzig.cpu.enable_interrupts();

        microzig_main();
    }

    export fn _reset_vector() linksection("microzig_flash_start") callconv(.Naked) void {
        asm volatile ("j _start");
    }
};

pub fn export_startup_logic() void {
    @export(startup_logic._start, .{
        .name = "_start",
    });
}

const VectorTable = microzig.chip.VectorTable;
pub const vector_table: VectorTable = blk: {
    var tmp: VectorTable = .{};
    if (@hasDecl(root, "microzig_options")) {
        for (@typeInfo(root.VectorTableOptions).Struct.fields) |field|
            @field(tmp, field.name) = @field(root.microzig_options.interrupts, field.name);
    }

    break :blk tmp;
};
