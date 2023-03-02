//! codegen specific to arm
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const gen = @import("../gen.zig");
const InterruptWithIndexAndName = @import("InterruptWithIndexAndName.zig");
const Interrupt = @import("Interrupt.zig");

const svd = @import("../svd.zig");

const log = std.log.scoped(.@"gen.arm");

// it's intended that these interrupts are added to the database in the
// different front-ends. This way this information is serialized for
// tooling

const system_interrupts = struct {
    // zig fmt: off
    const nmi           = Interrupt{ .index = -14, .name = "NMI" };
    const hard_fault    = Interrupt{ .index = -13, .name = "HardFault" };
    const mem_manage    = Interrupt{ .index = -12, .name = "MemManageFault" };
    const bus_fault     = Interrupt{ .index = -11, .name = "BusFault" };
    const usage_fault   = Interrupt{ .index = -10, .name = "UsageFault" };
    const secure_fault  = Interrupt{ .index = -9,  .name = "SecureFault" };
    const svcall        = Interrupt{ .index = -5,  .name = "SVCall" };
    const debug_monitor = Interrupt{ .index = -4,  .name = "DebugMonitor" };
    const pendsv        = Interrupt{ .index = -2,  .name = "PendSV" };
    const systick       = Interrupt{ .index = -1,  .name = "SysTick" };
    // zig fmt: on

    pub const cortex_m0 = [_]Interrupt{ nmi, hard_fault, svcall, pendsv };
    pub const cortex_m0plus = cortex_m0;
    pub const cortex_m1 = cortex_m0;
    pub const cortex_m23 = cortex_m0;

    pub const cortex_m3 = [_]Interrupt{ nmi, hard_fault, mem_manage, bus_fault, usage_fault, svcall, pendsv };
    pub const cortex_m4 = cortex_m3;
    pub const cortex_m7 = cortex_m3;

    pub const cortex_m33 = [_]Interrupt{ nmi, hard_fault, mem_manage, bus_fault, usage_fault, secure_fault, svcall, debug_monitor, pendsv };
    // The m35p was announced in 2018 and the technical reference manual does
    // not list the exceptions. It has been described as an m33 with some
    // upgrades, so I'm going give it the same exceptions
    pub const cortex_m35p = cortex_m33;
    // The m55 was announced in 2020 and I have about the same amount of information as the m35p
    pub const cortex_m55 = cortex_m33;
};

pub fn load_system_interrupts(db: *Database, device_id: EntityId) !void {
    const device = db.instances.devices.get(device_id).?;
    assert(device.arch.is_arm());

    inline for (@typeInfo(Database.Arch).Enum.fields) |field| {
        if (device.arch == @field(Database.Arch, field.name)) {
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
        log.warn("TODO: system interrupts handlers for {}", .{device.arch});
    }

    const vendor_systick_config = if (device.properties.get("cpu.vendorSystickConfig")) |str|
        try svd.parse_bool(str)
    else
        false;

    if (!vendor_systick_config) {
        _ = try db.create_interrupt(device_id, .{
            .name = system_interrupts.systick.name,
            .index = system_interrupts.systick.index,
        });
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
