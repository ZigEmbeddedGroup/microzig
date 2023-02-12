const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;
const cortex_m0 = @import("cortex_m0.zig");

pub const addNvicFields = cortex_m0.addNvicFields;

pub fn addCoreRegisters(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    try cortex_m0.addNvicCluster(db, device_id, scs_id);
    try cortex_m0.addScbCluster(db, device_id, scs_id);

    const scnscb = try db.createRegisterGroup(scs_id, .{
        .name = "SCnSCN",
        .description = "System Control and ID Register not in the SCB",
    });
    _ = try db.createPeripheralInstance(device_id, scnscb, .{
        .name = "SCnSCB",
        .offset = 0x0,
    });

    const actlr = try db.createRegister(scnscb, .{
        .name = "ACTLR",
        .description = "Auxilary Control Register",
        .offset = 0x8,
        .size = 32,
    });

    _ = try db.createField(actlr, .{ .name = "ITCMLAEN", .offset = 3, .size = 1 });
    _ = try db.createField(actlr, .{ .name = "ITCMUAEN", .offset = 4, .size = 1 });
}
