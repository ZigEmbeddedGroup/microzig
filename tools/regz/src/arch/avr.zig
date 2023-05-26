//! codegen specific to AVR
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const gen = @import("../gen.zig");
const InterruptWithIndexAndName = @import("InterruptWithIndexAndName.zig");

const log = std.log.scoped(.@"gen.avr");

pub fn write_interrupt_vector(
    db: Database,
    device_id: EntityId,
    writer: anytype,
) !void {
    assert(db.entity_is("instance.device", device_id));
    const arch = db.instances.devices.get(device_id).?.arch;
    assert(arch.is_avr());

    try writer.writeAll(
        \\pub const VectorTable = extern struct {
        \\    const Handler = micro.interrupt.Handler;
        \\    const unhandled = micro.interrupt.unhandled;
        \\
        \\    RESET: Handler = unhandled,
        \\
    );

    if (db.children.interrupts.get(device_id)) |interrupt_set| {
        var interrupts = std.ArrayList(InterruptWithIndexAndName).init(db.gpa);
        defer interrupts.deinit();

        var it = interrupt_set.iterator();
        while (it.next()) |entry| {
            const interrupt_id = entry.key_ptr.*;
            const index = db.instances.interrupts.get(interrupt_id).?;
            const name = db.attrs.name.get(interrupt_id) orelse continue;

            try interrupts.append(.{
                .id = interrupt_id,
                .name = name,
                .index = index,
            });
        }

        std.sort.insertion(
            InterruptWithIndexAndName,
            interrupts.items,
            {},
            InterruptWithIndexAndName.less_than,
        );

        var index: i32 = 1;
        var i: u32 = 0;

        while (i < interrupts.items.len) : (i += 1) {
            const interrupt = interrupts.items[i];
            if (index < interrupt.index) {
                try writer.print("reserved{}: [{}]u16 = undefined,\n", .{
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

            try writer.print("{s}: Handler = unhandled,\n", .{
                std.zig.fmtId(interrupt.name),
            });

            index += 1;
        }
    }

    try writer.writeAll("};\n\n");
}
