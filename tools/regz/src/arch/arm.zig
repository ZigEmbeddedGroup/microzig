//! codegen specific to arm
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const gen = @import("../gen.zig");
const InterruptWithIndexAndName = @import("InterruptWithIndexAndName.zig");
const Interrupt = @import("Interrupt.zig");

const log = std.log.scoped(.@"gen.arm");

// it's intended that these interrupts are added to the database in the
// different front-ends. This way this information is serialized for
// tooling
pub const system_interrupts = struct {
    pub const cortex_m0 = [_]Interrupt{
        Interrupt{ .name = "NMI", .index = -14 },
        Interrupt{ .name = "HardFault", .index = -13 },
        Interrupt{ .name = "SVCall", .index = -5 },
        Interrupt{ .name = "PendSV", .index = -2 },
    };
    pub const cortex_m0plus = cortex_m0;
    pub const cortex_m3 = [_]Interrupt{
        Interrupt{ .name = "MemManageFault", .index = -12 },
        Interrupt{ .name = "BusFault", .index = -11 },
        Interrupt{ .name = "UsageFault", .index = -10 },
        Interrupt{ .name = "DebugMonitor", .index = -4 },
    } ++ cortex_m0;
    pub const cortex_m4 = cortex_m3;
};

pub fn load_systick_interrupt(db: *Database, device_id: EntityId) !void {
    _ = try db.create_interrupt(device_id, .{
        .name = "SysTick",
        .index = -1,
        // TODO: description
    });
}

pub fn load_system_interrupts(db: *Database, device_id: EntityId) !void {
    const arch = db.instances.devices.get(device_id).?.arch;
    assert(arch.is_arm());

    inline for (@typeInfo(Database.Arch).Enum.fields) |field| {
        if (arch == @field(Database.Arch, field.name)) {
            if (@hasDecl(system_interrupts, field.name)) {
                for (@field(system_interrupts, field.name)) |interrupt| {
                    _ = try db.create_interrupt(device_id, .{
                        .name = interrupt.name,
                        .index = interrupt.index,
                        .description = interrupt.description,
                    });
                }
            }

            break;
        }
    } else {
        log.warn("TODO: system interrupts handlers for {}", .{arch});
    }
}

pub fn write_interrupt_vector(
    db: Database,
    device_id: EntityId,
    writer: anytype,
) !void {
    assert(db.entity_is("instance.device", device_id));
    const arch = db.instances.devices.get(device_id).?.arch;
    assert(arch.is_arm());

    switch (arch) {
        // the basic vector table below should be fine for cortex-m
        .cortex_m0,
        .cortex_m0plus,
        .cortex_m1,
        .cortex_m23,
        .cortex_m3,
        .cortex_m33,
        .cortex_m35p,
        .cortex_m4,
        .cortex_m55,
        .cortex_m7,
        => {},
        else => {
            log.warn("TODO: exception handlers for {}", .{arch});
            return;
        },
    }

    try writer.writeAll(
        \\pub const VectorTable = extern struct {
        \\    const Handler = micro.interrupt.Handler;
        \\    const unhandled = micro.interrupt.unhandled;
        \\
        \\    initial_stack_pointer: u32,
        \\    Reset: Handler = unhandled,
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

        switch (arch) {
            else => log.warn("TODO: exception handlers for {}", .{arch}),
        }

        std.sort.sort(
            InterruptWithIndexAndName,
            interrupts.items,
            {},
            InterruptWithIndexAndName.less_than,
        );

        var index: i32 = -14;
        var i: u32 = 0;

        while (i < interrupts.items.len) : (i += 1) {
            const interrupt = interrupts.items[i];
            if (index < interrupt.index) {
                try writer.print("reserved{}: [{}]u32 = undefined,\n", .{
                    index + 14,
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
