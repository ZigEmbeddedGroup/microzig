const std = @import("std");
const Database = @import("../../Database.zig");
const EntityId = Database.EntityId;
const cortex_m0 = @import("cortex_m0.zig");

pub const add_nvic_fields = cortex_m0.add_nvic_fields;

pub fn add_core_registers(db: *Database, device_id: EntityId, scs_id: EntityId) !void {
    try cortex_m0.add_nvic_cluster(db, device_id, scs_id);
    try cortex_m0.add_scb_cluster(db, device_id, scs_id);

    const scnscb = try db.create_register_group(scs_id, .{
        .name = "SCnSCN",
        .description = "System Control and ID Register not in the SCB",
    });
    _ = try db.create_peripheral_instance(device_id, scnscb, .{
        .name = "SCnSCB",
        .offset = 0x0,
    });

    const actlr = try db.create_register(scnscb, .{
        .name = "ACTLR",
        .description = "Auxilary Control Register",
        .offset = 0x8,
        .size = 32,
    });

    _ = try db.create_field(actlr, .{ .name = "ITCMLAEN", .offset = 3, .size = 1 });
    _ = try db.create_field(actlr, .{ .name = "ITCMUAEN", .offset = 4, .size = 1 });
}
