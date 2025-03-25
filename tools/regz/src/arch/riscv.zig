//! codegen specific to riscv
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const gen = @import("../gen.zig");

const log = std.log.scoped(.@"gen.riscv");

pub fn write_interrupt_vector(
    db: *Database,
    arena: std.mem.Allocator,
    device: *const Database.Device,
    writer: anytype,
) !void {
    assert(device.arch.is_riscv());

    try writer.writeAll(
        \\
        \\pub const VectorTable = extern struct {
        \\    const Handler = microzig.interrupt.Handler;
        \\    const unhandled = microzig.interrupt.unhandled;
        \\
    );

    var index: i32 = 0;

    // CPU specific vectors
    switch (device.arch) {
        .qingke_v2 => {
            // start from No. 1
            try writer.writeAll(
                \\    reserved1: [1]u32 = undefined,
                \\    NMI: Handler = unhandled,
                \\    EXC: Handler = unhandled,
                \\    reserved4: [8]u32 = undefined,
                \\    SysTick: Handler = unhandled,
                \\    reserved13: [1]u32 = undefined,
                \\    SW: Handler = unhandled,
                \\    reserved15: [1]u32 = undefined,
                \\
            );
            index = 16;
        },
        .qingke_v3 => {
            // start from No. 2
            try writer.writeAll(
                \\    NMI: Handler = unhandled,
                \\    EXC: Handler = unhandled,
                \\    reserved4: [8]u32 = undefined,
                \\    SysTick: Handler = unhandled,
                \\    reserved13: [1]u32 = undefined,
                \\    SWI: Handler = unhandled,
                \\    reserved15: [1]u32 = undefined,
                \\
            );
            index = 16;
        },
        .qingke_v4 => {
            // start from No. 1
            try writer.writeAll(
                \\    reserved1: [1]u32 = undefined,
                \\    NMI: Handler = unhandled,
                \\    HardFault: Handler = unhandled,
                \\    reserved4: [1]u32 = undefined,
                \\    Ecall_M: Handler = unhandled,
                \\    reserved6: [2]u32 = undefined,
                \\    Ecall_U: Handler = unhandled,
                \\    BreakPoint: Handler = unhandled,
                \\    reserved10: [2]u32 = undefined,
                \\    SysTick: Handler = unhandled,
                \\    reserved13: [1]u32 = undefined,
                \\    SW: Handler = unhandled,
                \\    reserved15: [1]u32 = undefined,
                \\
            );
            index = 16;
        },
        else => {},
    }

    const interrupts = try db.get_interrupts(arena, device.id);
    for (interrupts) |interrupt| {
        if (index < interrupt.idx) {
            try writer.print("reserved{}: [{}]u32 = undefined,\n", .{
                index,
                interrupt.idx - index,
            });
            index = interrupt.idx;
        } else if (index > interrupt.idx) {
            log.warn("skipping interrupt: {s}", .{interrupt.name});
            continue;
        }

        if (interrupt.description) |description|
            try gen.write_doc_comment(db.gpa, description, writer);

        try writer.print("{}: Handler = unhandled,\n", .{
            std.zig.fmtId(interrupt.name),
        });

        index += 1;
    }

    try writer.writeAll("};\n\n");
}
