//! codegen specific to arm
const std = @import("std");
const assert = std.debug.assert;

const Database = @import("../Database.zig");
const Arch = Database.Arch;
const EntityId = Database.EntityId;

const InterruptWithIndexAndName = @import("InterruptWithIndexAndName.zig");

const log = std.log.scoped(.@"gen.arm");

pub fn writeInterruptVector(
    db: Database,
    device_id: EntityId,
    writer: anytype,
) !void {
    assert(db.entityIs("instance.device", device_id));
    const arch = db.instances.devices.get(device_id).?.arch;
    assert(arch.isArm());

    log.warn("TODO: implement interrupt table for arch: {}", .{arch});

    _ = writer;
    //try writer.writeAll("pub const VectorTable = extern struct {\n");
    // TODO: fill
    //try writer.writeAll("};\n");
    return error.Todo;
}
