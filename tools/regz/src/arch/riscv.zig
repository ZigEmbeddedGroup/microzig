//! codegen specific to riscv
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const gen = @import("../gen.zig");
const InterruptWithIndexAndName = @import("InterruptWithIndexAndName.zig");

const log = std.log.scoped(.@"gen.riscv");

pub fn write_interrupt_vector(
    db: Database,
    device_id: EntityId,
    writer: anytype,
) !void {
    assert(db.entity_is("instance.device", device_id));
    const arch = db.instances.devices.get(device_id).?.arch;
    assert(arch.is_riscv());

    try writer.writeAll(
        \\pub const VectorTable = extern struct {
        \\    const Handler = micro.interrupt.Handler;
        \\    const unhandled = micro.interrupt.unhandled;
        \\
    );

    var index: i32 = 0;

    // CPU specific vectors
    switch (arch) {
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

    if (db.children.interrupts.get(device_id)) |interrupt_set| {
        var interrupts = std.ArrayList(InterruptWithIndexAndName).init(db.gpa);
        defer interrupts.deinit();

        var it = interrupt_set.iterator();
        while (it.next()) |entry| {
            const interrupt_id = entry.key_ptr.*;
            const interrupt_index = db.instances.interrupts.get(interrupt_id).?;
            const name = db.attrs.name.get(interrupt_id) orelse continue;

            try interrupts.append(.{
                .id = interrupt_id,
                .name = name,
                .index = interrupt_index,
            });
        }

        std.sort.insertion(
            InterruptWithIndexAndName,
            interrupts.items,
            {},
            InterruptWithIndexAndName.less_than,
        );

        for (interrupts.items) |interrupt| {
            if (index < interrupt.index) {
                try writer.print("reserved{}: [{}]u32 = undefined,\n", .{
                    index,
                    interrupt.index - index,
                });
                index = interrupt.index;
            } else if (index > interrupt.index) {
                log.warn("skipping interrupt: {s}", .{interrupt.name});
                continue;
            }

            if (db.attrs.description.get(interrupt.id)) |description|
                try gen.write_comment(db.gpa, description, writer);

            try writer.print("{}: Handler = unhandled,\n", .{
                std.zig.fmtId(interrupt.name),
            });

            index += 1;
        }
    }

    try writer.writeAll("};\n\n");
}
