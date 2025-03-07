//! codegen specific to arm
const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const DeviceID = Database.DeviceID;

const gen = @import("../gen.zig");
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

pub fn load_system_interrupts(db: *Database, device: *const Database.Device) !void {
    assert(device.arch.is_arm());

    inline for (@typeInfo(Database.Arch).Enum.fields) |field| {
        if (device.arch == @field(Database.Arch, field.name)) {
            if (@hasDecl(system_interrupts, field.name)) {
                for (@field(system_interrupts, field.name)) |interrupt| {
                    _ = try db.create_interrupt(device.id, .{
                        .name = interrupt.name,
                        .idx = interrupt.index,
                        .description = interrupt.description,
                    });
                }
            }

            break;
        }
    } else {
        log.warn("TODO: system interrupts handlers for {}", .{device.arch});
    }

    const vendor_systick_config = if (try db.get_device_property(db.gpa, device.id, "cpu.vendorSystickConfig")) |str| blk: {
        defer db.gpa.free(str);

        break :blk try svd.parse_bool(str);
    } else false;

    if (!vendor_systick_config) {
        _ = try db.create_interrupt(device.id, .{
            .name = system_interrupts.systick.name,
            .idx = system_interrupts.systick.index,
        });
    }
}

pub fn write_interrupt_vector(
    db: *Database,
    allocator: Allocator,
    device: *const Database.Device,
    writer: anytype,
) !void {
    assert(device.arch.is_arm());

    const interrupts = try db.get_interrupts(allocator, device.id);
    defer {
        for (interrupts) |interrupt| interrupt.deinit(allocator);
        allocator.free(interrupts);
    }

    if (interrupts.len > 0) {
        try writer.writeAll(
            \\
            \\pub const VectorTable = extern struct {
            \\    const Handler = micro.interrupt.Handler;
            \\    const unhandled = micro.interrupt.unhandled;
            \\
            \\    initial_stack_pointer: u32,
            \\    Reset: Handler,
            \\
        );

        var index: i32 = -14;
        var i: u32 = 0;

        while (i < interrupts.len) : (i += 1) {
            const interrupt = interrupts[i];
            if (index < interrupt.idx) {
                try writer.print("reserved{}: [{}]u32 = undefined,\n", .{
                    index + 14,
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
}
