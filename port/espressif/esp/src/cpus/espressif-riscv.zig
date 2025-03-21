const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");

pub const StatusRegister = enum(u8) {
    // machine information
    mvendorid,
    marchid,
    mimpid,
    mhartid,

    // machine trap setup
    mstatus,
    misa,
    mtvec,
};

pub inline fn setStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrs zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub inline fn clearStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrc zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub const interrupt = struct {
    pub inline fn disable_interrupts() void {
        clearStatusBit(.mstatus, 0x08);
    }

    pub inline fn enable_interrupts() void {
        setStatusBit(.mstatus, 0x08);
    }
};

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub const sections = struct {
        extern var microzig_bss_start: u8;
        extern var microzig_bss_end: u8;
    };

    pub fn _start() linksection("microzig_flash_start") callconv(.c) noreturn {
        // asm volatile ("mv sp, %[eos]"
        //     :
        //     : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        // );

        microzig.cpu.interrupt.disable_interrupts();
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

        microzig_main();
    }

    export fn _rv32_trap() callconv(.c) noreturn {
        while (true) {}
    }

    const vector_table = [_]fn () callconv(.c) noreturn{
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
    };
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });
}
