const std = @import("std");
const Database = @import("../Database.zig");
const Register = @import("../Register.zig");
const Field = @import("../Field.zig");
const cortex_m0 = @import("cortex_m0.zig");

pub fn addCoreRegisters(db: *Database, scs: Database.PeripheralIndex) !void {
    try cortex_m0.addNvicCluster(db, scs);
    try cortex_m0.addScbCluster(db, scs);

    const scbnscn = try db.addClusterToPeripheral(scs, .{
        .name = "SCBnSCN",
        .description = "System Control and ID Register not in the SCB",
        .addr_offset = 0x0,
    });

    const regs = try db.addRegistersToCluster(scbnscn, &.{
        .{
            .name = "ACTLR",
            .addr_offset = 0x8,
            .description = "Auxilary Control Register",
        },
    });

    const actlr = regs.begin;
    try db.addFieldsToRegister(actlr, &.{
        .{ .name = "ITCMLAEN", .offset = 3, .width = 1 },
        .{ .name = "ITCMUAEN", .offset = 4, .width = 1 },
    });
}
